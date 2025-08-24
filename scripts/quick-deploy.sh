#!/bin/bash

# 🚀 快速部署腳本
# 這個腳本提供快速部署到不同環境的選項

set -e

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 顯示標題
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    🚀 快速部署腳本                          ║"
echo "║                 HealthProJ 專案部署工具                     ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# 檢查是否在 Git 倉庫中
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ 錯誤：請在 Git 倉庫根目錄執行此腳本${NC}"
    exit 1
fi

# 檢查 GitHub CLI 是否安裝
if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}⚠️  GitHub CLI 未安裝，將提供手動部署說明${NC}"
    echo ""
fi

# 顯示當前狀態
echo -e "${BLUE}📋 當前狀態：${NC}"
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 當前分支: $CURRENT_BRANCH"
echo "🔗 遠端倉庫: $(git remote get-url origin)"
echo ""

# 部署選項
echo -e "${BLUE}🚀 選擇部署選項：${NC}"
echo "1) 部署到開發環境 (dev) - develop 分支"
echo "2) 部署到測試環境 (stg) - staging 分支"
echo "3) 部署到生產環境 (prod) - main 分支"
echo "4) 自定義部署"
echo "5) 查看部署狀態"
echo "6) 退出"
echo ""

read -p "請選擇選項 (1-6): " choice

case $choice in
         1)
        ENVIRONMENT="dev"
        BACKEND_BRANCH="develop"
        FRONTEND_BRANCH="develop"
        echo -e "${GREEN}✅ 選擇：開發環境 (dev)${NC}"
        ;;
     2)
        ENVIRONMENT="stg"
        BACKEND_BRANCH="staging"
        FRONTEND_BRANCH="staging"
        echo -e "${GREEN}✅ 選擇：測試環境 (stg)${NC}"
        ;;
     3)
        ENVIRONMENT="prod"
        BACKEND_BRANCH="main"
        FRONTEND_BRANCH="main"
        echo -e "${GREEN}✅ 選擇：生產環境 (prod)${NC}"
        ;;
    4)
        echo ""
        echo -e "${BLUE}🔧 自定義部署設定：${NC}"
        read -p "部署環境 (dev/stg/prod): " ENVIRONMENT
        read -p "後端分支 (HealthRecord): " BACKEND_BRANCH
        read -p "前端分支 (HealthRecord-FE): " FRONTEND_BRANCH
        read -p "是否建置後端？(y/N): " BUILD_BACKEND
        read -p "是否建置前端？(y/N): " BUILD_FRONTEND
        read -p "強制部署（跳過測試）？(y/N): " FORCE_DEPLOY
        ;;
    5)
        echo ""
        echo -e "${BLUE}📊 部署狀態檢查：${NC}"
        if command -v gh &> /dev/null; then
            echo "檢查 GitHub Actions 狀態..."
            gh run list --limit 5
        else
            echo "請前往 GitHub 專案頁面的 Actions 標籤查看部署狀態"
        fi
        exit 0
        ;;
    6)
        echo -e "${GREEN}👋 再見！${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}❌ 無效選項${NC}"
        exit 1
        ;;
esac

# 驗證環境和分支組合
echo ""
echo -e "${BLUE}🔍 驗證部署配置：${NC}"

case "$ENVIRONMENT" in
    "dev")
        echo -e "${GREEN}ℹ️  開發環境 - 允許使用任何分支進行測試${NC}"
        ;;
    "stg")
        echo -e "${GREEN}ℹ️  測試環境 - 建議使用 staging 分支，但允許其他分支${NC}"
        ;;
    "prod")
        # 生產環境建議使用穩定分支
        if [[ "$BACKEND_BRANCH" != "main" && "$BACKEND_BRANCH" != "staging" ]]; then
            echo -e "${YELLOW}⚠️  警告：生產環境建議使用 main 或 staging 分支${NC}"
        fi
        if [[ "$FRONTEND_BRANCH" != "main" && "$FRONTEND_BRANCH" != "staging" ]]; then
            echo -e "${YELLOW}⚠️  警告：生產環境建議使用 main 或 staging 分支${NC}"
        fi
        ;;
    *)
        echo -e "${RED}❌ 無效的環境：$ENVIRONMENT${NC}"
        exit 1
        ;;
