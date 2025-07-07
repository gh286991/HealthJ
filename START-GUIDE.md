# 健康專案啟動指南 🚀

## 專案結構
```
HealthProJ/
├── health-be/          # 後端 (NestJS)
├── health-fe/          # 前端 (Next.js)
├── start-dev.sh        # macOS/Linux 啟動腳本
├── start-dev.bat       # Windows 啟動腳本
├── .nvmrc              # Node.js 版本指定 (18.19.0)
└── package.json        # 根目錄腳本管理
```

## 必要環境

### Node.js 版本
專案指定使用 **Node.js 18.19.0**

### macOS/Linux 用戶
1. 安裝 nvm (Node Version Manager)
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   source ~/.bashrc  # 或 ~/.zshrc
   ```

2. 使用指定 Node 版本
   ```bash
   nvm install 18.19.0
   nvm use 18.19.0
   ```

### Windows 用戶
1. 下載並安裝 Node.js 18.19.0+ from [nodejs.org](https://nodejs.org/)
2. 確保安裝了 yarn: `npm install -g yarn`

## 啟動方式

### 方法一：使用啟動腳本（推薦）

#### macOS/Linux
```bash
./start-dev.sh
```

#### Windows
```cmd
start-dev.bat
```

### 方法二：使用 yarn 指令
```bash
# 安裝所有依賴
yarn install:all

# 啟動開發環境
yarn dev
```

### 方法三：手動分別啟動
```bash
# 啟動後端 (Terminal 1)
cd health-be
yarn install
yarn start:dev

# 啟動前端 (Terminal 2)
cd health-fe
yarn install
yarn dev
```

## 服務地址

啟動成功後，您可以訪問：

- **前端**: http://localhost:3030
- **後端**: http://localhost:3000
- **後端 API 文件**: http://localhost:3000/api (如果有設定 Swagger)

## 可用指令

```bash
yarn install:all    # 安裝所有專案依賴
yarn dev            # 啟動開發環境
yarn build:all      # 建置所有專案
yarn start          # 啟動生產環境
```

## 注意事項

1. **首次執行**會自動安裝所有必要的依賴
2. **停止服務**：按 `Ctrl+C` 會同時停止前端和後端
3. **依賴更新**：如果 package.json 有變更，請重新執行 `yarn install:all`
4. **埠號衝突**：確保 3000 和 3030 埠號沒有被其他程序占用

## 疑難排解

### 埠號被占用
```bash
# 查看占用 3000 埠的程序
lsof -ti:3000
# 強制結束
kill -9 $(lsof -ti:3000)

# 查看占用 3030 埠的程序
lsof -ti:3030
# 強制結束
kill -9 $(lsof -ti:3030)
```

### 權限問題 (macOS/Linux)
```bash
chmod +x start-dev.sh
```

### 清除 node_modules 重新安裝
```bash
rm -rf health-be/node_modules health-fe/node_modules node_modules
rm -rf health-be/yarn.lock health-fe/yarn.lock yarn.lock
yarn install:all
``` 