
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$Name
)

$ErrorActionPreference = "Stop"

$root = "C:\Users\HP\projects"
$projectPath = Join-Path $root $Name

if (Test-Path $projectPath) {
    throw "Project already exists: $projectPath"
}

foreach ($command in @("npm", "git", "gh")) {
    if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
        throw "Required command not found: $command"
    }
}

gh auth status
if ($LASTEXITCODE -ne 0) {
    throw "GitHub authentication required."
}

Set-Location $root

# React + TypeScript プロジェクト作成
npm create vite@latest $Name -- --template react-ts --no-interactive
if ($LASTEXITCODE -ne 0) {
    throw "Vite project creation failed."
}

Set-Location $projectPath

npm install
if ($LASTEXITCODE -ne 0) {
    throw "npm install failed."
}

# Git初期化
if (-not (Test-Path ".git")) {
    git init
    if ($LASTEXITCODE -ne 0) {
        throw "git init failed."
    }
}

git branch -M main

# 秘密情報をGitに登録しない
Add-Content .gitignore "`n.env`n.env.*`n!.env.example"

git add .
if ($LASTEXITCODE -ne 0) {
    throw "git add failed."
}

git commit -m "chore: initialize project"
if ($LASTEXITCODE -ne 0) {
    throw "Initial commit failed."
}

# GitHubにPrivateリポジトリ作成 + Push
gh repo create $Name --private --source . --remote origin --push
if ($LASTEXITCODE -ne 0) {
    throw "GitHub repository creation or push failed."
}

Write-Host "Project created: $projectPath"
Write-Host "GitHub repository created and pushed."
