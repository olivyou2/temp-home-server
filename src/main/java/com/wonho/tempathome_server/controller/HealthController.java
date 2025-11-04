package com.wonho.tempathome_server.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/api/health")
@Controller
@RequiredArgsConstructor
public class HealthController {
    @GetMapping("/")
    public ResponseEntity <?> checkHealth(){
        return ResponseEntity.ok().body("OK");
    }
}
