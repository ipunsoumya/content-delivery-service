package com.content.service.controller;

import com.content.service.dto.ContentRequestDto;
import com.content.service.dto.ContentResponseDto;
import com.content.service.service.ContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/content")
public class ContentController {

    @Autowired
    private ContentService contentService;

    @GetMapping("/{id}")
    public ResponseEntity<ContentResponseDto> getContent(@PathVariable  String id) {
        ContentResponseDto responseDto = contentService.getContentById(id);
        return ResponseEntity.ok(responseDto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ContentResponseDto> updateContent(@PathVariable String id, @RequestBody ContentRequestDto contentRequestDto) {
        ContentResponseDto responseDto = contentService.updateContent(id, contentRequestDto);
        return ResponseEntity.ok(responseDto);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteContent(@PathVariable String id) {
        contentService.deleteContent(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping
    public ResponseEntity<ContentResponseDto> createContent(@RequestBody  ContentRequestDto contentRequestDto) {
        ContentResponseDto content = contentService.createContent(contentRequestDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(content);
    }
}
