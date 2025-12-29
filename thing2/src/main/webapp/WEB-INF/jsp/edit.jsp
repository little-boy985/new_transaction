<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>修改物品</title></head>
<body>
<h3>修改物品信息</h3>
<!-- 修改点：表单路径改为 item/update，删除了 hidden input name="action" -->
<form action="${pageContext.request.contextPath}/item/update" method="post">
    <input type="hidden" name="id" value="${item.id}">
    名称: <input type="text" name="name" value="${item.name}" required><br>
    描述: <input type="text" name="description" value="${item.description}"><br>
    价格: <input type="number" step="0.01" name="price" value="${item.price}" required><br>
    联系方式: <input type="text" name="contact" value="${item.contact}" required><br>
    <button type="submit">保存修改</button>
</form>
</body>
</html>