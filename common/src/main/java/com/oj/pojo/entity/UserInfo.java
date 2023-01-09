package com.oj.pojo.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.oj.pojo.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(description = "用户信息")
public class UserInfo extends BaseEntity {
    @ApiModelProperty(value = "用户名")
    private String username;

    @ApiModelProperty(value = "密码")
    private String password;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "昵称")
    private String nickname;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "学院")
    private String college;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "专业")
    private String major;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "班级")
    private String stuclass;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "学号")
    private String number;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "性别")
    private String gender;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "真实姓名")
    private String realname;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "cf的username")
    private String cfUsername;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "邮箱")
    private String email;

    @ApiModelProperty(value = "头像地址")
    private String avatar;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "个性签名")
    private String signature;

    @TableField(updateStrategy = FieldStrategy.IGNORED)
    @ApiModelProperty(value = "逻辑删除，0未删除，1删除")
    private int deleted;

    @ApiModelProperty(value = "0可用，-1不可用")
    private int status;
}
