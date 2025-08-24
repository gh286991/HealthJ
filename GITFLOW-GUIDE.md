# 🚀 GitFlow 部署指南

## 📋 概述

這個專案使用 GitFlow 工作流程來管理程式碼的開發、測試和部署。我們整合了 GitHub Actions 和 Zeabur 來自動化部署流程。

## 🌿 分支策略

### 主要分支
- **`main`** - 生產環境分支，包含穩定且經過測試的程式碼
- **`develop`** - 開發主分支，整合所有功能開發

### 支援分支
- **`staging`** - 測試環境分支，用於最終測試和驗證
- **`feature/*`** - 功能開發分支，從 `develop` 分支建立
- **`hotfix/*`** - 緊急修復分支，從 `main` 分支建立
- **`release/*`** - 發布準備分支，從 `develop` 分支建立

## 🔄 工作流程

### 1. 功能開發
```bash
# 從 develop 分支建立功能分支
git checkout develop
git pull origin develop
git checkout -b feature/新功能名稱

# 開發完成後，合併回 develop
git checkout develop
git merge feature/新功能名稱
git push origin develop
git branch -d feature/新功能名稱
```

### 2. 發布準備
```bash
# 從 develop 建立發布分支
git checkout develop
git pull origin develop
git checkout -b release/v1.0.0

# 修復 bug 和最終調整
# 合併到 staging 分支進行測試
git checkout staging
git merge release/v1.0.0
git push origin staging

# 測試完成後，合併到 main
git checkout main
git merge release/v1.0.0
git tag v1.0.0
git push origin main --tags

# 合併回 develop
git checkout develop
git merge release/v1.0.0
git push origin develop

# 清理發布分支
git branch -d release/v1.0.0
```

### 3. 緊急修復
```bash
# 從 main 建立熱修復分支
git checkout main
git pull origin main
git checkout -b hotfix/緊急修復

# 修復完成後，合併到 main
git checkout main
git merge hotfix/緊急修復
git tag v1.0.1
git push origin main --tags

# 合併回 develop
git checkout develop
git merge hotfix/緊急修復
git push origin develop

# 清理熱修復分支
git branch -d hotfix/緊急修復
```

## 🚀 部署流程

### 手動觸發部署

1. 前往 GitHub 專案的 **Actions** 頁面
2. 選擇 **🚀 Deploy to Zeabur** 工作流程
3. 點擊 **Run workflow** 按鈕
4. 設定部署參數：
   - **部署環境**: 選擇 `dev`、`stg` 或 `prod`
   - **後端專案分支**: 輸入 HealthRecord 專案的分支名稱
   - **前端專案分支**: 輸入 HealthRecord-FE 專案的分支名稱
   - **是否建置後端**: 選擇是否重新建置後端
   - **是否建置前端**: 選擇是否重新建置前端
   - **強制部署**: 跳過測試直接部署（謹慎使用）

### 🆕 動態分支偵測

現在工作流程支援**動態分支偵測**，不再需要預先定義固定的分支選項：

- ✅ **自動偵測**: 系統會自動掃描您的前後端專案所有可用分支
- ✅ **靈活輸入**: 您可以直接輸入任何存在的分支名稱
- ✅ **即時顯示**: 部署時會顯示所有可用分支的完整列表
- ✅ **無需維護**: 不需要手動更新分支選項

### 分支輸入範例

#### 後端專案 (HealthRecord) 分支
- `develop` - 開發分支
- `staging` - 測試分支
- `main` - 主分支
- `feature/health-tracking` - 功能分支
- `hotfix/security-patch` - 熱修復分支
- `release/v1.2.0` - 發布分支

#### 前端專案 (HealthRecord-FE) 分支
- `develop` - 開發分支
- `staging` - 測試分支
- `main` - 主分支
- `feature/nutrition-ui` - 功能分支
- `hotfix/mobile-layout` - 熱修復分支
- `release/v1.2.0` - 發布分支

**詳細說明請參考**: [動態分支偵測功能](docs/DYNAMIC-BRANCH-DETECTION.md)

### 環境對應關係

| 環境 | 建議後端分支 | 建議前端分支 | 用途 |
|------|-------------|-------------|------|
| `dev` | `develop` 或 `feature/*` | `develop` 或 `feature/*` | 開發環境，用於功能測試 |
| `stg` | `staging` 或 `develop` | `staging` 或 `develop` | 測試環境，用於整合測試 |
| `prod` | `main` 或 `staging` | `main` 或 `staging` | 生產環境，對外服務 |

**注意**: 現在您可以靈活選擇前後端專案的不同分支進行部署，不再限制於特定的分支組合。

## ⚙️ 必要設定

### GitHub Secrets

在 GitHub 專案設定中設定以下 Secrets：

1. **`ZEABUR_TOKEN`** - Zeabur API Token
2. **`ZEABUR_PROJECT_ID`** - Zeabur 專案 ID
3. **`NEXT_PUBLIC_API_URL`** - 前端 API 基礎 URL

### 設定步驟

1. 前往 GitHub 專案頁面
2. 點擊 **Settings** 標籤
3. 在左側選單中選擇 **Secrets and variables** → **Actions**
4. 點擊 **New repository secret** 按鈕
5. 新增上述必要的 Secrets

## 🔧 本地開發設定

### 安裝必要工具
```bash
# 安裝 Git Flow 擴展（可選）
git flow init

# 設定 Git 別名
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```

### 常用 Git 命令
```bash
# 查看分支狀態
git status

# 查看所有分支
git branch -a

# 切換分支
git checkout 分支名稱

# 拉取最新變更
git pull origin 分支名稱

# 推送變更
git push origin 分支名稱
```

## 📊 部署狀態檢查

部署完成後，您可以：

1. 在 GitHub Actions 頁面查看部署狀態
2. 在 Zeabur 控制台檢查應用狀態
3. 查看部署摘要和日誌

## 🚨 注意事項

1. **分支保護**: 建議為 `main`、`staging` 和 `develop` 分支啟用保護規則
2. **Code Review**: 所有合併到主要分支的程式碼都應該經過 Code Review
3. **測試**: 部署前確保所有測試都通過
4. **回滾**: 如果部署失敗，可以快速回滾到上一個穩定版本

## 🆘 故障排除

### 常見問題

1. **部署失敗**: 檢查 GitHub Secrets 是否正確設定
2. **建置失敗**: 檢查 Dockerfile 和依賴配置
3. **測試失敗**: 檢查測試配置和環境變數

### 獲取幫助

- 查看 GitHub Actions 日誌
- 檢查 Zeabur 部署狀態
- 聯繫開發團隊

---

**最後更新**: $(date)
**版本**: 1.0.0
