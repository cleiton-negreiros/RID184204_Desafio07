@echo off
REM ================================================
REM   RID184204_Desafio07 - LAUNCHER UNIVERSAL
REM ================================================
REM Este arquivo pode ser copiado para qualquer lugar
REM e sempre iniciara o projeto corretamente

title API RID184204_Desafio07 - Launcher

cls
echo.
echo  ██████╗ ██╗██████╗  ██╗ █████╗ ██╗  ██╗██████╗  ██████╗ ██╗  ██╗
echo  ██╔══██╗██║██╔══██╗███║██╔══██╗██║  ██║╚════██╗██╔═████╗██║  ██║
echo  ██████╔╝██║██║  ██║╚██║╚█████╔╝███████║ █████╔╝██║██╔██║███████║
echo  ██╔══██╗██║██║  ██║ ██║██╔══██╗╚════██║██╔═══╝ ████╔╝██║╚════██║
echo  ██║  ██║██║██████╔╝ ██║╚█████╔╝     ██║███████╗╚██████╔╝     ██║
echo  ╚═╝  ╚═╝╚═╝╚═════╝  ╚═╝ ╚════╝      ╚═╝╚══════╝ ╚═════╝      ╚═╝
echo.
echo                    DESAFIO 07 - API NESTJS
echo                   API RESTful com JWT e CRUD
echo.
echo ================================================

REM Configuracao do projeto
set PROJECT_NAME=RID184204_Desafio07
set PROJECT_PATH=C:\Users\cleit\Desktop\CODE\RID184204_Desafio07\api-usuarios
set GITHUB_URL=https://github.com/cleiton-negreiros/RID184204_Desafio07
set API_URL=http://localhost:3000

echo 📋 INFORMACOES DO PROJETO:
echo.
echo    📂 Nome: %PROJECT_NAME%
echo    📍 Path: %PROJECT_PATH%
echo    🔗 GitHub: %GITHUB_URL%
echo    🌐 API URL: %API_URL%
echo.

REM Menu de opcoes
:MENU
echo ================================================
echo                   MENU DE OPCOES
echo ================================================
echo.
echo    1. 🚀 Iniciar API
echo    2. 📦 Instalar dependencias
echo    3. 🔧 Corrigir SQLite
echo    4. 📖 Abrir documentacao
echo    5. 🌐 Abrir GitHub
echo    6. 📂 Abrir pasta do projeto
echo    7. 🧪 Executar testes
echo    8. 🔄 Deploy para GitHub
echo    9. ❌ Sair
echo.
set /p OPTION="Escolha uma opcao (1-9): "

if "%OPTION%"=="1" goto START_API
if "%OPTION%"=="2" goto INSTALL_DEPS
if "%OPTION%"=="3" goto FIX_SQLITE
if "%OPTION%"=="4" goto OPEN_DOCS
if "%OPTION%"=="5" goto OPEN_GITHUB
if "%OPTION%"=="6" goto OPEN_FOLDER
if "%OPTION%"=="7" goto RUN_TESTS
if "%OPTION%"=="8" goto DEPLOY
if "%OPTION%"=="9" goto EXIT

echo.
echo ❌ Opcao invalida! Tente novamente.
echo.
pause
cls
goto MENU

:START_API
cls
echo ================================================
echo              🚀 INICIANDO API
echo ================================================
echo.

if not exist "%PROJECT_PATH%" (
    echo ❌ ERRO: Projeto nao encontrado!
    echo Caminho: %PROJECT_PATH%
    echo.
    echo Solucoes:
    echo 1. Clone o projeto: git clone %GITHUB_URL%
    echo 2. Verifique se o caminho esta correto
    echo.
    pause
    goto MENU
)

cd /d "%PROJECT_PATH%"
call start-global.bat
goto END

:INSTALL_DEPS
cls
echo ================================================
echo            📦 INSTALANDO DEPENDENCIAS
echo ================================================
echo.
cd /d "%PROJECT_PATH%"
call npm install
echo.
pause
goto MENU

:FIX_SQLITE
cls
echo ================================================
echo              🔧 CORRIGINDO SQLITE
echo ================================================
echo.
cd /d "%PROJECT_PATH%"
call fix-sqlite.bat
echo.
pause
goto MENU

:OPEN_DOCS
echo.
echo 📖 Abrindo documentacao...
start "" "%PROJECT_PATH%\README.md"
goto MENU

:OPEN_GITHUB
echo.
echo 🌐 Abrindo GitHub...
start "" "%GITHUB_URL%"
goto MENU

:OPEN_FOLDER
echo.
echo 📂 Abrindo pasta do projeto...
start "" "%PROJECT_PATH%"
goto MENU

:RUN_TESTS
cls
echo ================================================
echo                🧪 EXECUTANDO TESTES
echo ================================================
echo.
cd /d "%PROJECT_PATH%"
call npm test
echo.
pause
goto MENU

:DEPLOY
cls
echo ================================================
echo              🔄 DEPLOY PARA GITHUB
echo ================================================
echo.
cd /d "%PROJECT_PATH%"
call deploy-github.bat
echo.
pause
goto MENU

:EXIT
echo.
echo 👋 Obrigado por usar o RID184204_Desafio07!
echo.
timeout /t 2 /nobreak >nul

:END
exit
