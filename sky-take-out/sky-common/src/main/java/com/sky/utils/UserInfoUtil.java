package com.sky.utils;

import com.sky.constant.MessageConstant;
import com.sky.context.BaseContext;
import com.sky.exception.UserNotLoginException;

public class UserInfoUtil {
    /**
     * 获取当前用户id，如果没有登陆则抛出异常
     * @return
     */
    public static Long getCurrentUserIdOrThrow() {
        Long userId = BaseContext.getCurrentId();
        if (userId == null) {
            throw new UserNotLoginException(MessageConstant.USER_NOT_LOGIN);
        }
        return userId;
    }
}
