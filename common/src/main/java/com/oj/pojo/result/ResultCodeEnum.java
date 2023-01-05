package com.oj.pojo.result;

import lombok.Getter;

/**
 * 统一返回结果状态信息类
 */
@Getter
public enum ResultCodeEnum {
    SUCCESS(200, "成功"),
    FAIL(400, "失败"),
    LOGIN_AUTH(401, "未登录"),
    PERMISSION(403, "没有权限"),
    NOT_FOUND(404, "资源不存在"),
    SYSTEM_ERROR(500, "服务器异常");


    private Integer code;
    private String msg;

    private ResultCodeEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
