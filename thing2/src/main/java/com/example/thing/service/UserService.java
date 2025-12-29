package com.example.thing.service;

import com.example.thing.dao.UserDao;
import com.example.thing.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils; // Spring自带MD5

@Service // 标记为业务层
public class UserService {

    @Autowired
    private UserDao userDao;

    public boolean register(String username, String password) {
        User user = new User();
        user.setUsername(username);
        // 使用 Spring 自带的 MD5 工具
        String md5Pass = DigestUtils.md5DigestAsHex(password.getBytes());
        user.setPassword(md5Pass);
        return userDao.register(user);
    }

    public User login(String username, String password) {
        String md5Pass = DigestUtils.md5DigestAsHex(password.getBytes());
        return userDao.login(username, md5Pass);
    }
}