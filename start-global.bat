@echo off
REM ================================
REM   SCRIPT GLOBAL - RID184204_Desafio07
REM ================================
REM Este script pode ser executado de qualquer lugar

echo ================================
echo   API RID184204_Desafio07 - STARTER
echo ================================
echo.

REM Define o caminho absoluto do projeto
set PROJECT_PATH=C:\Users\cleit\Desktop\CODE\RID184204_Desafio07\api-usuarios

echo 📂 Projeto: API de Usuarios NestJS
echo 📍 Caminho: %PROJECT_PATH%
echo 🎯 Desafio: RID184204_Desafio07
echo.

REM Verifica se o diretorio existe
if not exist "%PROJECT_PATH%" (
    echo ❌ ERRO: Diretorio do projeto nao encontrado!
    echo.
    echo Caminho verificado: %PROJECT_PATH%
    echo.
    echo Possiveis solucoes:
    echo 1. Verifique se o projeto foi clonado corretamente
    echo 2. Atualize o caminho no script se necessario
    echo 3. Clone novamente: git clone https://github.com/cleiton-negreiros/RID184204_Desafio07.git
    echo.
    pause
    exit /b 1
)

echo ✅ Diretorio do projeto encontrado
echo.

REM Muda para o diretorio do projeto
echo Acessando diretorio do projeto...
cd /d "%PROJECT_PATH%"

if %errorlevel% neq 0 (
    echo ❌ Erro ao acessar o diretorio do projeto
    pause
    exit /b 1
)

echo ✅ Diretorio acessado: %cd%
echo.

REM Verifica dependencias
echo Verificando dependencias npm...
if not exist "node_modules" (
    echo.
    echo ⚠️  Dependencias nao encontradas. Instalando...
    echo Este processo pode demorar alguns minutos...
    echo.
    call npm install
    
    if %errorlevel% neq 0 (
        echo ❌ Erro ao instalar dependencias!
        echo.
        echo Tente executar manualmente:
        echo cd "%PROJECT_PATH%"
        echo npm install
        echo.
        pause
        exit /b 1
    )
    
    echo ✅ Dependencias instaladas com sucesso
) else (
    echo ✅ Dependencias ja instaladas
)

echo.

REM Verifica SQLite
echo Verificando banco de dados SQLite...
call npm list sqlite3 >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ⚠️  SQLite nao encontrado. Instalando...
    call npm install sqlite3
    
    if %errorlevel% neq 0 (
        echo ❌ Erro ao instalar SQLite!
        echo Execute manualmente: npm install sqlite3
        pause
        exit /b 1
    )
    
    echo ✅ SQLite instalado
) else (
    echo ✅ SQLite ja instalado
)

echo.
echo ================================
echo     INICIANDO APLICACAO
echo ================================
echo.
echo 🚀 Servidor sera iniciado em: http://localhost:3000
echo.
echo 📋 ENDPOINTS DISPONIVEIS:
echo.
echo 🔐 AUTENTICACAO:
echo    POST /users/register  - Cadastrar novo usuario
echo    POST /auth/login      - Fazer login (retorna JWT)
echo.
echo 👥 USUARIOS (requer JWT no header Authorization):
echo    GET    /users         - Listar todos usuarios
echo    GET    /users/:id     - Buscar usuario por ID
echo    PATCH  /users/:id     - Atualizar usuario
echo    DELETE /users/:id     - Remover usuario
echo.
echo 💡 EXEMPLO DE USO:
echo    1. POST /users/register com: name, username, email, password
echo    2. POST /auth/login com: email, password
echo    3. Use o token retornado no header: Authorization: Bearer {token}
echo.
echo 🛠️  FERRAMENTAS RECOMENDADAS:
echo    - Postman: https://www.postman.com/
echo    - Insomnia: https://insomnia.rest/
echo    - Thunder Client (VS Code)
echo.
echo ⏹️  Para parar: Ctrl + C no terminal
echo.

REM Inicia a aplicacao
call npm run start:dev

echo.
echo ================================
echo     APLICACAO ENCERRADA
echo ================================
echo.
echo Obrigado por usar a API RID184204_Desafio07!
echo.
pause
