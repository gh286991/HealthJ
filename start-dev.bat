@echo off
chcp 65001
echo 🚀 啟動健康專案開發環境...

:: 檢查 Node.js 版本
node --version >nul 2>&1
if errorlevel 1 (
    echo ⚠️  請先安裝 Node.js 18.19.0 或更高版本
    echo    下載連結: https://nodejs.org/
    pause
    exit /b 1
)

:: 檢查 yarn 是否安裝
yarn --version >nul 2>&1
if errorlevel 1 (
    echo 📦 安裝 yarn...
    npm install -g yarn
)

:: 安裝根目錄依賴
echo 📦 安裝專案依賴...
yarn install

:: 檢查並安裝各專案依賴
if not exist "health-be\node_modules" (
    echo 📦 安裝後端依賴...
    cd health-be
    yarn install
    cd ..
)

if not exist "health-fe\node_modules" (
    echo 📦 安裝前端依賴...
    cd health-fe
    yarn install
    cd ..
)

:: 啟動開發服務器
echo 🚀 同時啟動前端和後端開發服務器...
echo 📌 後端服務器: http://localhost:3000
echo 📌 前端服務器: http://localhost:3030
echo 📌 按 Ctrl+C 停止所有服務

yarn dev 