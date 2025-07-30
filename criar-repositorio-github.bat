@echo off
echo ================================================
echo     CRIAR REPOSITORIO NO GITHUB
echo ================================================
echo.

echo OPCAO 1: CRIAR MANUALMENTE NO GITHUB
echo.
echo 1. Acesse: https://github.com/cleiton-negreiros
echo 2. Clique em "New" ou "+" -^> "New repository"
echo 3. Repository name: RID184204_Desafio07
echo 4. Description: API RESTful NestJS com TypeORM, JWT e CRUD de usuarios
echo 5. Visibilidade: Public
echo 6. NAO marque "Initialize with README"
echo 7. Clique "Create repository"
echo.

echo OPCAO 2: USANDO GITHUB CLI (se instalada)
echo.
echo Verificando se GitHub CLI esta instalada...
gh --version >nul 2>&1
if %errorlevel% == 0 (
    echo GitHub CLI encontrada! Criando repositorio...
    gh repo create RID184204_Desafio07 --public --description "API RESTful NestJS com TypeORM, JWT e CRUD de usuarios"
    if %errorlevel% == 0 (
        echo.
        echo ✅ Repositorio criado com sucesso!
        echo.
        goto PUSH_CODE
    ) else (
        echo ❌ Erro ao criar repositorio. Use a opcao manual.
        goto MANUAL_INSTRUCTIONS
    )
) else (
    echo GitHub CLI nao encontrada.
    echo.
    goto MANUAL_INSTRUCTIONS
)

:MANUAL_INSTRUCTIONS
echo ================================================
echo     INSTRUCOES MANUAIS
echo ================================================
echo.
echo 1. Crie o repositorio manualmente no GitHub:
echo    https://github.com/new
echo.
echo 2. Depois de criar, execute este comando:
echo    git remote add origin https://github.com/cleiton-negreiros/RID184204_Desafio07.git
echo.
echo 3. Em seguida execute:
echo    git push -u origin main
echo.
pause
goto END

:PUSH_CODE
echo Configurando repositorio remoto...
git remote add origin https://github.com/cleiton-negreiros/RID184204_Desafio07.git

echo.
echo Fazendo push do codigo...
git push -u origin main

echo.
echo ================================================
echo     REPOSITORIO CRIADO E CODIGO ENVIADO!
echo ================================================
echo.
echo 🔗 URL: https://github.com/cleiton-negreiros/RID184204_Desafio07
echo.
echo Voce pode agora acessar o repositorio no GitHub!
echo.

:END
pause
