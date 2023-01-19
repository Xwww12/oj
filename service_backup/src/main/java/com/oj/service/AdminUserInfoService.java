package com.oj.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.oj.pojo.entity.UserInfo;
import com.oj.pojo.result.Result;
import com.oj.pojo.vo.UserInfoRoleVO;
import org.springframework.stereotype.Service;


public interface AdminUserInfoService extends IService<UserInfo> {
    Result<IPage<UserInfoRoleVO>> getUserList(Long current, Long limit, String keyword);

    Result<String> addUser(UserInfo userInfo);

}
