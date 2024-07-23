package com.example.az204;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/product")
@RefreshScope
public class ProductController {

    @Value("${spring.inventory.password}")
    public String inventoryPassword;

    @GetMapping
    public ResponseEntity<String> getListProducts(){
        return ResponseEntity.ok(inventoryPassword);
    }
}
