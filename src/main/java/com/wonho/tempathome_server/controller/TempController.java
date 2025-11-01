package com.wonho.tempathome_server.controller;

import com.wonho.tempathome_server.entity.TempLog;
import com.wonho.tempathome_server.service.TempService;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.Parameter;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/api/temp")
@Controller
@RequiredArgsConstructor
public class TempController {
    private final TempService tempService;

    @PostMapping("/")
    public ResponseEntity<?> createLog(Double temp, Double hum){
        TempLog log = TempLog.builder().humidity(hum).temperature(temp).build();

        tempService.createLog(log);
        return ResponseEntity.ok().build();
    };

    @GetMapping("/")
    public ResponseEntity<?> listLog(Long hours){
        List<TempLog> logs = tempService.findLastHours(hours);
        return  ResponseEntity.ok().body(logs);
    }
}
