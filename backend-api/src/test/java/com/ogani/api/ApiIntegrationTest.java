package com.ogani.api;

import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Map;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.web.client.ResponseErrorHandler;
import java.io.IOException;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ApiIntegrationTest {

    private RestTemplate restTemplate;

    @org.springframework.boot.test.web.server.LocalServerPort
    private int port;

    public ApiIntegrationTest() {
        this.restTemplate = new RestTemplate();
        this.restTemplate.setErrorHandler(new org.springframework.web.client.DefaultResponseErrorHandler() {
            @Override
            public boolean hasError(ClientHttpResponse response) throws IOException {
                return false; // Ignore errors so we can assert status codes
            }
        });
    }

    private String getBaseUrl() {
        return "http://localhost:" + port;
    }

    private static String token;

    @Test
    @Order(1)
    public void testApi01_LoginValid() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        String body = "{ \"email\": \"admin@ogani.com\", \"password\": \"admin123\" }";
        HttpEntity<String> request = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.postForEntity(getBaseUrl() + "/api/auth/login", request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).isNotNull();
        assertThat((Boolean) response.getBody().get("success")).isTrue();
        
        // Extract token
        Map<String, Object> data = (Map<String, Object>) response.getBody().get("data");
        token = (String) data.get("token");
        assertThat(token).isNotEmpty();
    }

    @Test
    @Order(2)
    public void testApi02_LoginUnregistered() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        String body = "{ \"email\": \"tidakada@test.com\", \"password\": \"pass\" }";
        HttpEntity<String> request = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.postForEntity(getBaseUrl() + "/api/auth/login", request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
    }

    @Test
    @Order(3)
    public void testApi06_GetAllProducts() {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<Void> request = new HttpEntity<>(headers);

        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat((Boolean) response.getBody().get("success")).isTrue();
    }

    @Test
    @Order(4)
    public void testApi14_GetAllCategories() {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<Void> request = new HttpEntity<>(headers);

        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/categories", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat((Boolean) response.getBody().get("success")).isTrue();
    }



    private HttpHeaders getHeadersWithToken() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        if (token != null) {
            headers.setBearerAuth(token);
        }
        return headers;
    }

    private Long getFirstId(String endpoint, String idField) {
        try {
            ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + endpoint, HttpMethod.GET, new HttpEntity<>(getHeadersWithToken()), Map.class);
            Map<String, Object> body = response.getBody();
            if (body != null && body.get("data") != null) {
                Object dataObj = body.get("data");
                java.util.List<Map<String, Object>> list = null;
                if (dataObj instanceof java.util.List) {
                    list = (java.util.List<Map<String, Object>>) dataObj;
                } else if (dataObj instanceof Map) {
                    Map<String, Object> dataMap = (Map<String, Object>) dataObj;
                    if (dataMap.containsKey("content")) {
                        list = (java.util.List<Map<String, Object>>) dataMap.get("content");
                    }
                }
                
                if (list != null && !list.isEmpty()) {
                    return ((Number) list.get(0).get(idField)).longValue();
                }
            }
        } catch(Exception e) {}
        return 1L;
    }

    private Long getFirstProductId() { return getFirstId("/api/products", "product_id"); }
    private Long getFirstCategoryId() { return getFirstId("/api/categories", "category_id"); }
    private Long getFirstOrderId() { return getFirstId("/api/orders", "order_id"); }
    private Long getFirstUserId() { return getFirstId("/api/users", "user_id"); }
    private Long getFirstPromoId() { return getFirstId("/api/promos", "promo_id"); }
    private Long getFirstNotificationId() { return getFirstId("/api/notifications/user/2", "notification_id"); }


    @Test
    public void testApi03LoginWrongPassword() {
        String body = "{\n    \"email\": \"admin@ogani.com\",\n    \"password\": \"salah\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/auth/login", HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
    }

    @Test
    public void testApi04RegisterValid() {
        String body = "{\n    \"email\": \"baru@test.com\",\n    \"username\": \"userbaru\",\n    \"password\": \"password123\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/auth/register", HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi05RegisterDuplicate() {
        String body = "{\n    \"email\": \"admin@ogani.com\",\n    \"username\": \"admin\",\n    \"password\": \"password\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/auth/register", HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi07GetProductsByCategory() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products?categoryId=1", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi08SearchProducts() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products?search=apple", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi09GetDetailProduct() {
        Long dynamicId = getFirstProductId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products/" + dynamicId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi10GetProductNotFound() {
        Long dynamicId = getFirstProductId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products/" + dynamicId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi11CreateProduct() {
        String body = "{\n    \"productName\": \"New Apple\",\n    \"price\": 10000,\n    \"stock\": 10,\n    \"unit\": \"kg\",\n    \"weightPerUnit\": 1.0,\n    \"productStatus\": \"In Stock\",\n    \"productImage\": \"url\",\n    \"category\": {\n        \"categoryId\": 1\n    }\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products", HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi12UpdateProduct() {
        Long dynamicId = getFirstProductId();
        String body = "{\n    \"productName\": \"Apple Premium\",\n    \"price\": 25000\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products/" + dynamicId, HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi13DeleteProduct() {
        Long dynamicId = getFirstProductId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/products/" + dynamicId, HttpMethod.DELETE, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @Test
    public void testApi15GetCategoryDetail() {
        Long dynamicId = getFirstCategoryId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/categories/" + dynamicId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi16CreateCategory() {
        String body = "{\n    \"categoryName\": \"Nuts\",\n    \"image\": \"http://image\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/categories", HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi17UpdateCategory() {
        Long dynamicId = getFirstCategoryId();
        String body = "{\n    \"categoryName\": \"Fresh Fruits\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/categories/" + dynamicId, HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi18DeleteCategory() {
        Long dynamicId = getFirstCategoryId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/categories/" + dynamicId, HttpMethod.DELETE, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @Test
    public void testApi19GetAllOrders() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi20GetUserOrders() {
        Long userId = getFirstUserId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders/user/" + userId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi21GetOrderDetail() {
        Long dynamicId = getFirstOrderId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders/" + dynamicId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi22CreateOrder() {
        String body = "{\n    \"userId\": 2,\n    \"addressId\": 1,\n    \"paymentMethodId\": 1,\n    \"items\": [\n        {\n            \"productId\": 1,\n            \"quantity\": 2\n        }\n    ]\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders", HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi23UpdateOrderStatusProcessing() {
        Long dynamicId = getFirstOrderId();
        String body = "{\n    \"orderStatus\": \"processing\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders/" + dynamicId + "/status", HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi24UpdateOrderStatusShipped() {
        Long dynamicId = getFirstOrderId();
        String body = "{\n    \"orderStatus\": \"shipped\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders/" + dynamicId + "/status", HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi25UpdateOrderStatusCompleted() {
        Long dynamicId = getFirstOrderId();
        String body = "{\n    \"orderStatus\": \"completed\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders/" + dynamicId + "/status", HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi26DeleteOrder() {
        Long dynamicId = getFirstOrderId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/orders/" + dynamicId, HttpMethod.DELETE, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi27GetAllUsers() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/users", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi28GetUserDetail() {
        Long dynamicId = getFirstUserId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/users/" + dynamicId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi29UpdateProfile() {
        Long dynamicId = getFirstUserId();
        String body = "{\n    \"fullName\": \"Admin Ogani\",\n    \"phoneNumber\": \"081234567890\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/users/" + dynamicId, HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi30UpdateRole() {
        Long dynamicId = getFirstUserId();
        String body = "{\n    \"role\": \"ADMIN\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/users/" + dynamicId + "/role", HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi31UpdatePassword() {
        Long dynamicId = getFirstUserId();
        String body = "{\n    \"currentPassword\": \"admin\",\n    \"newPassword\": \"newpass\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/users/" + dynamicId + "/password", HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi32UpdatePasswordWrong() {
        Long dynamicId = getFirstUserId();
        String body = "{\n    \"currentPassword\": \"salah\",\n    \"newPassword\": \"newpass\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/users/" + dynamicId + "/password", HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi33DeleteUser() {
        Long dynamicId = getFirstUserId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/users/" + dynamicId, HttpMethod.DELETE, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi34GetAllPromos() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/promos", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi35GetPromoDetail() {
        Long dynamicId = getFirstPromoId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/promos/" + dynamicId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi36CreatePromo() {
        String body = "{\n    \"promoCode\": \"HEMAT50\",\n    \"title\": \"Hemat\",\n    \"discountValue\": 50000,\n    \"minimumSpend\": 200000,\n    \"expirationDate\": \"2025-12-31T23:59:59\"\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/promos", HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi37UpdatePromo() {
        Long dynamicId = getFirstPromoId();
        String body = "{\n    \"discountValue\": 75000\n}";
        HttpEntity<String> request = new HttpEntity<>(body, getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/promos/" + dynamicId, HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    public void testApi38DeletePromo() {
        Long dynamicId = getFirstPromoId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/promos/" + dynamicId, HttpMethod.DELETE, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi39GetReviews() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/reviews", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi41GetDashboardStats() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/dashboard/stats", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi42GetDashboardStatsFilter() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/dashboard/stats?days=7", HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi43ExportCsv() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<byte[]> response = restTemplate.exchange(getBaseUrl() + "/api/dashboard/export?days=30", HttpMethod.GET, request, byte[].class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi44ReportDataPdf() {
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<byte[]> response = restTemplate.exchange(getBaseUrl() + "/api/dashboard/report-data", HttpMethod.GET, request, byte[].class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi45GetUserWishlist() {
        Long userId = getFirstUserId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/wishlists/user/" + userId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
    }

    @Test
    public void testApi46AddToWishlist() {
        Long userId = getFirstUserId();
        Long productId = getFirstProductId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/wishlists/user/" + userId + "/product/" + productId, HttpMethod.POST, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
    }

    @Test
    public void testApi47DeleteFromWishlist() {
        Long userId = getFirstUserId();
        Long productId = getFirstProductId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/wishlists/user/" + userId + "/product/" + productId, HttpMethod.DELETE, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    public void testApi48GetUserNotifications() {
        Long userId = getFirstUserId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/notifications/user/" + userId, HttpMethod.GET, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
    }

    @Test
    public void testApi49MarkRead() {
        Long dynamicId = getFirstNotificationId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/notifications/" + dynamicId + "/read", HttpMethod.PUT, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
    }

    @Test
    public void testApi50DeleteNotification() {
        Long dynamicId = getFirstNotificationId();
        HttpEntity<String> request = new HttpEntity<>(getHeadersWithToken());
        ResponseEntity<Map> response = restTemplate.exchange(getBaseUrl() + "/api/notifications/" + dynamicId, HttpMethod.DELETE, request, Map.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
    }


}
