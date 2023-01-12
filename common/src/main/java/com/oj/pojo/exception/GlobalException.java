package com.oj.pojo.exception;

import com.oj.pojo.result.ResultCodeEnum;
import lombok.Data;

@Data
public class GlobalException extends RuntimeException{
    // 异常状态码
    private Integer code;

    public GlobalException(ResultCodeEnum resultCodeEnum) {
        super(resultCodeEnum.getMsg());
        this.code = resultCodeEnum.getCode();
    }

    @Override
    public String toString() {
        return "AdminException{" +
                "code=" + code +
                ", message=" + this.getMessage() +
                '}';
    }
}
