<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户登录 | 二手交易平台</title>
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            /* 高级感的渐变背景 */
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
            transition: transform 0.3s;
        }
        .container:hover { transform: translateY(-5px); }
        .title {
            color: #333;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }
        .input-group input {
            width: 100%;
            padding: 12px 15px 12px 45px; /* 左边留出图标的位置 */
            border: 1px solid #ddd;
            border-radius: 25px;
            outline: none;
            transition: border-color 0.3s;
            font-size: 14px;
        }
        .input-group input:focus {
            border-color: #764ba2;
        }
        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 25px;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: opacity 0.3s;
            margin-top: 10px;
        }
        .btn:hover { opacity: 0.9; }
        .links {
            margin-top: 20px;
            font-size: 14px;
        }
        .links a {
            color: #764ba2;
            text-decoration: none;
        }
        .links a:hover { text-decoration: underline; }
        .error-msg {
            background-color: #ffdddd;
            color: #d8000c;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
            font-size: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">欢迎回来</div>

    <!-- 错误提示区域 -->
    <c:if test="${not empty msg}">
        <div class="error-msg">
            <i class="fas fa-exclamation-circle" style="margin-right: 5px;"></i> ${msg}
        </div>
    </c:if>

    <!-- 修改点：action 指向 Spring Controller 的路径，删除了 hidden input -->
    <form action="${pageContext.request.contextPath}/auth/login" method="post">

        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="username" placeholder="请输入用户名" required>
        </div>

        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="请输入密码" required>
        </div>

        <button type="submit" class="btn">立即登录</button>
    </form>

    <div class="links">
        <!-- 修改点：加上 contextPath 防止路径错误 -->
        还没有账号？ <a href="${pageContext.request.contextPath}/register.jsp">去注册一个</a>
    </div>
</div>

</body>
</html>