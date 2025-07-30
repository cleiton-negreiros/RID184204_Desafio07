@echo off
echo ================================
echo     DEPLOY PARA GITHUB
echo ================================
echo.

echo Verificando status do repositorio...
git status

echo.
echo Adicionando arquivos...
git add .

echo.
set /p commit_msg="Digite a mensagem do commit: "
git commit -m "%commit_msg%"

echo.
echo Fazendo push para GitHub...
git push origin main

echo.
echo ================================
echo     DEPLOY CONCLUIDO!
echo ================================
echo.
echo Repositorio: https://github.com/cleiton-negreiros/RID184204_Desafio07
echo.
pause
