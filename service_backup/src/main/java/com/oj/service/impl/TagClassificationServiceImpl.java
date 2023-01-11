package com.oj.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.oj.mapper.TagClassificationMapper;
import com.oj.mapper.TagMapper;
import com.oj.pojo.entity.Tag;
import com.oj.pojo.entity.TagClassification;
import com.oj.pojo.vo.TagVO;
import com.oj.service.TagClassificationService;
import com.oj.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

@Service
public class TagClassificationServiceImpl extends ServiceImpl<TagClassificationMapper, TagClassification> implements TagClassificationService {
    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private TagClassificationMapper tagClassificationMapper;

    /**
     * 获取所有标签及标签分类
     * @return
     */
    @Override
    public List<TagVO> getTagAndTagClassification() {
        ArrayList<TagVO> res = new ArrayList<>();
        // 查出所有的标签和标签分类
        List<Tag> tagList = tagMapper.selectList(null);
        List<TagClassification> tagClassificationList = tagClassificationMapper.selectList(null);
        // 根据标签的分类id分类
        for (TagClassification tagClassification : tagClassificationList) {
            TagVO tagVO = new TagVO();
            tagVO.setClassification(tagClassification);

            ArrayList<Tag> tags = new ArrayList<>();
            Iterator<Tag> iterator = tagList.iterator();
            while (iterator.hasNext()) {
                Tag tag = iterator.next();
                if (tagClassification.getId().equals(tag.getTcid())) {
                    tags.add(tag);
                    iterator.remove();
                }
            }
            tagVO.setTagList(tags);
            res.add(tagVO);
        }
        // 将未分类的标签放一起
        if (tagList.size() > 0) {
            TagVO tagVO = new TagVO();
            TagClassification tagClassification = new TagClassification();
            tagClassification.setName("未分类");
            tagClassification.setRank(-1);
            tagVO.setClassification(tagClassification);
            tagVO.setTagList(tagList);
            res.add(tagVO);
        }
        // 根据标签分类的rank排序
        Collections.sort(res, (a, b) -> a.getClassification().getRank() - b.getClassification().getRank());

        return res;
    }
}
