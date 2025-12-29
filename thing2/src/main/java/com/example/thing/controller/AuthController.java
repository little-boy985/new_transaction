package com.example.thing.controller;

import com.example.thing.entity.User;
import com.example.thing.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public String login(String username, String password, HttpSession session, Model model) {
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("currentUser", user);
            // 登录成功，重定向到列表页
            return "redirect:/item/list";
        } else {
            model.addAttribute("msg", "用户名或密码错误");
            // 转发回 login.jsp (配置了视图解析器，不需要写 .jsp 后缀)
            return "forward:/login.jsp";
        }
    }

    @PostMapping("/register")
    public String register(String username, String password, Model model) {
        try {
            boolean success = userService.register(username, password);
            if (success) {
                return "redirect:/login.jsp";
            }
        } catch (Exception e) {
            // 忽略重复注册的异常
        }
        model.addAttribute("msg", "注册失败，用户名已存在");
        return "forward:/register.jsp";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login.jsp";
    }
}