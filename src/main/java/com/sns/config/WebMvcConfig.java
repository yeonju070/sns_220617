package com.sns.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sns.common.FileManagerService;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
		.addResourceHandler("/images/**")	// 웹 주소 (url path)
		// 맥은 / 한개, 윈도우는 / 3개
		.addResourceLocations("file:///" + FileManagerService.FILE_UPLOAD_PATH);	// 실제 파일 위치 경로(이미지)
	}
}
