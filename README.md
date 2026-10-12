
# Project Starter

React + TypeScript + Vite の新規プロジェクトを
自動作成するための開発支援ツール。

## Features

- React + TypeScript プロジェクト生成
- npm install
- Git リポジトリ初期化
- 初回コミット
- GitHub Private リポジトリ作成
- GitHub への初回 Push

## Requirements

- Windows / PowerShell
- Node.js / npm
- Git
- GitHub CLI
- GitHub CLI 認証済み

## Usage

```powershell
.\new-project.ps1 -Name "my-new-tool"
```

## Notes

- 既存のプロジェクトは上書きしない
- GitHub リポジトリは Private で作成する
- API キーや秘密情報をコミットしない
- macOS 対応は今後追加予定
