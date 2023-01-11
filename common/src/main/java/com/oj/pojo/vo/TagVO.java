package com.oj.pojo.vo;

import com.oj.pojo.entity.Tag;
import com.oj.pojo.entity.TagClassification;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class TagVO implements Serializable {

    private TagClassification classification;

    private List<Tag> tagList;
}
