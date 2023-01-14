package com.oj.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.oj.pojo.entity.Tag;
import com.oj.pojo.entity.TagClassification;
import com.oj.pojo.vo.TagVO;

import java.util.List;

public interface TagClassificationService extends IService<TagClassification> {

    List<TagVO> getTagAndTagClassification();

    void addTagClassification(TagClassification tagClassification);

    void deleteTagClassification(Long id);

    void updateTagClassification(TagClassification tagClassification);
}
