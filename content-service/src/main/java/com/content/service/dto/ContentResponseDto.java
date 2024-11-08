package com.content.service.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class ContentResponseDto {
    private String id;
    private String title;
    private List<String> tags;
    private String body;
    private LocalDateTime createdTimestamp;
    private LocalDateTime modifiedTimestamp;
}
