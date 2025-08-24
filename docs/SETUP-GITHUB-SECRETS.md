# ⚙️ GitHub Secrets 設定指南

## 📋 概述

為了讓 GitHub Actions 能夠自動部署到 Zeabur，您需要在 GitHub 專案中設定一些機密資訊（Secrets）。這些 Secrets 包含 API 金鑰、認證資訊等敏感資料。

## 🔐 必要的 Secrets

### 1. Zeabur 相關

#### `ZEABUR_API_TOKEN`
- **描述**: Zeabur GraphQL API Token，用於認證和部署
- **獲取方式**:
  1. 登入 [Zeabur](https://zeabur.com)
  2. 前往 **Settings** → **API Tokens**
  3. 點擊 **Generate New Token**
  4. 設定 Token 名稱（如：`github-actions`）
  5. 選擇權限：`Read` 和 `Deploy`
  6. 複製產生的 Token
- **注意**: 這是新的 GraphQL API Token，取代了舊的 CLI Token

#### `ZEABUR_PROJECT_ID`
- **描述**: Zeabur 專案 ID
- **獲取方式**:
  1. 在 Zeabur 中建立新專案或選擇現有專案
  2. 在專案頁面，URL 會顯示為：`https://zeabur.com/projects/{PROJECT_ID}`
  3. 複製 `{PROJECT_ID}` 部分





## 🛠️ 設定步驟

### 方法 1: 透過 GitHub 網頁介面

1. **前往專案設定**
   - 在 GitHub 專案頁面，點擊 **Settings** 標籤
   - 在左側選單中選擇 **Secrets and variables** → **Actions**

2. **新增 Secrets**
   - 點擊 **New repository secret** 按鈕
   - 在 **Name** 欄位輸入 Secret 名稱（如：`ZEABUR_TOKEN`）
   - 在 **Value** 欄位輸入對應的值
   - 點擊 **Add secret** 按鈕

3. **重複步驟 2** 直到所有必要的 Secrets 都設定完成

### 方法 2: 透過 GitHub CLI

如果您已安裝 GitHub CLI，可以使用以下命令：

```bash
# 設定 Zeabur API Token
gh secret set ZEABUR_API_TOKEN --body "your-zeabur-api-token"

# 設定 Zeabur Project ID
gh secret set ZEABUR_PROJECT_ID --body "your-project-id"


```

### 方法 3: 使用設定腳本

我們提供了一個自動化設定腳本：

```bash
# 執行設定腳本
chmod +x scripts/setup-secrets.sh
./scripts/setup-secrets.sh
```

## 🔍 驗證設定

設定完成後，您可以：

1. **檢查 Secrets 列表**
   - 在 **Settings** → **Secrets and variables** → **Actions** 頁面
   - 確認所有必要的 Secrets 都已列出

2. **測試部署工作流程**
   - 前往 **Actions** 標籤
   - 選擇 **🚀 Deploy to Zeabur** 工作流程
   - 點擊 **Run workflow** 按鈕
   - 選擇測試環境和分支
   - 執行部署測試

3. **檢查部署日誌**
   - 在 Actions 頁面查看工作流程執行狀態
   - 檢查是否有認證錯誤或配置問題

## 🚨 安全注意事項

1. **不要分享 Secrets**
   - 永遠不要在程式碼中硬編碼這些值
   - 不要將它們分享給不信任的人

2. **定期更新**
   - 定期更新 API Tokens
   - 移除不再使用的 Tokens

3. **最小權限原則**
   - 只給予必要的權限
   - 定期審查 Token 權限

4. **監控使用情況**
   - 定期檢查 GitHub Actions 日誌
   - 監控異常的部署活動

## 🆘 常見問題

### Q: 部署時出現認證錯誤
**A**: 檢查以下項目：
- Secrets 名稱是否正確（區分大小寫）
- Token 是否過期
- 權限是否足夠

### Q: Docker 映像推送失敗
**A**: 確認：
- Docker Hub 認證是否正確
- 專案是否有推送權限
- 網路連線是否正常

### Q: Zeabur 部署失敗
**A**: 檢查：
- Zeabur Token 是否有效
- 專案 ID 是否正確
- 專案是否已正確設定

## 📚 相關資源

- [GitHub Secrets 官方文件](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Zeabur API 文件](https://docs.zeabur.com/)
- [Docker Hub Access Tokens](https://docs.docker.com/docker-hub/access-tokens/)

---

**最後更新**: $(date)
**版本**: 1.0.0
