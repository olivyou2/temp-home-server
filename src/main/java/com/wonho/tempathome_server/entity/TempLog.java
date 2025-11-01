package com.wonho.tempathome_server.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TempLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime time;
    private Double temperature;
    private Double humidity;

    @PrePersist
    public void prePersist(){
        time = LocalDateTime.now();
    }
}
