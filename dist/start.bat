@echo off
echo ===================================
echo   AI Analyzer 启动脚本
echo ===================================
echo.

echo 正在检查依赖...
if not exist "node_modules" (
    echo 发现缺少依赖，正在安装...
    call npm install
)

echo.
echo 正在启动服务器...
echo.
echo 启动成功后，访问: http://localhost:3001/index.html
echo 按 Ctrl+C 停止服务器
echo.

node src/server.js

pause
