package com.ogani.api.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "order_tracking")
public class OrderTracking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tracking_id")
    private Integer trackingId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    @Column(name = "status_update", nullable = false, length = 100)
    private String statusUpdate;

    @Builder.Default
    private LocalDateTime timestamp = LocalDateTime.now();

    @Column(name = "courier_location", length = 100)
    private String courierLocation;

    @Column(name = "courier_info", columnDefinition = "TEXT")
    private String courierInfo;
}
