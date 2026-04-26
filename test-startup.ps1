# Test script for AI Analyzer startup
Write-Host "Testing AI Analyzer startup..." -ForegroundColor Green

# Check if batch file exists
$batchFile = ".\AI Analyzer.bat"
if (Test-Path $batchFile) {
    Write-Host "Batch file found: $batchFile" -ForegroundColor Green
} else {
    Write-Host "Error: Batch file not found!" -ForegroundColor Red
    exit 1
}

# Check if Node.js is installed
try {
    $nodeVersion = node -v
    Write-Host "Node.js version: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Node.js not found!" -ForegroundColor Red
    exit 1
}

# Check if npm dependencies exist
if (Test-Path ".\node_modules") {
    Write-Host "Node modules found" -ForegroundColor Green
} else {
    Write-Host "Node modules not found, will be installed by batch script" -ForegroundColor Yellow
}

# Check if port 3001 is available
try {
    $portCheck = netstat -an | Select-String ":3001"
    if ($portCheck) {
        Write-Host "Port 3001 is occupied, batch script will find an available port" -ForegroundColor Yellow
    } else {
        Write-Host "Port 3001 is available" -ForegroundColor Green
    }
} catch {
    Write-Host "Error checking port" -ForegroundColor Red
}

Write-Host "" -ForegroundColor White
Write-Host "To run the AI Analyzer, double-click on 'AI Analyzer.bat'" -ForegroundColor Cyan
Write-Host "The script will:"
Write-Host "1. Check for Node.js installation"
Write-Host "2. Install dependencies if needed"
Write-Host "3. Find an available port"
Write-Host "4. Start the AI Analyzer service"
Write-Host "5. Open your default browser"
Write-Host "" -ForegroundColor White
Write-Host "Press any key to exit..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
