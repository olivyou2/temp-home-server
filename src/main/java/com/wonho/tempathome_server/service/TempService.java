package com.wonho.tempathome_server.service;

import com.wonho.tempathome_server.entity.TempLog;
import com.wonho.tempathome_server.repository.TempRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TempService {
    private final TempRepository tempRepository;

    public void save(TempLog tempLog){
        tempRepository.save(tempLog);
    }

    public List<TempLog> findLastHours(Long hours) {
        return tempRepository.findAllByTimeAfter(LocalDateTime.now().minusHours(hours));
    }

    public List<TempLog> findLastMinutes(Long minutes){
        return tempRepository.findAllByTimeAfter(LocalDateTime.now().minusMinutes(minutes));
    }

    public void createLog(TempLog tempLog){
        tempRepository.save(tempLog);
    }
}
