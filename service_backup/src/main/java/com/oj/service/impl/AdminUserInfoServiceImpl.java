package com.oj.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.oj.mapper.UserInfoMapper;
import com.oj.pojo.entity.UserInfo;
import com.oj.service.AdminUserInfoService;
import org.springframework.stereotype.Service;

@Service
public class AdminUserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements AdminUserInfoService {
}
