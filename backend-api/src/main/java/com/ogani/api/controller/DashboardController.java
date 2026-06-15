package com.ogani.api.controller;

import com.ogani.api.dto.response.ApiResponse;
import com.ogani.api.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/dashboard")
@RequiredArgsConstructor
public class DashboardController {
    private final DashboardService dashboardService;

    @GetMapping("/stats")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getStats(
            @RequestParam(required = false) Integer days) {
        Map<String, Object> stats = dashboardService.getStats(days);
        return ResponseEntity.ok(ApiResponse.success(stats));
    }

    @GetMapping("/export")
    public ResponseEntity<byte[]> exportCsv(@RequestParam(required = false) Integer days) {
        String csv = dashboardService.generateCsvReport(days);
        byte[] csvBytes = csv.getBytes(java.nio.charset.StandardCharsets.UTF_8);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("text/csv"));
        headers.setContentDispositionFormData("attachment", "dashboard_report.csv");

        return ResponseEntity.ok()
                .headers(headers)
                .body(csvBytes);
    }

    @GetMapping("/report-data")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getReportData(
            @RequestParam(required = false) Integer days) {
        Map<String, Object> data = dashboardService.getReportData(days);
        return ResponseEntity.ok(ApiResponse.success(data));
    }
}
