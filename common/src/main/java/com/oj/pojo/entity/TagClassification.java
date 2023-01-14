package com.oj.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.oj.pojo.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(description = "题目标签分类")
public class TagClassification extends BaseEntity {

  @ApiModelProperty(value = "标签分类名字")
  private String name;

  @ApiModelProperty(value = "排序，数字越小越靠前")
  @TableField(value = "`rank`")
  private Integer rank;

}
