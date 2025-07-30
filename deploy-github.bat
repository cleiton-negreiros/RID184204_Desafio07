@echo off
echo ================================
echo     DEPLOY PARA GITHUB
echo ================================
echo.

echo ATENCAO: Certifique-se de que o repositorio foi criado no GitHub primeiro!
echo.
echo Se ainda nao criou, acesse:
echo https://github.com/new
echo.
echo Nome do repositorio: RID184204_Desafio07
echo Descricao: API RESTful NestJS com TypeORM, JWT e CRUD de usuarios
echo Visibilidade: Public
echo NAO marque "Initialize with README"
echo.
echo Pressione qualquer tecla para continuar apos criar o repositorio...
pause
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
echo Verificando se o repositorio remoto esta configurado...
git remote -v

echo.
echo Fazendo push para GitHub...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo ❌ ERRO: Repositorio nao foi criado no GitHub ou nao esta acessivel
    echo.
    echo Para corrigir:
    echo 1. Crie o repositorio manualmente em: https://github.com/new
    echo 2. Nome: RID184204_Desafio07
    echo 3. Execute: git remote set-url origin https://github.com/cleiton-negreiros/RID184204_Desafio07.git
    echo 4. Execute: git push -u origin main
    echo.
) else (
    echo.
    echo ================================
    echo     DEPLOY CONCLUIDO!
    echo ================================
    echo.
    echo Repositorio: https://github.com/cleiton-negreiros/RID184204_Desafio07
    echo.
)
pause
