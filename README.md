Job Portal Application
这是一个基于 Node.js 和 Express 的招聘门户网站，提供了用户注册、职位搜索、职位推荐、简历管理和聊天功能。

项目结构
frontend/: 包含前端页面文件（如 HTML、CSS、JavaScript 文件）。
controllers/: 后端控制器文件，包含实现业务逻辑的 API。
routes/: 定义 API 路由的模块。
public/: 用于静态资源。
uploads/: 保存用户上传的文件（例如简历或头像）。
mydb.js: 数据库连接配置文件。
app.js: 项目的入口文件，包含服务器和中间件设置。
功能
用户注册与登录
文件: auth.js​(auth)
用户可以注册为 Job Seeker 或 Employer，并根据身份登录到不同的主页。
职位搜索与推荐
文件: searchController.js, searchRoutes.js​(searchController)​(searchRoutes)
用户可以基于职位、地点、行业、薪资等进行职位搜索，并获得推荐职位。
简历管理
文件: resumeController.js, profile.js​(resumeController)​(profile)
用户可以创建、保存并上传简历，也可查看并删除已提交的简历。
聊天功能
文件: app.js
Job Seekers 和 Employers 可以在职位申请页面进行即时聊天，便于沟通。
用户感兴趣的职位管理
文件: jobsController.js​(jobsController)
用户可以标记感兴趣的职位，并在个人资料中管理这些职位。
安装与配置
1. 环境需求
Node.js 14 或更高版本
MySQL 数据库
2. 克隆项目
bash
复制代码
git clone <repository-url>
cd job-portal
3. 安装依赖
bash
复制代码
npm install
4. 配置数据库
在 MySQL 中创建数据库 job。
在 mydb.js 中配置数据库连接信息​(mydb)。
5. 初始化数据库表
在 MySQL 中执行 schema.sql 文件，创建所需的数据库表。
6. 运行项目
bash
复制代码
node app.js
项目将启动在 http://localhost:3000。

API 端点
用户认证
POST /api/register/:userType: 注册用户（jobseeker 或 employer）。
POST /api/login/:userType: 用户登录。
职位搜索
GET /api/jobs: 获取职位列表，支持过滤条件。
GET /api/jobs/:jobId: 获取指定职位的详细信息。
推荐职位
GET /api/recommendations/:userId: 获取推荐职位。
简历管理
POST /api/resume/save-resume: 保存用户简历。
GET /api/resume/get-resume: 获取用户简历信息。
用户资料
GET /api/profile: 获取用户资料。
聊天
POST /api/chat/message: 发送聊天消息。
GET /api/chat/messages/:userId/:partnerId: 获取用户之间的聊天记录。
贡献
欢迎提交 Issues 或 Pull Requests 来改进此项目。
