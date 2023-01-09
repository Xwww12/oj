package com.oj.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.oj.pojo.entity.Tag;
import com.oj.pojo.result.Result;
import com.oj.service.TagService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.websocket.server.PathParam;

@Api("标签接口")
@RestController
@RequestMapping("/api/admin/tag")
public class AdminTagController {
    @Autowired
    private TagService tagService;

    @ApiOperation("获取标签")
    @GetMapping("/classification")
    public Result<Tag> getTagByName(@RequestParam(required = true) String name) {
        LambdaQueryWrapper<Tag> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Tag::getName, name);
        Tag tag = tagService.getOne(wrapper);
        return Result.success(tag);
    }
}
