package com.content.service.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ContentRequestDto {
    private String title;
    private List<String> tags;
    private String body;
}
