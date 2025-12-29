package com.example.thing.dao;

import com.example.thing.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository // 标记为 DAO 组件
public class UserDao {

    @Autowired // 自动注入 JdbcTemplate
    private JdbcTemplate jdbcTemplate;

    public boolean register(User user) {
        String sql = "INSERT INTO users(username, password) VALUES(?, ?)";
        int rows = jdbcTemplate.update(sql, user.getUsername(), user.getPassword());
        return rows > 0;
    }

    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try {
            // Spring 自动把 ResultSet 映射成 User 对象
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), username, password);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}