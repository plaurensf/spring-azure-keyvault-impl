package com.example.az204;

import com.azure.security.keyvault.secrets.SecretClient;
import lombok.RequiredArgsConstructor;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/product")
@RefreshScope
@RequiredArgsConstructor
public class ProductController {

    private final SecretClient secretClient;

    @GetMapping
    public ResponseEntity<String> getListProducts(){
        return ResponseEntity.ok(secretClient.getSecret("inventory-app-secret").getValue());
    }
}
