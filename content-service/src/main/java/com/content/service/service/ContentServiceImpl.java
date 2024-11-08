package com.content.service.service;

import com.content.service.dto.ContentRequestDto;
import com.content.service.dto.ContentResponseDto;
import com.content.service.exception.ResourceNotFoundException;
import com.content.service.model.Content;
import com.content.service.repository.ContentRepository;
import org.bson.types.ObjectId;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ContentServiceImpl implements ContentService{

    @Autowired
    private ContentRepository contentRepository;
    @Autowired
    private ModelMapper modelMapper;

    @Override
    public ContentResponseDto getContentById(String id) {
        Content content = contentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Content not found with id: " + id));
        modelMapper.map(content, ContentResponseDto.class);
        return modelMapper.map(content, ContentResponseDto.class);
    }

    @Override
    public ContentResponseDto createContent(ContentRequestDto contentRequestDto) {
        Content content = modelMapper.map(contentRequestDto, Content.class);
        content = contentRepository.save(content);
        return modelMapper.map(content, ContentResponseDto.class);
    }

    @Override
    public ContentResponseDto updateContent(String id, ContentRequestDto contentRequestDto) {
        Content content = contentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Content not found with id: " + id));
        modelMapper.map(contentRequestDto, content);
        content.setModifiedTimestamp(LocalDateTime.now());
        content = contentRepository.save(content);
        return modelMapper.map(content, ContentResponseDto.class);
    }

    @Override
    public void deleteContent(String id) {
        Content content = contentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Content not found with id: " + id));
        contentRepository.delete(content);
    }
}