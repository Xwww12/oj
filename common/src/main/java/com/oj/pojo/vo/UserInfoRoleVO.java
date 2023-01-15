package com.oj.pojo.vo;

import com.oj.pojo.entity.Role;
import com.oj.pojo.entity.UserInfo;
import lombok.Data;

import java.util.List;

@Data
public class UserInfoRoleVO extends UserInfo{

    private List<Role> roles;
}
