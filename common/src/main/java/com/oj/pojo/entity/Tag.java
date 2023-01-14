package com.oj.pojo.entity;


import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.oj.pojo.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(description = "题目标签")
public class Tag extends BaseEntity {

    @ApiModelProperty(value = "标签名字")
    private String name;

    @ApiModelProperty(value = "标签颜色")
    private String color;

    @ApiModelProperty(value = "团队ID")
    private Long gid;

    @ApiModelProperty(value = "标签分类ID")
    @TableField(updateStrategy = FieldStrategy.IGNORED)
    private Long tcid;
}
