package com.oj.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.Environment;
import org.springframework.core.env.Profiles;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.ArrayList;

@Configuration
@EnableSwagger2
//@Profile({"dev", "test"})
public class SwaggerConfig {
    @Bean
    public Docket docket(Environment environment) {
        // 设置要显示的swagger环境
        // Profiles profiles = Profiles.of("dev", "test"); //线下环境
        // 通过环境判断是否在自己所设定的环境当中
        // boolean flag = environment.acceptsProfiles(profiles);
        return new Docket(DocumentationType.SWAGGER_2)  // 指定Api类型为Swagger2
                .apiInfo(apiInfo())                     // 指定文档汇总信息
                .groupName("后台管理接口")                // 分组
                .enable(true)                           // 开启
                .select()
                .apis(RequestHandlerSelectors
                        .basePackage("com.oj"))         // 指定controller包路径
                .build();
    }

    //配置swagger信息
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("后台管理API文档")                 // 文档页标题
                .description("aip文档")                 // 详细信息
                .version("1.0")                         // 文档版本号
                .build();
    }
}
