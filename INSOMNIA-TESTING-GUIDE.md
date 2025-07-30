# 🧪 Guia de Testes da API no Insomnia

## 📋 **Informações Gerais**

- **Base URL**: `http://localhost:3000`
- **Content-Type**: `application/json`
- **Authorization**: `Bearer {token}` (para rotas protegidas)

---

## 🔐 **1. AUTENTICAÇÃO**

### 🟢 **Login de Usuário**

**Endpoint**: `POST /auth/login`  
**Proteção**: 🔓 Público  
**Headers**:

```json
{
  "Content-Type": "application/json"
}
```

**Payload**:

```json
{
  "email": "usuario@email.com",
  "password": "senha123"
}
```

**Resposta esperada**:

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": "24h",
  "user": {
    "id": 1,
    "name": "João Silva",
    "username": "joaosilva",
    "email": "usuario@email.com",
    "isActive": true,
    "createdAt": "2025-01-15T10:30:00.000Z"
  }
}
```

### 🟡 **Obter Perfil do Usuário**

**Endpoint**: `GET /auth/profile`  
**Proteção**: 🔒 JWT Required  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "User profile retrieved successfully",
  "data": {
    "id": 1,
    "email": "usuario@email.com",
    "name": "João Silva",
    "username": "joaosilva"
  }
}
```

### 🟡 **Renovar Token**

**Endpoint**: `POST /auth/refresh`  
**Proteção**: 🔒 JWT Required  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": "24h",
  "user": {
    "id": 1,
    "name": "João Silva",
    "username": "joaosilva",
    "email": "usuario@email.com",
    "isActive": true,
    "createdAt": "2025-01-15T10:30:00.000Z"
  }
}
```

### 🟡 **Verificar Token**

**Endpoint**: `POST /auth/verify`  
**Proteção**: 🔒 JWT Required  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "Token is valid",
  "data": {
    "valid": true,
    "user": {
      "id": 1,
      "email": "usuario@email.com",
      "name": "João Silva",
      "username": "joaosilva"
    }
  }
}
```

### 🟡 **Logout**

**Endpoint**: `POST /auth/logout`  
**Proteção**: 🔒 JWT Required  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "Logout successful. Please remove the token from client storage.",
  "data": {
    "instruction": "Remove the JWT token from localStorage, sessionStorage, or cookies"
  }
}
```

---

## 👥 **2. GERENCIAMENTO DE USUÁRIOS**

### 🟢 **Registro de Usuário (Público)**

**Endpoint**: `POST /users/register`  
**Proteção**: 🔓 Público  
**Headers**:

```json
{
  "Content-Type": "application/json"
}
```

**Payload**:

```json
{
  "name": "João Silva",
  "username": "joaosilva",
  "email": "joao@email.com",
  "password": "senha123"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "id": 1,
    "name": "João Silva",
    "username": "joaosilva",
    "email": "joao@email.com",
    "isActive": true,
    "createdAt": "2025-01-15T10:30:00.000Z",
    "updatedAt": "2025-01-15T10:30:00.000Z"
  }
}
```

### 🟡 **Criar Usuário (Protegido)**

**Endpoint**: `POST /users`  
**Proteção**: 🔒 JWT Required  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Payload**:

```json
{
  "name": "Maria Santos",
  "username": "mariasantos",
  "email": "maria@email.com",
  "password": "senha456"
}
```

### 🟡 **Listar Todos os Usuários**

**Endpoint**: `GET /users`  
**Proteção**: 🔒 JWT Required  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Query Parameters** (opcionais):

- `?active=true` - Apenas usuários ativos
- `?active=false` - Apenas usuários inativos

**Resposta esperada**:

```json
{
  "success": true,
  "message": "Users retrieved successfully",
  "data": [
    {
      "id": 1,
      "name": "João Silva",
      "username": "joaosilva",
      "email": "joao@email.com",
      "isActive": true,
      "createdAt": "2025-01-15T10:30:00.000Z",
      "updatedAt": "2025-01-15T10:30:00.000Z"
    },
    {
      "id": 2,
      "name": "Maria Santos",
      "username": "mariasantos",
      "email": "maria@email.com",
      "isActive": true,
      "createdAt": "2025-01-15T11:00:00.000Z",
      "updatedAt": "2025-01-15T11:00:00.000Z"
    }
  ]
}
```

### 🟡 **Buscar Usuário por ID**

**Endpoint**: `GET /users/{id}`  
**Proteção**: 🔒 JWT Required  
**Exemplo**: `GET /users/1`  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "User retrieved successfully",
  "data": {
    "id": 1,
    "name": "João Silva",
    "username": "joaosilva",
    "email": "joao@email.com",
    "isActive": true,
    "createdAt": "2025-01-15T10:30:00.000Z",
    "updatedAt": "2025-01-15T10:30:00.000Z"
  }
}
```

### 🟡 **Atualizar Usuário (Parcial)**

**Endpoint**: `PATCH /users/{id}`  
**Proteção**: 🔒 JWT Required  
**Exemplo**: `PATCH /users/1`  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Payload** (todos os campos são opcionais):

