package com.oj.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.oj.pojo.entity.UserInfo;
import com.oj.pojo.result.Result;
import com.oj.pojo.vo.UserInfoRoleVO;
import com.oj.service.AdminUserInfoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


@Api(tags = "用户管理")
@RestController
@RequestMapping("/api/admin/user")
public class AdminUserController {
    @Autowired
    private AdminUserInfoService adminUserInfoService;

    @ApiOperation("获取用户列表")
    @GetMapping("/getPage")
    public Result<IPage<UserInfoRoleVO>> getUserList(@RequestParam(value = "current", required = false) Long current,
                                                     @RequestParam(value = "limit", required = false) Long limit,
                                                     @RequestParam(value = "keyword", required = false) String keyword
                                                     ) {
        return adminUserInfoService.getUserList(current, limit, keyword);
    }

    @ApiOperation("添加单个用户")
    @PostMapping("/add")
    public Result<Void> addUser(@RequestBody UserInfo userInfo) {
        return Result.error("功能未开发");
    }

    @ApiOperation("批量添加用户")
    @PostMapping("/addBatch")
    public Result<Void> addBatchUser(@RequestBody Map<String, Object> params) {
        return Result.error("功能未开发");
    }

    @ApiOperation("修改用户")
    @PutMapping("/update")
    public Result<Void> updateUser(@RequestBody UserInfo userInfo) {
        return Result.error("功能未开发");
    }

    @ApiOperation("删除单个用户")
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteUser(@PathVariable("id") Long id) {
        return Result.error("功能未开发");
    }

    @ApiOperation("批量删除用户")
    @PostMapping("/deleteBatch")
    public Result<Void> deleteBatchUser(@RequestBody Map<String, Object> params) {
        return Result.error("功能未开发");
    }
}
