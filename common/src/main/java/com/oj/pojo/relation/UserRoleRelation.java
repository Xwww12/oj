package com.oj.pojo.relation;

import com.baomidou.mybatisplus.annotation.TableName;
import com.oj.pojo.base.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 用户和角色的中间表
 */
@Data
@TableName("user_role")
public class UserRoleRelation extends BaseEntity {
    @ApiModelProperty(value = "用户id")
    private Long uid;

    @ApiModelProperty(value = "角色id")
    private Long roleId;
}
