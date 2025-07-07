#!/bin/bash

# 健康專案開發環境啟動腳本
echo "🚀 啟動健康專案開發環境..."

# 載入 nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 使用指定的 Node 版本
echo "📦 使用 Node.js 版本: $(cat .nvmrc)"
nvm use

# 檢查 yarn 是否安裝
if ! command -v yarn &> /dev/null; then
    echo "📦 安裝 yarn..."
    npm install -g yarn
fi

# 安裝根目錄依賴
echo "📦 安裝專案依賴..."
yarn install

# 檢查並安裝各專案依賴
if [ ! -d "HealthRecord/node_modules" ]; then
    echo "📦 安裝後端依賴..."
    cd HealthRecord && yarn install && cd ..
fi

if [ ! -d "HealthRecord-FE/node_modules" ]; then
    echo "📦 安裝前端依賴..."
    cd HealthRecord-FE && yarn install && cd ..
fi

# 啟動開發服務器
echo "🚀 同時啟動前端和後端開發服務器..."
echo "📌 後端服務器: http://localhost:9000"
echo "📌 前端服務器: http://localhost:3030"
echo "📌 按 Ctrl+C 停止所有服務"

yarn dev 