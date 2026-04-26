@echo off
chcp 65001 >nul

:: 快速启动AI Analyzer
echo Starting AI Analyzer...

:: 进入脚本所在目录
cd /d "%~dp0"

:: 启动服务器（使用start命令直接启动，不等待）
start "AI Analyzer Server" cmd /k "node src/server.js"

:: 最小化等待时间
ping localhost -n 3 >nul

:: 打开浏览器（不等待服务完全启动，让浏览器自行处理连接）
echo Opening browser...
start "" "http://localhost:3001"

echo AI Analyzer is starting...
echo Access at: http://localhost:3001
echo 
echo Press any key to exit...
pause >nul
