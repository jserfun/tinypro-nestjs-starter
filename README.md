# TinyPro Nest.js

## 说明

此项目为 tiny-toolkit-pro 套件初始化的 TinyPro 的 nestjs 后端项目。

项目运行环境如下，仅供参考

- node: v18.19.0
- npm: 10.2.3
- mysql: 8.0.28
- redis: 6.2.11

## 快速上手

### 依赖安装

您可以选择任何您喜欢的包管理工具, 这里使用了 npm

```
npm i
```

### 开发环境启动

在启动开发环境时, 请确保本机已经启动了 `MySQL` 与 `Redis` 服务。并已经做好了如下检查

1. 初始化 MySQL

sql 文件: scripts/sql/tinypro_nestjs.sql

- 已包含 DDL 语句 和 SEEDS 数据
- 默认数据库名称为 tinypro_nestjs
- 执行之前可以先检查下

用 root 或者 具有合适权限的用户 登录 MySQL

可以选择以下几种方式执行初始化

- mysql workbench
- mysql cli
- navicat
- 自行连接 mysql server 执行 sql 文件

2. 初始化 Redis

Redis 上默认没有密码，先设置一下密码

Redis服务器 / 本机 -> 上找到 redis.conf，修改 requirepass 密码

docker compose 模式下自动设置 redis 的密码为 .env 文件中对应的密码

3. .env 文件
  
已准备 .env.example 文件, 可根据实际情况自行设置相应的数据

*注意: 修改 .env 文件应同时考虑是否要修改 docker 相关的文件*

把 .env.example 改成 .env 文件

4. 启动应用

```sh
# 普通启动
npm start
# hot reload
npm run start:dev
```

5. 访问 tinypro 的前端应用

默认访问: http://localhost:3031/

账号: admin@no-reply.com
密码: admin

6. 测试

测试分为 spec 和 e2e 测试，还可以生成覆盖率

```sh
# .spec 文件测试
npm run test
# .spec in watch mode
npm run test:watch
# e2e 点对点请求测试
npm run test:e2e
# e2e in watch mode
npm run test:e2e:watch
# 生成覆盖率 coverage
npm run test:cov
```

7. 打包

```sh
npm run build
```

### Docker启动

在使用 docker 环境时, 您应当确保机器已经安装了 Docker 服务. 本章仅阐述项目默认的 `docker-compose.yaml` 文件的启动注意事项

dockerfile 也同样使用 .env 文件作为环境变量, 也可根据情况手动设置

完成上述检查后, 您可以使用 `docker compose up -d` 来运行 docker 环境

## 二次开发指南

// WAITING FOR DOCUMENT DEPLOY
// SHOULD LINK TO tiny-pro-backend-dev-guideline.md

## 遇到困难?

加官方小助手微信 opentiny-official，加入技术交流群

------------------------

预祝使用 nestjs 开发快乐, 项目早日上线
