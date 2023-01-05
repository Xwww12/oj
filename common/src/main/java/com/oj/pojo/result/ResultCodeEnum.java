package com.oj.pojo.result;

import lombok.Getter;

/**
 * 统一返回结果状态信息类
 */
@Getter
public enum ResultCodeEnum {
    SUCCESS(200, "成功");

    private Integer code;
    private String msg;

    private ResultCodeEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
