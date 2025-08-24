# 🐳 Docker 建置部署說明

## 📋 概述

這個 GitFlow 工作流程現在使用 **Docker 建置** 來替代 Node.js 直接建置，這樣可以：

- ✅ 避免 Node.js 版本相容性問題
- ✅ 確保建置環境的一致性
- ✅ 利用現有的 Dockerfile 配置
- ✅ 更接近生產環境的部署方式

## 🔧 建置流程

### 1. **後端建置 (HealthRecord)**
```dockerfile
# 使用 Dockerfile 建置
docker build \
  --tag healthrecord-backend:環境-分支 \
  --build-arg NODE_ENV=環境 \
  .
```

**建置步驟**:
1. 檢出後端程式碼到指定分支
2. 設定 Docker Buildx
3. 使用 Dockerfile 建置映像
4. 上傳建置成品

### 2. **前端建置 (HealthRecord-FE)**
```dockerfile
# 使用 Dockerfile 建置
docker build \
  --tag healthrecord-frontend:環境-分支 \
  --build-arg NODE_ENV=環境 \
  .
```

**建置步驟**:
1. 檢出前端程式碼到指定分支
2. 設定 Docker Buildx
3. 使用 Dockerfile 建置映像
4. 上傳建置成品

## 🧪 測試流程

### 1. **後端測試**
```bash
# 建置測試映像
docker build \
  --target builder \
  --tag healthrecord-backend-test:分支 \
  .

# 執行測試
docker run --rm healthrecord-backend-test:分支 yarn test
```

### 2. **前端測試**
```bash
# 建置測試映像
docker build \
  --target builder \
  --tag healthrecord-frontend-test:分支 \
  .

# 執行單元測試
docker run --rm healthrecord-frontend-test:分支 yarn test

# 執行 E2E 測試
docker run --rm healthrecord-frontend-test:分支 yarn cypress:run
```

## 📦 Dockerfile 配置

### 後端 Dockerfile (HealthRecord)
```dockerfile
FROM node:24-alpine AS builder
WORKDIR /app
RUN apk add --no-cache libc6-compat
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
RUN yarn build

FROM node:24-alpine
WORKDIR /app
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
RUN apk add --no-cache curl
COPY --from-builder /app/package.json ./package.json
COPY --from-builder /app/node_modules ./node_modules
COPY --from-builder /app/dist ./dist
EXPOSE 9181
ENV PORT=9181
CMD ["node", "dist/main.js"]
```

### 前端 Dockerfile (HealthRecord-FE)
```dockerfile
FROM node:24-alpine AS builder
WORKDIR /app
RUN apk add --no-cache libc6-compat
ARG NEXT_PUBLIC_API_URL
ARG NEXT_PUBLIC_ENVIRONMENT
ARG NODE_ENV=production
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}
ENV NEXT_PUBLIC_ENVIRONMENT=${NODE_ENV}
ENV NODE_ENV=${NODE_ENV}
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production=false
COPY . .
RUN yarn build

FROM node:24-alpine
WORKDIR /app
ARG NODE_ENV=production
ARG NEXT_PUBLIC_API_URL
ARG NEXT_PUBLIC_ENVIRONMENT
ENV NODE_ENV=${NODE_ENV}
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}
ENV NEXT_PUBLIC_ENVIRONMENT=${NEXT_PUBLIC_ENVIRONMENT}
COPY --from-builder /app/package.json ./package.json
COPY --from-builder /app/node_modules ./node_modules
COPY --from-builder /app/.next ./.next
COPY --from-builder /app/public ./public
EXPOSE 4321
CMD ["yarn", "start", "-p", "4321"]
```

## 🌍 環境變數

### 建置時環境變數
- `NODE_ENV`: 環境名稱 (dev/stg/prod) - 在建置時傳入

### 運行時環境變數
以下環境變數在 **Zeabur 中設定**，這樣更靈活也更安全：

- **`NEXT_PUBLIC_API_URL`** - API 基礎 URL
- **`NEXT_PUBLIC_ENVIRONMENT`** - 環境名稱
- **`NODE_ENV`** - Node.js 環境
- 其他應用程式特定的環境變數

### 為什麼在 Zeabur 中設定？

1. **安全性**: 敏感資訊不會暴露在 GitHub 中
2. **靈活性**: 可以為不同環境設定不同的值
3. **即時性**: 修改環境變數後立即生效，無需重新部署
4. **管理性**: 集中管理所有環境變數
5. **權限控制**: 可以控制誰有權限修改環境變數

## 🚀 部署流程

### 1. **建置階段**
- 使用 Docker 建置前後端映像
- 上傳建置成品到 GitHub Actions Artifacts

### 2. **部署階段**
- 下載建置成品
- 準備部署檔案
- 使用 Zeabur CLI 部署到指定環境

## 🔍 故障排除

### Docker 建置失敗
- 檢查 Dockerfile 語法
- 確認建置參數正確
- 查看 Docker 建置日誌

### 測試失敗
- 檢查測試映像是否正確建置
- 確認測試命令在容器中可用
- 查看測試執行日誌

### 環境變數問題
- 確認 ARG 和 ENV 設定正確
- 檢查建置參數傳遞
- 驗證環境變數值

## 💡 最佳實踐

### 1. **Dockerfile 優化**
- 使用多階段建置
- 合理設定 .dockerignore
- 優化層級順序

### 2. **建置參數**
- 使用 ARG 接收建置參數
- 使用 ENV 設定運行時環境變數
- 提供合理的預設值

### 3. **測試策略**
- 在 builder 階段執行測試
- 使用 --target 指定建置階段
- 清理測試映像

## 📚 相關資源

- [Docker 多階段建置](https://docs.docker.com/develop/dev-best-practices/multistage-build/)
- [Docker Buildx](https://docs.docker.com/build/buildx/)
- [GitHub Actions Docker 整合](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images)

---

**最後更新**: $(date)
**版本**: 1.0.0
