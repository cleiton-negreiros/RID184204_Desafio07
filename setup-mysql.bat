@echo off
echo ========================================
echo  CONFIGURANDO MYSQL PARA API USUARIOS
echo ========================================
echo.

echo Verificando se Docker esta instalado...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker nao encontrado!
    echo.
    echo Por favor, instale o Docker Desktop:
    echo https://www.docker.com/products/docker-desktop
    echo.
    pause
    exit /b 1
)

echo ✅ Docker encontrado!
echo.

echo Parando container existente (se houver)...
docker stop mysql-api-usuarios 2>nul
docker rm mysql-api-usuarios 2>nul

echo.
echo Iniciando MySQL container...
docker run --name mysql-api-usuarios ^
  -e MYSQL_ROOT_PASSWORD=senha123 ^
  -e MYSQL_DATABASE=api_usuarios ^
  -p 3306:3306 ^
  -d mysql:8.0

if %errorlevel% equ 0 (
    echo.
    echo ✅ MySQL container iniciado com sucesso!
    echo.
    echo Configurações:
    echo - Host: localhost
    echo - Porta: 3306
    echo - Usuario: root
    echo - Senha: senha123
    echo - Banco: api_usuarios
    echo.
    echo Aguarde 30 segundos para o MySQL inicializar...
    timeout /t 30 /nobreak >nul
    echo.
    echo ✅ MySQL pronto para uso!
    echo.
    echo Pressione qualquer tecla para continuar...
    pause >nul
) else (
    echo.
    echo ❌ Erro ao iniciar container MySQL
    echo.
    pause
    exit /b 1
)
