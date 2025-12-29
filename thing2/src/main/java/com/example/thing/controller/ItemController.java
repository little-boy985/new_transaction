package com.example.thing.controller;

import com.example.thing.entity.Item;
import com.example.thing.entity.User;
import com.example.thing.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/item")
public class ItemController {

    @Autowired
    private ItemService itemService;

    @GetMapping("/list")
    public String list(String keyword, Model model) {
        List<Item> items = itemService.findItems(keyword);
        model.addAttribute("itemList", items);
        model.addAttribute("searchKeyword", keyword);
        // 对应 /WEB-INF/jsp/list.jsp
        return "list";
    }

    @PostMapping("/add")
    public String add(Item item, HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) return "redirect:/login.jsp";

        item.setUserId(user.getId());
        itemService.publishItem(item);
        return "redirect:/item/list";
    }

    @GetMapping("/delete")
    public String delete(int id) {
        itemService.removeItem(id);
        return "redirect:/item/list";
    }

    @GetMapping("/toEdit")
    public String toEdit(int id, Model model) {
        Item item = itemService.getItem(id);
        model.addAttribute("item", item);
        return "edit";
    }

    @PostMapping("/update")
    public String update(Item item) {
        itemService.modifyItem(item);
        return "redirect:/item/list";
    }
}