#!/bin/bash

# 🚀 GitFlow 分支設定腳本
# 這個腳本會幫您建立 GitFlow 所需的分支結構

set -e

echo "🚀 開始設定 GitFlow 分支結構..."

# 檢查是否在 Git 倉庫中
if [ ! -d ".git" ]; then
    echo "❌ 錯誤：請在 Git 倉庫根目錄執行此腳本"
    exit 1
fi

# 檢查當前分支
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 當前分支: $CURRENT_BRANCH"

# 確保在 main 分支上
if [ "$CURRENT_BRANCH" != "master" ]; then
    echo "⚠️  警告：建議在 master 分支上執行此腳本"
    read -p "是否繼續？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 操作已取消"
        exit 1
    fi
fi

# 拉取最新變更
echo "📥 拉取最新變更..."
git pull origin master

# 建立 develop 分支
echo "🌿 建立 develop 分支..."
if git show-ref --verify --quiet refs/heads/develop; then
    echo "⚠️  develop 分支已存在，切換到該分支"
    git checkout develop
    git pull origin develop
else
    git checkout -b develop
    echo "✅ develop 分支已建立"
fi

# 建立 staging 分支
echo "🔧 建立 staging 分支..."
if git show-ref --verify --quiet refs/heads/staging; then
    echo "⚠️  staging 分支已存在，切換到該分支"
    git checkout staging
    git pull origin staging
else
    git checkout -b staging
    echo "✅ staging 分支已建立"
fi

# 推送所有分支到遠端
echo "📤 推送分支到遠端..."
git push -u origin develop
git push -u origin staging

# 切換回 main 分支
git checkout main

echo ""
echo "🎉 GitFlow 分支設定完成！"
echo ""
echo "📋 分支結構："
echo "   main     - 生產環境分支"
echo "   staging  - 測試環境分支"
echo "   develop  - 開發主分支"
echo ""
echo "🔧 下一步："
echo "   1. 在 GitHub 上設定分支保護規則"
echo "   2. 設定必要的 GitHub Secrets"
echo "   3. 開始使用 GitFlow 工作流程"
echo ""
echo "📚 詳細說明請參考 GITFLOW-GUIDE.md"
