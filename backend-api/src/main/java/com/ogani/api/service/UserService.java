package com.ogani.api.service;

import com.ogani.api.exception.ResourceNotFoundException;
import com.ogani.api.model.User;
import com.ogani.api.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserById(Integer id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + id));
    }

    public User updateUserRole(Integer id, String roleStr) {
        User user = getUserById(id);
        User.Role role = User.Role.valueOf(roleStr.toUpperCase());
        user.setRole(role);
        return userRepository.save(user);
    }

    public void updatePassword(Integer id, com.ogani.api.dto.request.PasswordUpdateRequest request, org.springframework.security.crypto.password.PasswordEncoder passwordEncoder) {
        User user = getUserById(id);
        
        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
            throw new com.ogani.api.exception.BadRequestException("Kata sandi saat ini tidak cocok");
        }
        
        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
    }

    public User updateProfile(Integer id, com.ogani.api.dto.request.UserUpdateRequest request) {
        User user = getUserById(id);

        if (request.getUsername() != null && !request.getUsername().equals(user.getUsername())) {
            if (userRepository.existsByUsernameAndUserIdNot(request.getUsername(), id)) {
                throw new com.ogani.api.exception.BadRequestException("Nama pengguna (username) sudah digunakan.");
            }
            user.setUsername(request.getUsername());
        }

        if (request.getEmail() != null && !request.getEmail().equals(user.getEmail())) {
            if (userRepository.existsByEmailAndUserIdNot(request.getEmail(), id)) {
                throw new com.ogani.api.exception.BadRequestException("Email sudah terdaftar.");
            }
            user.setEmail(request.getEmail());
        }

        if (request.getFullName() != null) user.setFullName(request.getFullName());
        if (request.getPhoneNumber() != null) user.setPhoneNumber(request.getPhoneNumber());
        if (request.getAddress() != null) user.setAddress(request.getAddress());
        if (request.getBirthDate() != null) {
            user.setBirthDate(request.getBirthDate());
            user.setAge(java.time.Period.between(request.getBirthDate(), java.time.LocalDate.now()).getYears());
        }

        return userRepository.save(user);
    }

    public void deleteUser(Integer id) {
        User user = getUserById(id);
        userRepository.delete(user);
    }
}
