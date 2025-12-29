<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>二手物品交易大厅</title>
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 全局样式重置 */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%);
            color: #333;
            min-height: 100vh;
        }

        /* 顶部导航栏 */
        .navbar {
            background: #ffffff;
            padding: 15px 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .navbar .brand {
            font-size: 22px;
            font-weight: 700;
            color: #333;
            display: flex;
            align-items: center;
            letter-spacing: 1px;
        }
        .navbar .brand i { margin-right: 10px; color: #ff6b6b; }

        .user-panel { font-size: 14px; color: #666; display: flex; align-items: center; }
        .user-panel span { color: #ff6b6b; font-weight: bold; margin: 0 5px; }
        .btn-logout {
            margin-left: 15px;
            color: #999;
            text-decoration: none;
            transition: 0.3s;
            font-size: 13px;
        }
        .btn-logout:hover { color: #ff6b6b; }
        .login-link { color: #555; text-decoration: none; font-weight: 600; margin: 0 10px; }
        .login-link:hover { color: #ff6b6b; }

        /* 主容器 */
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 搜索和发布栏 */
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .search-form {
            position: relative;
            flex: 1;
            max-width: 450px;
        }
        .search-form input {
            width: 100%;
            padding: 12px 20px 12px 45px;
            border: 1px solid #eee;
            border-radius: 50px;
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
            outline: none;
            transition: 0.3s;
        }
        .search-form input:focus { border-color: #ff6b6b; box-shadow: 0 2px 15px rgba(255, 107, 107, 0.15); }
        .search-form i {
            position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: #ccc;
        }

        .btn-add {
            background: linear-gradient(to right, #ff6b6b, #ff8e8e);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
            transition: transform 0.2s;
            display: flex;
            align-items: center;
        }
        .btn-add:hover { transform: translateY(-2px); }
        .btn-add i { margin-right: 6px; }

        /* 列表表格 */
        .table-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.03);
            overflow: hidden;
        }
        table { width: 100%; border-collapse: collapse; }
        thead { background: #fafafa; border-bottom: 2px solid #f0f0f0; }
        th {
            text-align: left; padding: 18px 25px; color: #888; font-size: 13px; font-weight: 600; text-transform: uppercase;
        }
        td {
            padding: 18px 25px; border-bottom: 1px solid #f5f5f5; color: #444; font-size: 14px;
        }
        tr:last-child td { border-bottom: none; }
        tr:hover { background-color: #fffcfc; }

        .item-name { font-weight: 600; color: #333; font-size: 15px; }
        .item-desc { color: #999; font-size: 13px; max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .price-tag { color: #ff6b6b; font-weight: 700; font-size: 16px; }
        .contact-info { display: flex; align-items: center; color: #666; font-size: 13px; }
        .contact-info i { margin-right: 5px; color: #ccc; }

        /* 操作按钮 */
        .actions a {
            text-decoration: none; margin-right: 12px; color: #bbb; transition: 0.2s;
        }
        .actions a.edit:hover { color: #4facfe; }
        .actions a.delete:hover { color: #ff6b6b; }
        .buy-hint { font-size: 12px; color: #bbb; background: #f5f5f5; padding: 4px 8px; border-radius: 4px; }

        /* 空状态 */
        .empty-state { text-align: center; padding: 60px; color: #bbb; }
        .empty-state i { font-size: 40px; margin-bottom: 10px; display: block; color: #eee; }

        /* 弹窗样式 */
        .modal {
            display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5); backdrop-filter: blur(4px);
            justify-content: center; align-items: center;
        }
        .modal-content {
            background-color: #fff; padding: 30px; width: 420px; border-radius: 15px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2); animation: slideIn 0.3s;
        }
        @keyframes slideIn { from {opacity: 0; transform: translateY(-20px);} to {opacity: 1; transform: translateY(0);} }
        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .modal-header h3 { margin: 0; color: #333; }
        .close { font-size: 24px; cursor: pointer; color: #aaa; }

        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 6px; font-size: 13px; color: #777; font-weight: 600; }
        .form-group input, .form-group textarea {
            width: 100%; padding: 10px 12px; border: 1px solid #ddd; border-radius: 8px; outline: none; font-size: 14px;
        }
        .form-group input:focus, .form-group textarea:focus { border-color: #ff6b6b; }

        .btn-submit {
            width: 100%; padding: 12px; background: #ff6b6b; color: white; border: none;
            border-radius: 8px; font-weight: 600; cursor: pointer; margin-top: 10px;
        }
        .btn-submit:hover { background: #ff5252; }
    </style>
</head>
<body>

<!-- 1. 导航栏 -->
<div class="navbar">
    <div class="brand">
        <i class="fas fa-store"></i> CampusTrade
    </div>
    <div class="user-panel">
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                Hi, <span>${sessionScope.currentUser.username}</span>
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> 退出</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.jsp" class="login-link">登录</a> /
                <a href="${pageContext.request.contextPath}/register.jsp" class="login-link">注册</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 2. 主体区域 -->
<div class="container">

    <!-- 顶部工具栏 -->
    <div class="toolbar">
        <form action="${pageContext.request.contextPath}/item/list" method="get" class="search-form">
            <i class="fas fa-search"></i>
            <input type="text" name="keyword" value="${searchKeyword}" placeholder="搜索好物 (例如: 键盘, 课本...)">
        </form>

        <c:if test="${not empty sessionScope.currentUser}">
            <button onclick="showModal()" class="btn-add">
                <i class="fas fa-plus"></i> 卖闲置
            </button>
        </c:if>
    </div>

    <!-- 列表表格 -->
    <div class="table-card">
        <c:choose>
            <c:when test="${empty itemList}">
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <p>暂无物品，快来发布第一个商品吧！</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th width="20%">物品</th>
                        <th width="35%">描述</th>
                        <th width="15%">价格</th>
                        <th width="15%">联系方式</th>
                        <th width="15%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${itemList}" var="item">
                        <tr>
                            <td class="item-name">${item.name}</td>
                            <td><div class="item-desc" title="${item.description}">${item.description}</div></td>
                            <td><span class="price-tag">¥${item.price}</span></td>
                            <td>
                                <div class="contact-info">
                                    <i class="fas fa-phone-alt"></i> ${item.contact}
                                </div>
                            </td>
                            <td class="actions">
                                <!-- 错误就在这里，请确保下面这对 choose 标签是闭合的 -->
                                <c:choose>
                                    <c:when test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == item.userId}">
                                        <a href="${pageContext.request.contextPath}/item/toEdit?id=${item.id}" class="edit" title="编辑"><i class="fas fa-pen"></i></a>
                                        <a href="${pageContext.request.contextPath}/item/delete?id=${item.id}" class="delete" title="删除" onclick="return confirm('确认下架该商品吗？')"><i class="fas fa-trash"></i></a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="buy-hint">联系卖家</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 3. 发布弹窗 -->
<div id="publishModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>发布闲置物品</h3>
            <span class="close" onclick="closeModal()">&times;</span>
        </div>
        <form action="${pageContext.request.contextPath}/item/add" method="post">
            <div class="form-group">
                <label>物品名称</label>
                <input type="text" name="name" required placeholder="如：9成新机械键盘">
            </div>

            <div class="form-group">
                <label>价格 (元)</label>
                <input type="number" step="0.01" name="price" required placeholder="0.00">
            </div>

            <div class="form-group">
                <label>联系方式</label>
                <input type="text" name="contact" required placeholder="微信或手机号">
            </div>

            <div class="form-group">
                <label>详细描述</label>
                <textarea name="description" rows="3" placeholder="介绍一下成色、来源等信息..."></textarea>
            </div>

            <button type="submit" class="btn-submit">立即发布</button>
        </form>
    </div>
</div>

<script>
    function showModal() { document.getElementById('publishModal').style.display = 'flex'; }
    function closeModal() { document.getElementById('publishModal').style.display = 'none'; }
    window.onclick = function(e) {
        if (e.target == document.getElementById('publishModal')) closeModal();
    }
</script>

</body>
</html>