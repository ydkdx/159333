const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const authRoutes = require('./routes/auth');

// 使用 CORS 中间件
app.use(cors());

// 使用 body-parser 解析 JSON 请求
app.use(bodyParser.json());

// 使用路由
app.use('/api', authRoutes);

// 启动服务器
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
// 打印当前路由
app._router.stack.forEach(function(r){
    if (r.route && r.route.path) {
        console.log(r.route.path);
    }
});
app.use((req, res, next) => {
    console.log(`${req.method} ${req.url}`);
    next();
});