```json
{
  "name": "João Silva Santos",
  "email": "joao.santos@email.com"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "User updated successfully",
  "data": {
    "id": 1,
    "name": "João Silva Santos",
    "username": "joaosilva",
    "email": "joao.santos@email.com",
    "isActive": true,
    "createdAt": "2025-01-15T10:30:00.000Z",
    "updatedAt": "2025-01-15T12:00:00.000Z"
  }
}
```

### 🟡 **Substituir Usuário (Completo)**

**Endpoint**: `PUT /users/{id}`  
**Proteção**: 🔒 JWT Required  
**Exemplo**: `PUT /users/1`  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Payload** (todos os campos obrigatórios):

```json
{
  "name": "João Silva Completo",
  "username": "joaosilva",
  "email": "joao.completo@email.com",
  "password": "novaSenha789"
}
```

### 🟡 **Desativar Usuário (Soft Delete)**

**Endpoint**: `DELETE /users/{id}`  
**Proteção**: 🔒 JWT Required  
**Exemplo**: `DELETE /users/1`  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "User deactivated successfully"
}
```

### 🟡 **Deletar Usuário Permanentemente**

**Endpoint**: `DELETE /users/{id}/permanent`  
**Proteção**: 🔒 JWT Required  
**Exemplo**: `DELETE /users/1/permanent`  
**Headers**:

```json
{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
{
  "success": true,
  "message": "User permanently deleted"
}
```

---

## 🏠 **3. ENDPOINT PRINCIPAL**

### 🟢 **Health Check**

**Endpoint**: `GET /`  
**Proteção**: 🔓 Público  
**Headers**:

```json
{
  "Content-Type": "application/json"
}
```

**Resposta esperada**:

```json
"Hello World!"
```

---

## 🔄 **4. FLUXO DE TESTE COMPLETO**

### **Passo 1: Registrar um usuário**

```http
POST http://localhost:3000/users/register
Content-Type: application/json

{
  "name": "Teste Usuario",
  "username": "testeusuario",
  "email": "teste@email.com",
  "password": "senha123"
}
```

### **Passo 2: Fazer login**

```http
POST http://localhost:3000/auth/login
Content-Type: application/json

{
  "email": "teste@email.com",
  "password": "senha123"
}
```

### **Passo 3: Usar o token retornado**

Copie o `access_token` da resposta e use nos próximos requests:

### **Passo 4: Acessar perfil**

```http
GET http://localhost:3000/auth/profile
Authorization: Bearer {SEU_TOKEN_AQUI}
Content-Type: application/json
```

### **Passo 5: Listar usuários**

```http
GET http://localhost:3000/users
Authorization: Bearer {SEU_TOKEN_AQUI}
Content-Type: application/json
```

---

## ⚠️ **5. CÓDIGOS DE STATUS ESPERADOS**

| Endpoint          | Método | Sucesso | Erro Comum                   |
| ----------------- | ------ | ------- | ---------------------------- |
| `/auth/login`     | POST   | 200     | 401 (credenciais inválidas)  |
| `/auth/profile`   | GET    | 200     | 401 (token inválido)         |
| `/users/register` | POST   | 201     | 409 (email/username existe)  |
| `/users`          | GET    | 200     | 401 (não autenticado)        |
| `/users/:id`      | GET    | 200     | 404 (usuário não encontrado) |
| `/users/:id`      | PATCH  | 200     | 404 (usuário não encontrado) |
| `/users/:id`      | DELETE | 200     | 404 (usuário não encontrado) |

---

## 🚨 **6. EXEMPLOS DE ERROS**

### **401 - Não Autenticado**

```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

### **409 - Conflito (Email já existe)**

```json
{
  "statusCode": 409,
  "message": "User with this email already exists"
}
```

### **404 - Usuário não encontrado**

```json
{
  "statusCode": 404,
  "message": "User with ID 999 not found"
}
```

### **400 - Dados inválidos**

```json
{
  "statusCode": 400,
  "message": [
    "email must be an email",
    "password must be longer than or equal to 6 characters"
  ],
  "error": "Bad Request"
}
```

---

## 📥 **7. COLLECTION DO INSOMNIA**

### **Importar Collection**

Você pode criar uma collection no Insomnia com estas configurações:

1. **Environment Variables**:
   - `base_url`: `http://localhost:3000`
   - `token`: `Bearer {seu_token_aqui}`

2. **Requests organizados por pastas**:
   - 📁 **Auth** (login, profile, refresh, verify, logout)
   - 📁 **Users** (register, create, list, get, update, delete)
   - 📁 **Health** (health check)

### **Como usar no Insomnia**:

1. Crie um **Environment** com `base_url` = `http://localhost:3000`
2. Faça login primeiro em `/auth/login`
3. Copie o `access_token` da resposta
4. Configure a variável `token` no Environment
5. Use `{{ token }}` nos headers Authorization dos requests protegidos

---

## 🎯 **Pronto para testar!**

Com este guia, você tem tudo o que precisa para testar completamente a API no Insomnia. Lembre-se de sempre iniciar com o registro/login para obter o token JWT necessário para as rotas protegidas! 🚀
