package com.oj.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.oj.pojo.entity.Tag;

public interface TagService extends IService<Tag> {
    void addTag(Tag tag);

    void deleteTag(Long id);

    void updateTag(Tag tag);
}
