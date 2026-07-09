# 使用轻量级的基础镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /usr/src/app

# 复制 package.json（这里虽然没有依赖，但为了规范加上）
COPY package*.json ./

# 安装依赖（如果没有package.json，这步其实可以省略，但保留无害）
RUN npm install

# 复制所有代码到工作目录
COPY . .

# 暴露端口
EXPOSE 3000

# 启动命令
CMD [ "node", "app.js" ]
