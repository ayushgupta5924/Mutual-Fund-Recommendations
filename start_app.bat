@echo off
echo Starting MF Advisor App...
echo.

echo [1/3] Installing Backend Dependencies...
cd backend
pip install -r requirements.txt
echo.

echo [2/3] Starting Backend Server...
start cmd /k "uvicorn main:app --reload --host 0.0.0.0 --port 8000"
timeout /t 5 /nobreak >nul
echo.

echo [3/3] Starting Flutter App...
cd ..\flutter_app\mf_advisor
start cmd /k "flutter pub get && flutter run"
echo.

echo Both services are starting in separate windows!
pause
