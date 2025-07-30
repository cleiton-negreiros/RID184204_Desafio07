@echo off
echo ================================
echo     INICIAR API RID184204_Desafio07
echo ================================
echo.

echo 📂 Projeto: API de Usuarios - NestJS
echo 📍 Caminho: C:\Users\cleit\Desktop\CODE\RID184204_Desafio07\api-usuarios
echo.

echo Mudando para o diretorio do projeto...
cd /d "C:\Users\cleit\Desktop\CODE\RID184204_Desafio07\api-usuarios"

if %errorlevel% neq 0 (
    echo ❌ Erro: Nao foi possivel acessar o diretorio do projeto!
    echo.
    echo Verifique se o caminho existe:
    echo C:\Users\cleit\Desktop\CODE\RID184204_Desafio07\api-usuarios
    echo.
    pause
    exit /b 1
)

echo ✅ Diretorio acessado com sucesso
echo.

echo Verificando se as dependencias estao instaladas...
if not exist "node_modules" (
    echo.
    echo ⚠️  Node_modules nao encontrado. Instalando dependencias...
    call npm install
    if %errorlevel% neq 0 (
        echo.
        echo ❌ Erro ao instalar dependencias!
        pause
        exit /b 1
    )
    echo ✅ Dependencias instaladas
)

echo.
echo Verificando se o banco SQLite esta configurado...
if not exist "database.sqlite" (
    echo.
    echo ⚠️  Banco SQLite nao encontrado.
    echo.
    choice /C YN /M "Deseja instalar SQLite automaticamente agora"
    if errorlevel 2 goto SKIP_SQLITE
    if errorlevel 1 (
        echo.
        echo Instalando SQLite...
        call npm install sqlite3
        if %errorlevel% neq 0 (
            echo ❌ Erro ao instalar SQLite!
            echo Execute manualmente: fix-sqlite.bat
            pause
            exit /b 1
        )
        echo ✅ SQLite instalado
    )
)

:SKIP_SQLITE
echo.
echo ================================
echo     INICIANDO APLICACAO...
echo ================================
echo.
echo 🚀 Servidor iniciando em: http://localhost:3000
echo.
echo 📋 Endpoints disponiveis:
echo    POST /users/register - Cadastrar usuario
echo    POST /auth/login - Login  
echo    GET /users - Listar usuarios (requer JWT)
echo    GET /users/:id - Buscar usuario (requer JWT)
echo    PATCH /users/:id - Atualizar usuario (requer JWT)
echo    DELETE /users/:id - Remover usuario (requer JWT)
echo.
echo 💡 Para testar a API, use um cliente REST como:
echo    - Postman: https://www.postman.com/
echo    - Insomnia: https://insomnia.rest/
echo    - Thunder Client (VS Code Extension)
echo.
echo ⏹️  Para parar o servidor: Ctrl + C
echo.

call npm run start:dev

echo.
echo ================================
echo     APLICACAO FINALIZADA
echo ================================
echo.
pause
