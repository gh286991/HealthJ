# HealthProJ - 健康記錄管理系統

[![License: Custom](https://img.shields.io/badge/License-Custom-blue.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/Node.js-24.3.0-green.svg)](https://nodejs.org/)
[![Frontend](https://img.shields.io/badge/Frontend-Next.js-black.svg)](https://nextjs.org/)
[![Backend](https://img.shields.io/badge/Backend-NestJS-red.svg)](https://nestjs.com/)

一個現代化的全端健康記錄管理系統，具備漸進式網路應用程式 (PWA) 功能。專為追蹤營養、飲食記錄和個人健康數據而設計，注重使用者體驗和數據安全性。

[繁體中文文檔](README.zh-TW.md) | [English](README.md)

## 功能特色

### 認證與安全
- 使用者註冊和登入系統
- JWT 的身份驗證

### 健康記錄管理
- 個人飲食和營養追蹤
- 包含完整營養數據的食物資料庫管理
- 每日營養攝取監控
- 具備健康指標的個人資料管理

### 漸進式網路應用程式 (PWA)
- 離線功能
- 行動響應式設計
- 在行動裝置上提供類似應用程式的體驗


## 技術架構

### 後端 (NestJS)
- **框架**: NestJS 10.x
- **資料庫**: MongoDB
- **認證**: JWT + Passport
- **檔案儲存**: MinIO
- **API 文件**: Swagger

### 前端 (Next.js)
- **框架**: Next.js 15
- **語言**: TypeScript
- **樣式**: Tailwind CSS 4


### 開發工具
- **套件管理器**: Yarn
- **程式碼檢查**: ESLint
- **型別檢查**: TypeScript
- **測試**: Jest
- **程序管理**: Concurrently

##  快速開始

### 系統需求

- Node.js 24.3.0+ (require)
- Yarn 套件管理器
- MongoDB 資料庫
- MinIO 伺服器 (用於檔案儲存)

### 安裝

1. **複製專案**
   ```bash
   git clone <repository-url>
   cd HealthProj
   ```

2. **安裝所有依賴套件**
   ```bash
   yarn install:all
   ```

3. **啟動開發伺服器**
   ```bash
   yarn dev
   ```

   這將同時啟動前端和後端：
   - 前端: http://localhost:3030
   - 後端: http://localhost:9000
   - API 文件: http://localhost:9000/api

### 其他安裝方式

#### 使用啟動腳本
```bash
# macOS/Linux
./start-dev.sh

# Windows
start-dev.bat
```

## 專案結構

```
HealthProj/
├── HealthRecord/          # 後端 (NestJS)
│   ├── src/
│   │   ├── auth/          # 認證模組
│   │   ├── diet/          # 飲食記錄管理
│   │   ├── food/          # 食物資料庫管理
│   │   └── common/        # 共用服務 (MinIO 等)
│   └── package.json
├── HealthRecord-FE/       # 前端 (Next.js)
│   ├── src/
│   │   ├── app/           # Next.js App Router 頁面
│   │   ├── components/    # 可重用元件
│   │   └── lib/           # API 服務和工具
│   └── package.json
├── start-dev.sh          # Unix 啟動腳本
├── start-dev.bat         # Windows 啟動腳本
└── package.json          # 根目錄套件管理
```

## 📱 PWA 功能

前端建置為漸進式網路應用程式，具備：
- 離線功能
- 用於快取的 Service Worker
- 用於應用程式安裝的 Manifest 檔案
- 適用於所有裝置的響應式設計

## 🤝 貢獻

此專案主要用於個人/教育用途。如果您有興趣貢獻或商業使用，請聯繫作者。

## 📄 授權條款

此專案採用 **自訂授權條款**：

- ✅ **開源**: 免費用於個人、教育和非商業用途
- ❌ **禁止商業使用**: 商業使用需要明確許可
- 💼 **商業授權**: 請聯繫作者洽詢商業授權條款

**商業使用諮詢，請聯繫**: [您的聯絡資訊]

任何未經適當授權的商業使用將面臨法律行動。

## 🆘 支援與疑難排解

### 常見問題

1. **port衝突**: 確保 3030 和 9000 port可用
2. **Node 版本**: 確保您使用 Node.js 24.3.0+
3. **依賴套件**: 如遇到缺少依賴套件，請執行 `yarn install:all`

### 取得協助

1. 查看 [START-GUIDE.md](START-GUIDE.md) 了解詳細設定說明
2. 檢視 API 文件：http://localhost:9000/api
3. 如需支援，請建立 issue

## 🎯 未來發展計劃

- [ ] 增強營養分析功能
- [ ] 目標設定和進度追蹤
- [ ] 分享進度的社交功能
- [ ] 與健身追蹤器整合
- [ ] 進階報告和分析
- [ ] 多語言支援

---

**免責聲明**: 此健康管理系統僅供參考，不應取代專業醫療建議。做出醫療決定時請務必諮詢醫療專業人員。 