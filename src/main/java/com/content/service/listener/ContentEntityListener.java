package com.content.service.listener;

import com.content.service.model.Content;
import org.springframework.context.event.EventListener;
import org.springframework.data.mongodb.core.mapping.event.BeforeConvertEvent;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class ContentEntityListener {

    @EventListener
    public void onBeforeConvert(BeforeConvertEvent<Content> event) {
        Content content = event.getSource();
        if (content.getCreatedTimestamp() == null)
            content.setCreatedTimestamp(LocalDateTime.now());
        content.setModifiedTimestamp(LocalDateTime.now());
    }
}
