package com.ogani.api.seeder;

import com.ogani.api.model.*;
import com.ogani.api.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.security.crypto.password.PasswordEncoder;
import jakarta.persistence.EntityManager;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Component
@RequiredArgsConstructor
public class DatabaseSeeder implements CommandLineRunner {

    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;
    private final PromoRepository promoRepository;
    private final ReviewRepository reviewRepository;
    private final PaymentMethodRepository paymentMethodRepository;
    private final UserAddressRepository userAddressRepository;
    private final NotificationRepository notificationRepository;
    private final PasswordEncoder passwordEncoder;
    private final EntityManager entityManager;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        // Removed automatic truncation to prevent data loss on restart
        if (userRepository.count() == 0) seedUsers();
        if (categoryRepository.count() == 0) seedCategoriesAndProducts();
        if (promoRepository.count() == 0) seedPromos();
        if (paymentMethodRepository.count() == 0) seedPaymentMethods();
        if (orderRepository.count() == 0) seedOrdersAndReviews();
        if (reviewRepository.count() < 10) seedReviews();
        if (notificationRepository.count() == 0) seedNotifications();
    }

    private void seedUsers() {
        User superAdmin = User.builder().username("admin").email("admin@ogani.com").fullName("Super Admin").password(passwordEncoder.encode("admin123")).role(User.Role.ADMIN).build();
        User customer1 = User.builder().username("johndoe").email("john@example.com").fullName("John Doe").password(passwordEncoder.encode("password")).role(User.Role.CUSTOMER).totalPoints(150).build();
        User customer2 = User.builder().username("alicesmith").email("alice@example.com").fullName("Alice Smith").password(passwordEncoder.encode("password")).role(User.Role.CUSTOMER).totalPoints(300).build();
        userRepository.saveAll(Arrays.asList(superAdmin, customer1, customer2));

        UserAddress address = UserAddress.builder().user(customer1).fullAddress("123 Main St, Jakarta 10000").build();
        userAddressRepository.save(address);
    }

    private void seedCategoriesAndProducts() {
        Category fruits = Category.builder().categoryName("Fresh Fruits").image("https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=800").build();
        Category vegetables = Category.builder().categoryName("Vegetables").image("https://images.pexels.com/photos/1414651/pexels-photo-1414651.jpeg?auto=compress&cs=tinysrgb&w=800").build();
        Category meats = Category.builder().categoryName("Fresh Meat").image("https://images.pexels.com/photos/6187720/pexels-photo-6187720.jpeg?auto=compress&cs=tinysrgb&w=800").build();
        categoryRepository.saveAll(Arrays.asList(fruits, vegetables, meats));

        Product p1 = Product.builder().productName("Fresh Apples").price(new BigDecimal("45000.00")).category(fruits).stock(50).productImage("https://images.pexels.com/photos/205926/pexels-photo-205926.jpeg?auto=compress&cs=tinysrgb&w=800").build();
        Product p2 = Product.builder().productName("Bananas").price(new BigDecimal("25000.00")).category(fruits).stock(100).productImage("https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=800").build();
        Product p3 = Product.builder().productName("Carrots").price(new BigDecimal("15000.00")).category(vegetables).stock(80).productImage("https://images.pexels.com/photos/143133/pexels-photo-143133.jpeg?auto=compress&cs=tinysrgb&w=800").build();
        Product p4 = Product.builder().productName("Beef Steak").price(new BigDecimal("150000.00")).category(meats).stock(20).productImage("https://images.pexels.com/photos/361184/asparagus-steak-veal-steak-veal-361184.jpeg?auto=compress&cs=tinysrgb&w=800").build();
        productRepository.saveAll(Arrays.asList(p1, p2, p3, p4));
    }

    private void seedPromos() {
        Promo promo1 = Promo.builder().promoCode("WELCOME50").title("Welcome Discount").discountValue(new BigDecimal("50000.00")).expirationDate(LocalDateTime.now().plusMonths(1)).build();
        Promo promo2 = Promo.builder().promoCode("FRESH20").title("Fresh Produce Discount").discountValue(new BigDecimal("20000.00")).expirationDate(LocalDateTime.now().plusDays(15)).build();
        promoRepository.saveAll(Arrays.asList(promo1, promo2));
    }

    private void seedPaymentMethods() {
        PaymentMethod pm1 = PaymentMethod.builder().type("Credit Card").provider("Visa").build();
        PaymentMethod pm2 = PaymentMethod.builder().type("E-Wallet").provider("GoPay").build();
        paymentMethodRepository.saveAll(Arrays.asList(pm1, pm2));
    }

    private void seedOrdersAndReviews() {
        List<User> users = userRepository.findAll();
        List<Product> products = productRepository.findAll();
        if(users.size() < 2 || products.isEmpty()) return;
        
        User customer = users.get(1);
        User customer2 = users.get(2);
        Product product1 = products.get(0);
        Product product2 = products.get(1);

        for (int i = 0; i < 20; i++) {
            LocalDateTime orderTime = LocalDateTime.now().minusDays(i * 9);
            Order.OrderStatus status = i % 4 == 0 ? Order.OrderStatus.pending : Order.OrderStatus.completed;
            User u = i % 2 == 0 ? customer : customer2;
            Order order = Order.builder()
                    .invoiceCode("INV-" + (1000 + i))
                    .user(u)
                    .totalPrice(new BigDecimal(150000 + (i * 25000)))
                    .orderStatus(status)
                    .orderTime(orderTime)
                    .build();
            orderRepository.save(order);
        }

        Review review1 = Review.builder().user(customer).product(product1).rating(5).content("Very fresh and delicious!").title("Great Apples").build();
        Review review2 = Review.builder().user(customer2).product(product2).rating(4).content("Good quality, fast delivery.").title("Nice Bananas").build();
        reviewRepository.saveAll(Arrays.asList(review1, review2));
    }

    private void seedReviews() {
        List<User> users = userRepository.findAll();
        List<Product> products = productRepository.findAll();
        if(users.size() < 2 || products.isEmpty()) return;
        
        User customer1 = users.get(1);
        User customer2 = users.get(2);
        
        for (int i = 0; i < 15; i++) {
            Product p = products.get(i % products.size());
            User u = i % 2 == 0 ? customer1 : customer2;
            int rating = 3 + (i % 3);
            Review r = Review.builder()
                .user(u)
                .product(p)
                .rating(rating)
                .content("Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review " + i + ")")
                .title("Sangat Puas " + i)
                .reviewDate(LocalDateTime.now().minusDays(i))
                .build();
            reviewRepository.save(r);
        }
    }

    private void seedNotifications() {
        List<User> users = userRepository.findAll();
        if (users.size() < 2) return;
        
        User customer1 = users.get(1);
        User customer2 = users.get(2);
        
        List<Notification> notifs = Arrays.asList(
            Notification.builder()
                .user(customer1)
                .title("Welcome to Ogani!")
                .message("We are glad to have you here. Check out our fresh products.")
                .type("INFO")
                .isRead(false)
                .timestamp(LocalDateTime.now().minusDays(1))
                .build(),
            Notification.builder()
                .user(customer1)
                .title("Promo Alert: FRESH20")
                .message("Use promo code FRESH20 for Rp 20.000 off your next purchase!")
                .type("PROMO")
                .isRead(false)
                .timestamp(LocalDateTime.now().minusHours(5))
                .build(),
            Notification.builder()
                .user(customer2)
                .title("Order Completed")
                .message("Your order has been delivered successfully. Enjoy your fresh produce!")
                .type("ORDER")
                .isRead(true)
                .timestamp(LocalDateTime.now().minusDays(2))
                .build(),
            Notification.builder()
                .user(customer2)
                .title("Special Discount")
                .message("You have earned a special discount on meat products.")
                .type("PROMO")
                .isRead(false)
                .timestamp(LocalDateTime.now().minusHours(2))
                .build()
        );
        
        notificationRepository.saveAll(notifs);
    }
}
