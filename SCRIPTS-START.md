# 🚀 Scripts de Inicialização - RID184204_Desafio07

## 📋 Scripts Disponíveis

### 1. **start-global.bat** 🌟

**Script principal para iniciar a API de qualquer lugar**

- ✅ Verifica dependências automaticamente
- ✅ Instala SQLite se necessário
- ✅ Caminho absoluto configurado
- ✅ Interface detalhada com instruções

**Como usar:**

```bash
# Execute de qualquer lugar
start-global.bat
```

### 2. **launcher.bat** 🎮

**Menu interativo completo com todas as opções**

- ✅ Interface visual com ASCII art
- ✅ Menu de opções (1-9)
- ✅ Instalar dependências
- ✅ Corrigir SQLite
- ✅ Abrir documentação
- ✅ Deploy para GitHub
- ✅ Executar testes

**Como usar:**

```bash
launcher.bat
```

### 3. **start-api-full-path.bat** 📂

**Script básico com caminho completo**

- ✅ Navega para o diretório do projeto
- ✅ Verifica dependências
- ✅ Inicia aplicação

### 4. **Scripts npm personalizados**

Adicionados no `package.json`:

```json
{
  "scripts": {
    "start:api": "cd /d \"C:\\Users\\cleit\\Desktop\\CODE\\RID184204_Desafio07\\api-usuarios\" && npm run start:dev",
    "start:full": "echo Iniciando API RID184204_Desafio07 && cd /d \"C:\\Users\\cleit\\Desktop\\CODE\\RID184204_Desafio07\\api-usuarios\" && npm run start:dev",
    "start:project": "start-global.bat"
  }
}
```

## 🎯 Uso Recomendado

### Para Desenvolvimento Diário:

```bash
launcher.bat
# Escolha opção 1 para iniciar
```

### Para Início Rápido:

```bash
start-global.bat
```

### Para Usar npm:

```bash
npm run start:project
```

## 📍 Caminhos Configurados

Todos os scripts estão configurados com o caminho absoluto:

```
C:\Users\cleit\Desktop\CODE\RID184204_Desafio07\api-usuarios
```

## 🔧 Funcionalidades dos Scripts

### ✅ Verificações Automáticas:

- Existência do diretório do projeto
- Instalação de dependências npm
- Configuração do SQLite
- Verificação de arquivos essenciais

### ✅ Instalação Automática:

- node_modules (se não existir)
- sqlite3 (se não estiver instalado)
- Criação do .env (se necessário)

### ✅ Informações Úteis:

- URL da API (http://localhost:3000)
- Lista de endpoints disponíveis
- Instruções de uso
- Links para ferramentas (Postman, Insomnia)

## 🎮 Menu do Launcher

```
1. 🚀 Iniciar API
2. 📦 Instalar dependencias
3. 🔧 Corrigir SQLite
4. 📖 Abrir documentacao
5. 🌐 Abrir GitHub
6. 📂 Abrir pasta do projeto
7. 🧪 Executar testes
8. 🔄 Deploy para GitHub
9. ❌ Sair
```

## 🚀 Primeiros Passos

1. **Execute o launcher:**

   ```bash
   launcher.bat
   ```

2. **Ou inicie diretamente:**

   ```bash
   start-global.bat
   ```

3. **A API estará em:**
   ```
   http://localhost:3000
   ```

## 📋 Endpoints da API

- `POST /users/register` - Cadastrar usuário
- `POST /auth/login` - Login (retorna JWT)
- `GET /users` - Listar usuários (requer JWT)
- `GET /users/:id` - Buscar usuário (requer JWT)
- `PATCH /users/:id` - Atualizar usuário (requer JWT)
- `DELETE /users/:id` - Remover usuário (requer JWT)

---

**💡 Dica:** O `launcher.bat` é o mais completo e recomendado para uso diário!
