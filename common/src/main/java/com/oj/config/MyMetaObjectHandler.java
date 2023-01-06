package com.oj.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * 自动填充创建时间和更新时间
 */
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {
    // 插入时填充
    @Override
    public void insertFill(MetaObject metaObject) {
        if (metaObject.hasSetter("gmtCreate"))
            metaObject.setValue("gmtCreate", LocalDateTime.now());
        if (metaObject.hasSetter("gmtModified"))
            metaObject.setValue("gmtModified", LocalDateTime.now());
    }

    // 更新时填充
    @Override
    public void updateFill(MetaObject metaObject) {
        if (metaObject.hasSetter("gmtModified"))
            metaObject.setValue("gmtModified", LocalDateTime.now());
    }
}
