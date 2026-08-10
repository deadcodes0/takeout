package com.sky.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sky.entity.WechatTokenResponse;
import com.sky.entity.WechatUserInfoResponse;
import com.sky.properties.WeChatProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
@Slf4j
public class WechatMpUtil {

    @Autowired
    private WeChatProperties weChatProperties;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();  // 新增

    /**
     * 通过授权码 code 换取网页授权 access_token
     */
    public WechatTokenResponse getAccessToken(String code) {
        String url = String.format(
                "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code",
                weChatProperties.getMpAppid(),
                weChatProperties.getMpSecret(),
                code
        );
        log.info("请求微信access_token，appid={}, code={}", weChatProperties.getMpAppid(), code);

        // 【核心修复】先用 String 接收，绕过 Content-Type 限制
        String responseJson = restTemplate.getForObject(url, String.class);
        log.info("微信返回原始数据: {}", responseJson);  // 打印便于调试

        try {
            // 手动反序列化为 WechatTokenResponse
            return objectMapper.readValue(responseJson, WechatTokenResponse.class);
        } catch (Exception e) {
            log.error("解析微信响应失败，原始数据: {}", responseJson, e);
            throw new RuntimeException("微信授权接口响应解析异常", e);
        }
    }

    /**
     * 获取用户基本信息（需 scope=snsapi_userinfo）
     */
    public WechatUserInfoResponse getUserInfo(String accessToken, String openid) {
        String url = String.format(
                "https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s&lang=zh_CN",
                accessToken, openid
        );
        log.info("请求微信userinfo，openid={}", openid);

        // 同样方式处理（防止后续也出现类似问题）
        String responseJson = restTemplate.getForObject(url, String.class);
        log.info("微信用户信息返回: {}", responseJson);
        try {
            return objectMapper.readValue(responseJson, WechatUserInfoResponse.class);
        } catch (Exception e) {
            log.error("解析用户信息失败", e);
            throw new RuntimeException("解析用户信息异常", e);
        }
    }
}