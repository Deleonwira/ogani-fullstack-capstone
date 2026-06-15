package com.ogani.api.controller;

import com.ogani.api.dto.response.ApiResponse;
import com.ogani.api.model.User;
import com.ogani.api.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    @GetMapping
    public ResponseEntity<ApiResponse<List<User>>> getAllUsers() {
        List<User> users = userService.getAllUsers();
        return ResponseEntity.ok(ApiResponse.success(users));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<User>> getUserById(@PathVariable Integer id) {
        User user = userService.getUserById(id);
        return ResponseEntity.ok(ApiResponse.success(user));
    }

    @PutMapping("/{id}/role")
    public ResponseEntity<ApiResponse<User>> updateUserRole(@PathVariable Integer id, @RequestBody Map<String, String> payload) {
        User updatedUser = userService.updateUserRole(id, payload.get("role"));
        return ResponseEntity.ok(ApiResponse.success(updatedUser));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteUser(@PathVariable Integer id) {
        userService.deleteUser(id);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<User>> updateProfile(@PathVariable Integer id, @RequestBody com.ogani.api.dto.request.UserUpdateRequest request) {
        User updatedUser = userService.updateProfile(id, request);
        return ResponseEntity.ok(ApiResponse.success(updatedUser, "Profil berhasil diperbarui"));
    }

    @PutMapping("/{id}/password")
    public ResponseEntity<ApiResponse<Void>> updatePassword(@PathVariable Integer id, @RequestBody com.ogani.api.dto.request.PasswordUpdateRequest request) {
        userService.updatePassword(id, request, passwordEncoder);
        return ResponseEntity.ok(ApiResponse.success(null, "Password updated successfully"));
    }
}