esac

echo -e "${GREEN}✅ 環境和分支組合驗證通過${NC}"

# 設定預設值（如果不是自定義部署）
if [ "$choice" != "4" ]; then
    BUILD_BACKEND="y"
    BUILD_FRONTEND="y"
    FORCE_DEPLOY="n"
fi

# 轉換為 GitHub Actions 格式
BUILD_BACKEND_FLAG="true"
BUILD_FRONTEND_FLAG="true"
FORCE_DEPLOY_FLAG="false"

if [[ "$BUILD_BACKEND" =~ ^[Nn]$ ]]; then
    BUILD_BACKEND_FLAG="false"
fi

if [[ "$BUILD_FRONTEND" =~ ^[Nn]$ ]]; then
    BUILD_FRONTEND_FLAG="false"
fi

if [[ "$FORCE_DEPLOY" =~ ^[Yy]$ ]]; then
    FORCE_DEPLOY_FLAG="true"
fi

# 顯示部署配置
echo ""
echo -e "${BLUE}📋 部署配置：${NC}"
echo "📍 環境: $ENVIRONMENT"
echo "🏗️  後端分支: $BACKEND_BRANCH"
echo "🎨 前端分支: $FRONTEND_BRANCH"
echo "🏗️  建置後端: $BUILD_BACKEND_FLAG"
echo "🏗️  建置前端: $BUILD_FRONTEND_FLAG"
echo "⚡ 強制部署: $FORCE_DEPLOY_FLAG"
echo ""

# 確認部署
read -p "確認部署？(y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}❌ 部署已取消${NC}"
    exit 0
fi

# 執行部署
echo ""
echo -e "${BLUE}🚀 開始部署...${NC}"

if command -v gh &> /dev/null; then
    echo "使用 GitHub CLI 觸發部署..."
    gh workflow run "deploy-zeabur.yml" \
        --field environment="$ENVIRONMENT" \
        --field backend_branch="$BACKEND_BRANCH" \
        --field frontend_branch="$FRONTEND_BRANCH" \
        --field build_backend="$BUILD_BACKEND_FLAG" \
        --field build_frontend="$BUILD_FRONTEND_FLAG" \
        --field force_deploy="$FORCE_DEPLOY_FLAG"
    
    echo -e "${GREEN}✅ 部署工作流程已觸發！${NC}"
    echo ""
    echo "📊 查看部署狀態："
    echo "gh run list --limit 5"
    echo ""
    echo "🔗 或在 GitHub 專案頁面的 Actions 標籤查看"
else
    echo -e "${YELLOW}⚠️  GitHub CLI 未安裝，請手動觸發部署：${NC}"
    echo ""
    echo "1. 前往 GitHub 專案頁面"
    echo "2. 點擊 Actions 標籤"
    echo "3. 選擇 '🚀 Deploy to Zeabur' 工作流程"
    echo "4. 點擊 'Run workflow' 按鈕"
    echo "5. 設定以下參數："
echo "   - 部署環境: $ENVIRONMENT"
echo "   - 後端分支: $BACKEND_BRANCH"
echo "   - 前端分支: $FRONTEND_BRANCH"
echo "   - 是否建置後端: $BUILD_BACKEND_FLAG"
echo "   - 是否建置前端: $BUILD_FRONTEND_FLAG"
echo "   - 強制部署: $FORCE_DEPLOY_FLAG"
    echo "6. 點擊 'Run workflow' 開始部署"
fi

echo ""
echo -e "${GREEN}🎉 部署流程完成！${NC}"
echo ""
echo "📚 更多資訊請參考 GITFLOW-GUIDE.md"
