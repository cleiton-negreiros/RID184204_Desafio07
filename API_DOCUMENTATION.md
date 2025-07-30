# API de Usuários - NestJS + MySQL + JWT

Esta é uma API RESTful completa para gerenciamento de usuários com autenticação JWT.

## 🚀 Tecnologias Utilizadas

- **NestJS** - Framework Node.js
- **MySQL** - Banco de dados
- **TypeORM** - ORM para banco de dados
- **JWT** - Autenticação
- **bcryptjs** - Criptografia de senhas
- **class-validator** - Validação de dados

## 📋 Pré-requisitos

- Node.js (v14 ou superior)
- MySQL (v5.7 ou superior)
- npm ou yarn

## ⚙️ Instalação

1. Clone o repositório:

```bash
git clone <url-do-repositorio>
cd api-usuarios
```

2. Instale as dependências:

```bash
npm install
```

3. Configure o banco de dados MySQL:
   - Crie um banco de dados chamado `api_usuarios`
   - Configure as credenciais no arquivo `.env`

4. Configure as variáveis de ambiente:

```env
# Database Configuration
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=sua_senha_aqui
DB_DATABASE=api_usuarios

# JWT Configuration
JWT_SECRET=sua_chave_secreta_aqui_muito_forte_123456789
JWT_EXPIRES_IN=24h

# Application Configuration
PORT=3000
```

5. Inicie a aplicação:

```bash
npm run start:dev
```

## 📚 Endpoints da API

### Autenticação

#### Login

```http
POST /auth/login
Content-Type: application/json

{
  "email": "usuario@email.com",
  "password": "123456"
}
```

**Resposta:**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "email": "usuario@email.com",
    "firstName": "João",
    "lastName": "Silva"
  }
}
```

### Usuários

#### Registro de Usuário (Rota Pública)

```http
POST /users/register
Content-Type: application/json

{
  "email": "novo@email.com",
  "password": "123456",
  "firstName": "João",
  "lastName": "Silva"
}
```

#### Listar Todos os Usuários (Protegida)

```http
GET /users
Authorization: Bearer {token}
```

#### Buscar Usuário por ID (Protegida)

```http
GET /users/{id}
Authorization: Bearer {token}
```

#### Atualizar Usuário (Protegida)

```http
PATCH /users/{id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "firstName": "João Atualizado",
  "lastName": "Silva Atualizado"
}
```

#### Deletar Usuário (Protegida)

```http
DELETE /users/{id}
Authorization: Bearer {token}
```

## 🔐 Autenticação

Para acessar rotas protegidas, inclua o token JWT no header:

```
Authorization: Bearer {seu_token_aqui}
```

## 🏗️ Estrutura do Projeto

```
src/
├── auth/                  # Módulo de autenticação
│   ├── dto/              # DTOs de autenticação
│   ├── guards/           # Guards JWT
│   ├── strategies/       # Estratégias Passport
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   └── auth.module.ts
├── user/                 # Módulo de usuários
│   ├── dto/              # DTOs de usuário
│   ├── user.controller.ts
│   ├── user.service.ts
│   ├── user.entity.ts
│   └── user.module.ts
├── app.module.ts         # Módulo principal
└── main.ts              # Arquivo de entrada
```

## 🧪 Testando a API

### 1. Registrar um usuário:

```bash
curl -X POST http://localhost:3000/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "teste@email.com",
    "password": "123456",
    "firstName": "Teste",
    "lastName": "Usuario"
  }'
```

### 2. Fazer login:

```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "teste@email.com",
    "password": "123456"
  }'
```

### 3. Listar usuários (com token):

```bash
curl -X GET http://localhost:3000/users \
  -H "Authorization: Bearer SEU_TOKEN_AQUI"
```

## 🔧 Scripts Disponíveis

```bash
# Desenvolvimento
npm run start:dev

# Produção
npm run build
npm run start:prod

# Testes
npm run test
npm run test:e2e
```

## 🛡️ Segurança

- **Senhas criptografadas** com bcrypt
- **Tokens JWT** com expiração configurável
- **Validação de dados** de entrada
- **Rotas protegidas** por autenticação
- **CORS habilitado** para desenvolvimento

## 📝 Validações

- Email deve ser válido
- Senha deve ter pelo menos 6 caracteres
- Email deve ser único
- Campos obrigatórios validados automaticamente

## 🚦 Status Codes

- `200` - Sucesso
- `201` - Criado com sucesso
- `400` - Dados inválidos
- `401` - Não autorizado
- `404` - Não encontrado
- `409` - Conflito (ex: email já existe)
- `500` - Erro interno do servidor
