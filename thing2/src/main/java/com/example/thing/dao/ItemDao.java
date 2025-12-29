package com.example.thing.dao;

import com.example.thing.entity.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class ItemDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Item> searchItems(String keyword) {
        String sql = "SELECT * FROM items WHERE name LIKE ? ORDER BY id DESC";
        String param = "%" + (keyword == null ? "" : keyword) + "%";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Item.class), param);
    }

    public Item getItemById(int id) {
        String sql = "SELECT * FROM items WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Item.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    public void addItem(Item item) {
        String sql = "INSERT INTO items(name, description, price, contact, user_id) VALUES(?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, item.getName(), item.getDescription(), item.getPrice(), item.getContact(), item.getUserId());
    }

    public void updateItem(Item item) {
        String sql = "UPDATE items SET name=?, description=?, price=?, contact=? WHERE id=?";
        jdbcTemplate.update(sql, item.getName(), item.getDescription(), item.getPrice(), item.getContact(), item.getId());
    }

    public void deleteItem(int id) {
        String sql = "DELETE FROM items WHERE id=?";
        jdbcTemplate.update(sql, id);
    }
}