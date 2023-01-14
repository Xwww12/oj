package com.oj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.oj.pojo.entity.UserInfo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserInfoMapper extends BaseMapper<UserInfo> {
}
