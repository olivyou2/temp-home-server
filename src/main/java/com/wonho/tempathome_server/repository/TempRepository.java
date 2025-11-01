package com.wonho.tempathome_server.repository;

import com.wonho.tempathome_server.entity.TempLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TempRepository extends JpaRepository<TempLog, Long> {
    List<TempLog> findAllByTimeAfter(LocalDateTime localDateTime);
}
