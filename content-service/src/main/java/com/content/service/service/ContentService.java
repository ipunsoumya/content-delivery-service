package com.content.service.service;

import com.content.service.dto.ContentRequestDto;
import com.content.service.dto.ContentResponseDto;

import java.util.List;

public interface ContentService {
    ContentResponseDto getContentById(String id);
    ContentResponseDto createContent(ContentRequestDto contentRequestDto);
    ContentResponseDto updateContent(String id, ContentRequestDto contentRequestDto);
    void deleteContent(String id);
    List<ContentResponseDto> getAllContent();
    List<ContentResponseDto> searchContent(String query);
}
