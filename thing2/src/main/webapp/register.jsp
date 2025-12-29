<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>账号注册 | 二手交易平台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 保持与登录页一致的风格 */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%); /* 注册页换个清新的蓝色调 */
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
            padding: 12px 15px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 25px;
            outline: none;
            transition: border-color 0.3s;
            font-size: 14px;
        }
        .input-group input:focus {
            border-color: #66a6ff;
        }
        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 25px;
            background: linear-gradient(to right, #66a6ff, #89f7fe);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: opacity 0.3s;
            margin-top: 10px;
            text-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        .btn:hover { opacity: 0.9; }
        .links {
            margin-top: 20px;
            font-size: 14px;
        }
        .links a {
            color: #66a6ff;
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
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">创建新账号</div>

    <c:if test="${not empty msg}">
        <div class="error-msg">
            <i class="fas fa-exclamation-triangle"></i> ${msg}
        </div>
    </c:if>

    <!-- 修改点：action 指向 Spring Controller 的路径，删除了 hidden input -->
    <form action="${pageContext.request.contextPath}/auth/register" method="post">

        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="username" placeholder="设置用户名" required>
        </div>

        <div class="input-group">
            <i class="fas fa-key"></i>
            <input type="password" name="password" placeholder="设置密码" required>
        </div>

        <button type="submit" class="btn">立即注册</button>
    </form>

    <div class="links">
        <!-- 修改点：加上 contextPath 防止路径错误 -->
        已有账号？ <a href="${pageContext.request.contextPath}/login.jsp">直接登录</a>
    </div>
</div>

</body>
</html>