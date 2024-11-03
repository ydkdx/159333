Job Portal Application
一个基于 Node.js 和 Express 的招聘平台，帮助求职者找到合适的职位，同时为雇主提供便捷的职位管理和沟通工具。平台支持用户注册、职位搜索、简历管理、职位推荐、实时聊天等功能。

目录
项目简介
功能
安装与配置
API 端点
使用示例
文件结构
技术栈
未来的改进方向

项目简介
Job Portal Application 是一个在线招聘平台，主要面向求职者和雇主。求职者可以在平台上浏览和申请职位，创建和管理个人简历；雇主则可以发布职位，筛选并联系合适的候选人。平台还支持用户之间的实时聊天，提升求职和招聘的沟通效率。

功能
用户注册与登录：用户可以注册为“求职者”或“雇主”，并根据身份登录到不同的主页。
职位搜索与推荐：求职者可以通过关键词、地点、行业、薪资等条件搜索职位，系统还会根据用户偏好推荐职位。
简历管理：求职者可以创建、编辑和保存简历，并提交简历申请职位。
聊天功能：求职者和雇主可以通过平台进行实时聊天，方便沟通。
职位收藏：用户可以收藏自己感兴趣的职位，方便后续查看。
安装与配置
请按照以下步骤设置并运行该项目：

1. 环境要求
Node.js 14 或更高版本
MySQL 数据库
2. 克隆项目
bash
复制代码
git clone https://github.com/ydkdx/159333.git
cd job-portal
3. 安装依赖
bash
复制代码
npm install
4. 配置数据库
在 MySQL 中创建一个名为 job 的数据库。
在 mydb.js 文件中配置你的数据库连接信息。
5. 初始化数据库
在 MySQL 中导入项目根目录中的 job_database.sql 文件，以创建数据库的表结构和初始数据。

6. 运行项目
bash
复制代码
node app.js
项目将运行在 http://localhost:3000。

API 端点
方法	路径	描述
POST	/api/register/:userType	用户注册（jobseeker 或 employer）
POST	/api/login/:userType	用户登录
GET	/api/jobs	获取职位列表，支持关键词、地点等筛选
GET	/api/jobs/:jobId	获取指定职位的详细信息
GET	/api/recommendations/:userId	获取推荐职位
POST	/api/resume/save-resume	保存用户简历
GET	/api/resume/get-resume	获取用户简历信息
POST	/api/chat/message	发送聊天消息
GET	/api/chat/messages/:userId/:partnerId	获取用户之间的聊天记录
使用示例
打开项目
![项目截图](1.png)
在终端将目录导到backend下,输入node app.js即可连接到后端服务器
![项目截图](2.png)
可以打开前端完成功能
![项目截图](3.png)

技术栈
后端：Node.js, Express
数据库：MySQL
前端：HTML, CSS, JavaScript
未来的改进方向
增加用户消息通知系统，提醒用户新的职位动态和申请状态。
支持更多职位筛选条件，例如按工作经验和技能进行筛选。
增加管理员角色，支持平台管理员管理用户和职位内容。
