package com.oj.pojo.result;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("全局统一返回结果")
@Data
public class Result<T> {
    @ApiModelProperty("响应码")
    private Integer code;

    @ApiModelProperty("消息")
    private String msg;

    @ApiModelProperty("返回数据")
    private T data;

    /**
     * 操作成功
     * @param <T>
     * @return
     */
    public static <T> Result<T> success() {
        return Result.success(null);
    }

    /**
     * 操作成功
     * @param data
     * @param <T>
     * @return
     */
    public static <T> Result<T> success(T data) {
        return build(data, ResultCodeEnum.SUCCESS);
    }

    /**
     * 操作失败
     * @param <T>
     * @return
     */
    public static  <T> Result<T> error() {
        return Result.error(null);
    }

    /**
     * 操作失败
     * @param msg
     * @param <T>
     * @return
     */
    public static <T> Result<T> error(String msg) {
        return build(null, ResultCodeEnum.FAIL, msg);
    }

    public static <T> Result<T> build(T data) {
        Result<T> result = new Result<>();
        if (data != null)
            result.setData(data);
        return result;
    }

    public static <T> Result<T> build(T data, ResultCodeEnum resultCodeEnum) {
        Result<T> result = build(data);
        result.setCode(resultCodeEnum.getCode());
        result.setMsg(result.getMsg());
        return result;
    }

    public static <T> Result<T> build(T data, ResultCodeEnum resultCodeEnum, String msg) {
        Result<T> result = build(data);
        result.setCode(resultCodeEnum.getCode());
        result.setMsg(result.getMsg());
        result.setMsg(msg);
        return result;
    }

}
