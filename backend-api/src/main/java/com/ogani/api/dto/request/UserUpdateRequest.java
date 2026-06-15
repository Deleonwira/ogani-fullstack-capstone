package com.ogani.api.dto.request;

import lombok.Data;
import java.time.LocalDate;

@Data
public class UserUpdateRequest {
    private String username;
    private String email;
    private String fullName;
    private String phoneNumber;
    private LocalDate birthDate;
    private String address;
}
