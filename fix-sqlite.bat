@echo off
echo ================================
echo     INSTALACAO SQLite3
echo ================================
echo.

echo Parando processos Node.js...
taskkill /f /im node.exe 2>nul

echo.
echo Limpando node_modules...
rmdir /s /q node_modules 2>nul

echo.
echo Instalando dependencias...
call npm install

echo.
echo Instalando sqlite3...
call npm install sqlite3 --save

echo.
echo Instalando better-sqlite3 como alternativa...
call npm install better-sqlite3 --save

echo.
echo ================================
echo    INSTALACAO CONCLUIDA!
echo ================================
echo.
echo Para iniciar a aplicacao:
echo npm run start:dev
echo.
pause
