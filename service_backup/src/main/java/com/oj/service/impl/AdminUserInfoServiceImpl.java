package com.oj.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.oj.mapper.RoleMapper;
import com.oj.mapper.UserInfoMapper;
import com.oj.mapper.UserRoleMapper;
import com.oj.pojo.entity.Role;
import com.oj.pojo.entity.UserInfo;
import com.oj.pojo.relation.UserRoleRelation;
import com.oj.pojo.result.Result;
import com.oj.pojo.vo.UserInfoRoleVO;
import com.oj.service.AdminUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class AdminUserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements AdminUserInfoService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    /**
     * 获取用户列表
     *
     * @param current
     * @param limit
     * @param keyword
     * @return
     */
    @Override
    public Result<IPage<UserInfoRoleVO>> getUserList(Long current, Long limit, String keyword) {
        // 判断参数是否合法，不合法给默认值
        if (current == null || current < 1)
            current = 1L;
        if (limit == null || limit < 1)
            limit = 10L;
        if (keyword != null)
            keyword = keyword.trim();   //去掉前导空格和尾部空格

        // 查询用户信息
        IPage<UserInfoRoleVO> res = getUserInfo(current, limit, keyword);
        if (res.getRecords().size() == 0) {
            return Result.success();
        }
        // 查询用户对应的角色id
        LambdaQueryWrapper<UserRoleRelation> userRoleWrapper = new LambdaQueryWrapper<>();

        userRoleWrapper.in(UserRoleRelation::getUid, res.getRecords().stream().map(UserInfoRoleVO::getId).collect(Collectors.toList()));
        List<UserRoleRelation> userRoleRelations = userRoleMapper.selectList(userRoleWrapper);

        // 查询角色信息
        Map<Long, Role> roleMap = getRoleMap();
        for (UserInfoRoleVO userInfoRoleVO : res.getRecords()) {
            List<Role> roleList = new ArrayList<>();
            Iterator<UserRoleRelation> iterator = userRoleRelations.iterator();
            while (iterator.hasNext()) {
                UserRoleRelation userRoleRelation = iterator.next();
                if (userRoleRelation.getUid().equals(userInfoRoleVO.getId())) {
                    roleList.add(roleMap.get(userRoleRelation.getRoleId()));
                    iterator.remove();
                }
            }
            userInfoRoleVO.setRoles(roleList);
        }

        return Result.success(res);
    }

    /**
     * 查询角色信息并转化为VO
     * @param current
     * @param limit
     * @param keyword
     * @return
     */
    private IPage<UserInfoRoleVO> getUserInfo(Long current, Long limit, String keyword) {
        // 查询所有当前页的用户信息
        Page<UserInfo> userInfoPage = new Page<>(current, limit);
        LambdaQueryWrapper<UserInfo> userInfoWrapper = new LambdaQueryWrapper<>();
        if (keyword != null) {
            userInfoWrapper.like(UserInfo::getUsername, keyword)
                    .or().like(UserInfo::getRealname, keyword)
                    .or().like(UserInfo::getNumber, keyword);
        }
        userInfoWrapper.orderByDesc(UserInfo::getCreateTime)
                .orderByDesc(UserInfo::getId);
        this.page(userInfoPage, userInfoWrapper);
        // 转换为VO
        return userInfoPage.convert(UserInfo -> BeanUtil.copyProperties(UserInfo, UserInfoRoleVO.class));
    }

    /**
     * 获取角色Map
     * @return
     */
    private Map<Long, Role> getRoleMap() {
        Map<Long, Role> res = new HashMap<>();
        List<Role> roles = roleMapper.selectList(null);
        for (Role role : roles) {
            res.put(role.getId(), role);
        }
        return res;
    }
}
