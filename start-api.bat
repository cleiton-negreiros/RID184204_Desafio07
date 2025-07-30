@echo off
echo ================================
echo  TESTE DA API DE USUARIOS
echo ================================
echo.

echo 1. Verificando se as dependencias estao instaladas...
if not exist "node_modules" (
    echo ❌ node_modules nao encontrado. Execute: npm install
    pause
    exit /b 1
)
echo ✅ Dependencias encontradas

echo.
echo 2. Tentando compilar o projeto...
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Erro na compilacao
    pause
    exit /b 1
)
echo ✅ Compilacao bem-sucedida

echo.
echo 3. Verificando arquivos principais...
if not exist "src\app.module.ts" echo ❌ app.module.ts nao encontrado
if not exist "src\user\user.module.ts" echo ❌ user.module.ts nao encontrado
if not exist "src\auth\auth.module.ts" echo ❌ auth.module.ts nao encontrado
echo ✅ Arquivos principais encontrados

echo.
echo 4. Verificando arquivo .env...
if not exist ".env" (
    echo ⚠️  Arquivo .env nao encontrado. Criando exemplo...
    echo DB_HOST=localhost > .env
    echo DB_PORT=3306 >> .env
    echo DB_USERNAME=root >> .env
    echo DB_PASSWORD= >> .env
    echo DB_DATABASE=api_usuarios >> .env
    echo JWT_SECRET=sua_chave_secreta_aqui_muito_forte_123456789 >> .env
    echo JWT_EXPIRES_IN=24h >> .env
    echo PORT=3000 >> .env
    echo ✅ Arquivo .env criado
) else (
    echo ✅ Arquivo .env encontrado
)

echo.
echo 5. Iniciando aplicacao...
echo ⚠️  Certifique-se que o MySQL esta rodando
echo ⚠️  Execute: net start mysql80 (Windows)
echo.
call npm run start:dev
