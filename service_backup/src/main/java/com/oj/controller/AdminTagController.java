package com.oj.controller;

import com.oj.pojo.entity.Tag;
import com.oj.pojo.entity.TagClassification;
import com.oj.pojo.exception.GlobalException;
import com.oj.pojo.result.Result;
import com.oj.pojo.vo.TagVO;
import com.oj.service.TagClassificationService;
import com.oj.service.TagService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    public Result<String> addTag(@RequestBody Tag tag) {
        try {
            tagService.addTag(tag);
        }catch (GlobalException e){
            return Result.error(e.getMessage());
        }
        return Result.success();
    }

    @ApiOperation("删除单个标签")
    @DeleteMapping("/delete/{id}")
    public Result<String> deleteTag(@PathVariable("id") Long id) {
        try {
            tagService.deleteTag(id);
        }catch (GlobalException e){
            return Result.error(e.getMessage());
        }
        return Result.success();
    }

    @ApiOperation("修改标签")
    @PostMapping("/update")
    public Result<String> updateTag(@RequestBody Tag tag) {
        try {
            tagService.updateTag(tag);
        }catch (GlobalException e){
            return Result.error(e.getMessage());
        }
        return Result.success();
    }

    @ApiOperation("添加标签分类")
    @PostMapping("/tagClassification/add")
    public Result<String> addTagClassification(@RequestBody TagClassification tagClassification) {
        try {
            tagClassificationService.addTagClassification(tagClassification);
        }catch (GlobalException e){
            return Result.error(e.getMessage());
        }
        return Result.success();
    }

    @ApiOperation("删除单个标签分类")
    @DeleteMapping("/tagClassification/delete/{id}")
    public Result<String> deleteTagClassification(@PathVariable("id") Long id) {
        try {
            tagClassificationService.deleteTagClassification(id);
        }catch (GlobalException e){
            return Result.error(e.getMessage());
        }
        return Result.success();
    }

    @ApiOperation("修改标签分类")
    @PostMapping("/tagClassification/update")
    public Result<String> updateTagClassification(@RequestBody TagClassification tagClassification) {
        try {
            tagClassificationService.updateTagClassification(tagClassification);
        }catch (GlobalException e){
            return Result.error(e.getMessage());
        }
        return Result.success();
    }
}