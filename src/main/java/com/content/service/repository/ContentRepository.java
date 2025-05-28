package com.content.service.repository;

import com.content.service.model.Content;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ContentRepository extends MongoRepository<Content, String> {
    List<Content> findByTagsIn(List<String> tags);
//    List<Content> searchContent(String query);
}
