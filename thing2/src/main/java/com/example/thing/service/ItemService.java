package com.example.thing.service;

import com.example.thing.dao.ItemDao;
import com.example.thing.entity.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ItemService {

    @Autowired
    private ItemDao itemDao;

    public List<Item> findItems(String keyword) {
        return itemDao.searchItems(keyword);
    }

    public Item getItem(int id) {
        return itemDao.getItemById(id);
    }

    public void publishItem(Item item) {
        itemDao.addItem(item);
    }

    public void modifyItem(Item item) {
        itemDao.updateItem(item);
    }

    public void removeItem(int id) {
        itemDao.deleteItem(id);
    }
}