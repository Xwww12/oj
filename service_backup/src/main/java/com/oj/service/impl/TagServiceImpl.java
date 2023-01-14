package com.oj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.oj.mapper.TagMapper;
import com.oj.pojo.entity.Tag;
import com.oj.pojo.exception.GlobalException;
import com.oj.pojo.result.ResultCodeEnum;
import com.oj.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class TagServiceImpl extends ServiceImpl<TagMapper, Tag> implements TagService {

    @Autowired
    private TagService tagService;

    /**
     * 添加标签
     *
     * @param tag
     * @return
     */
    @Override
    public void addTag(Tag tag) {

        //设置mp的配置
        QueryWrapper<Tag> tagQueryWrapper = new QueryWrapper<>();
        tagQueryWrapper.eq(tag.getGid() != null, "gid", tag.getGid())
                .eq("name", tag.getName());

        //查询表里是否存在此标签
        Tag existTag = tagService.getOne(tagQueryWrapper, false);

        //存在则返回错误信息
        if (existTag != null) {
            throw new GlobalException(ResultCodeEnum.FAIL);
        }
        //不存在则添加
        boolean save = tagService.save(tag);

        //判断是否添加成功
        if (!save) {
            throw new GlobalException(ResultCodeEnum.FAIL);
        }
    }

    /**
     * 按id删除标签
     *
     * @param id
     * @return
     */
    @Override
    public void deleteTag(Long id) {

        boolean isOk = tagService.removeById(id);

        if (!isOk) {
            throw new GlobalException(ResultCodeEnum.FAIL);
        }

    }

    /**
     * 修改标签
     *
     * @param tag
     * @return
     */
    @Override
    public void updateTag(Tag tag) {

        boolean isOk = tagService.updateById(tag);

        if (!isOk) {
            throw new GlobalException(ResultCodeEnum.FAIL);
        }

    }
}