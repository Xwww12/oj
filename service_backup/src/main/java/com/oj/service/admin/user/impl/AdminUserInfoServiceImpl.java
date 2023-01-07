package com.oj.service.admin.user.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.oj.mapper.UserInfoMapper;
import com.oj.pojo.entity.UserInfo;
import com.oj.service.admin.user.AdminUserService;
import org.springframework.stereotype.Service;

@Service
public class AdminUserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements AdminUserService {
}
