# AI Analyzer 启动脚本
# 功能：启动AI Analyzer服务并打开浏览器

Write-Host "Starting AI Analyzer..." -ForegroundColor Green

# 进入脚本所在目录
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

Write-Host "Current directory: $scriptDir" -ForegroundColor Cyan

# 检查Node.js是否安装
try {
    $nodeVersion = node -v
    Write-Host "Node.js version: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Node.js not found" -ForegroundColor Red
    Write-Host "Please install Node.js from https://nodejs.org" -ForegroundColor Yellow
    Read-Host "Press Enter to exit..."
    exit 1
}

# 检查依赖是否存在
if (-not (Test-Path "node_modules")) {
    Write-Host "Installing dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Failed to install dependencies" -ForegroundColor Red
        Read-Host "Press Enter to exit..."
        exit 1
    }
    Write-Host "Dependencies installed successfully" -ForegroundColor Green
}

# 启动服务器
Write-Host "Starting server..." -ForegroundColor Yellow
$serverProcess = Start-Process "cmd.exe" -ArgumentList "/k node src/server.js" -WindowStyle Normal -PassThru

# 等待服务启动
Write-Host "Waiting for server to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# 检查服务状态
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3001/health" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "Service started successfully!" -ForegroundColor Green
    } else {
        Write-Host "Service startup failed" -ForegroundColor Red
        Read-Host "Press Enter to exit..."
        exit 1
    }
} catch {
    Write-Host "Service is starting..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
}

# 打开浏览器
Write-Host "Opening browser..." -ForegroundColor Yellow
Start-Process "http://localhost:3001"

Write-Host "" -ForegroundColor White
Write-Host "================================================" -ForegroundColor Green
Write-Host "        AI Analyzer Service Started" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host "Service address: http://localhost:3001" -ForegroundColor Cyan
Write-Host "To stop the service, close the command window" -ForegroundColor Yellow
Write-Host "" -ForegroundColor White
Write-Host "Press Enter to exit..." -ForegroundColor Cyan
Read-Host
