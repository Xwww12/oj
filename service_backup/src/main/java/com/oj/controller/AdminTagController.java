package com.oj.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.oj.pojo.entity.Tag;
import com.oj.pojo.entity.TagClassification;
import com.oj.pojo.result.Result;
import com.oj.pojo.vo.TagVO;
import com.oj.service.TagClassificationService;
import com.oj.service.TagService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.websocket.server.PathParam;
import java.util.List;

@Api("标签接口")
@RestController
@RequestMapping("/api/admin/tag")
public class AdminTagController {
    @Autowired
    private TagService tagService;

    @Autowired
    private TagClassificationService tagClassificationService;

    @ApiOperation("获取所有标签及标签分类")
    @GetMapping("/getAll")
    public Result<List<TagVO>> getTagAndTagClassification() {
        return Result.success(tagClassificationService.getTagAndTagClassification());
    }

    @ApiOperation("添加标签")
    @PostMapping("/add")
    public Result<Void> addTag(@RequestBody Tag tag) {
        return null;
    }

    @ApiOperation("删除单个标签")
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteTag(@PathVariable("id") Long id) {
        return null;
    }

    @ApiOperation("修改标签")
    @PostMapping("/update")
    public Result<Void> updateTag(@RequestBody Tag tag) {
        return null;
    }

    @ApiOperation("添加标签分类")
    @PostMapping("/tagClassification/add")
    public Result<Void> addTagClassification(@RequestBody TagClassification tagClassification) {
        return null;
    }

    @ApiOperation("删除单个标签分类")
    @DeleteMapping("/tagClassification/delete/{id}")
    public Result<Void> deleteTagClassification(@PathVariable("id") Long id) {
        return null;
    }

    @ApiOperation("修改标签分类")
    @PostMapping("/tagClassification/update")
    public Result<Void> updateTagClassification(@RequestBody TagClassification tagClassification) {
        return null;
    }
}
