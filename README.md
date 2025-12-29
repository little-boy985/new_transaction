# 🛒 SecondHand Transaction - 校园二手物品交易平台 (Spring Refactored)

> 一个基于 **Spring MVC + Spring JDBC + JSP** 架构构建的现代化二手物品交易系统。

本项目是对原有 Servlet 原生项目的**深度重构**。引入了 **Spring Framework** 进行管理，实现了 **IOC (控制反转)** 和 **MVC 分层** 设计，极大地降低了代码耦合度，提高了系统的可维护性和扩展性。

---

## 📸 项目概览 (Features)

*   **用户模块**: 支持用户注册、登录（密码采用 MD5 加密存储）、注销。
*   **物品管理**: 发布闲置物品、编辑物品信息、下架（删除）物品。
*   **交互体验**:
    *   **列表页**: 卡片式布局，支持价格高亮、长文本自动截断。
    *   **搜索**: 支持按物品名称模糊搜索。
    *   **发布**: 采用 Modal 弹窗式表单，体验更流畅。
    *   **UI**: 使用 CSS3 渐变背景 + FontAwesome 图标库进行美化。
*   **安全机制**: 拦截未登录用户的非法请求，防止越权操作。

## 🛠️ 技术栈 (Tech Stack)

### 后端 (Backend)
*   **Framework**: Spring 5.3.x (Spring MVC, Spring Context)
*   **ORM / DAO**: Spring JDBC (JdbcTemplate)
*   **Connection Pool**: Alibaba Druid
*   **Database**: MySQL 8.0
*   **Build Tool**: Maven

### 前端 (Frontend)
*   **View**: JSP (JavaServer Pages)
*   **Tag Library**: JSTL + EL 表达式 (无 Scriptlet 代码)
*   **Style**: Custom CSS3 (Flexbox Layout) + FontAwesome 6.0

### 环境 (Environment)
*   **JDK**: 1.8 / 17
*   **Server**: Apache Tomcat 9.0
*   **IDE**: IntelliJ IDEA

---

## 🏗️ 系统架构 (Architecture)

本项目严格遵循标准的 **MVC (Model-View-Controller)** 分层架构：

```text
src/main/java/com/example/thing
├── controller/      # 控制层 (@Controller)
│   ├── AuthController.java   - 处理登录/注册请求
│   └── ItemController.java   - 处理物品的增删改查
│
├── service/         # 业务层 (@Service)
│   ├── UserService.java      - 负责用户逻辑与加密
│   └── ItemService.java      - 负责物品业务逻辑
│
├── dao/             # 数据访问层 (@Repository)
│   ├── UserDao.java          - 使用 JdbcTemplate 操作 Users 表
│   └── ItemDao.java          - 使用 JdbcTemplate 操作 Items 表
│
└── entity/          # 实体类 (POJO)
    ├── User.java
    └── Item.java

src/main/resources
└── spring-mvc.xml   # Spring 核心配置文件 (扫描组件、配置数据源、视图解析器)
