# 🚀 API de Usuários - NestJS

Uma API RESTful robusta desenvolvida com NestJS, TypeORM e autenticação JWT para gerenciamento completo de usuários.

![NestJS](https://img.shields.io/badge/nestjs-%23E0234E.svg?style=for-the-badge&logo=nestjs&logoColor=white)
![TypeScript](https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)

## 📋 Funcionalidades

- ✅ **CRUD Completo de Usuários** - Criar, listar, atualizar e remover usuários
- ✅ **Autenticação JWT** - Sistema seguro de login e proteção de rotas
- ✅ **Criptografia de Senhas** - Hash bcrypt com salt de 12 rounds
- ✅ **Validação de Dados** - Validação automática com class-validator
- ✅ **Banco de Dados Flexível** - Suporte para SQLite e MySQL
- ✅ **TypeORM** - ORM moderno com migrations e sincronização automática
- ✅ **Documentação Completa** - Guias de setup e troubleshooting

## 🛠️ Tecnologias

- **Framework:** NestJS 11.x
- **Linguagem:** TypeScript
- **ORM:** TypeORM 0.3.x
- **Banco de Dados:** SQLite (desenvolvimento) / MySQL (produção)
- **Autenticação:** JWT + Passport.js
- **Validação:** class-validator + class-transformer
- **Criptografia:** bcryptjs

## 🚀 Quick Start

### 1. Instalação

```bash
# Clone o repositório
git clone https://github.com/cleiton-negreiros/RID184204_Desafio07.git
cd RID184204_Desafio07

# Instale as dependências
npm install

# Configure SQLite (desenvolvimento)
npm run fix:sqlite
```

### 2. Configuração do Banco

**Opção A: SQLite (Recomendado para desenvolvimento)**

```bash
# Execute o script automático
fix-sqlite.bat
```

**Opção B: MySQL**

```bash
# Configure MySQL (veja MYSQL-SETUP.md)
setup-mysql.bat
```

### 3. Iniciar Aplicação

```bash
# Desenvolvimento
npm run start:dev

# Produção
npm run build
npm run start:prod
```

A API estará disponível em: `http://localhost:3000`

## 📚 Documentação da API

### 🔐 Autenticação

#### Registrar Usuário

```http
POST /users/register
Content-Type: application/json

{
  "name": "João Silva",
  "username": "joaosilva",
  "email": "joao@exemplo.com",
  "password": "senha123"
}
```

#### Login

```http
POST /auth/login
Content-Type: application/json

{
  "email": "joao@exemplo.com",
  "password": "senha123"
}
```

**Resposta:**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "name": "João Silva",
    "username": "joaosilva",
    "email": "joao@exemplo.com"
  }
}
```

### 👥 Gestão de Usuários

> **Nota:** Endpoints protegidos requerem header: `Authorization: Bearer {token}`

#### Listar Usuários

```http
GET /users
Authorization: Bearer {token}
```

#### Buscar Usuário

```http
GET /users/:id
Authorization: Bearer {token}
```

#### Atualizar Usuário

```http
PATCH /users/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "João Santos",
  "username": "joaosantos"
}
```

#### Remover Usuário

```http
DELETE /users/:id
Authorization: Bearer {token}
```

## 🏗️ Estrutura do Projeto

```
src/
├── auth/                    # Módulo de Autenticação
│   ├── auth.controller.ts   # Controlador de login
│   ├── auth.service.ts      # Lógica de autenticação
│   ├── auth.module.ts       # Módulo de autenticação
│   ├── dto/                 # DTOs de autenticação
│   ├── guards/              # Guards JWT
│   └── strategies/          # Estratégias Passport
│
├── user/                    # Módulo de Usuários
│   ├── user.controller.ts   # Controlador REST
│   ├── user.service.ts      # Lógica de negócio
│   ├── user.entity.ts       # Entidade TypeORM
│   ├── user.module.ts       # Módulo de usuários
│   └── dto/                 # DTOs de validação
│
├── app.module.ts            # Módulo principal
└── main.ts                  # Bootstrap da aplicação
```

## 🗃️ Modelo de Dados

### User Entity

```typescript
{
  id: number; // Auto incremento
  name: string; // Nome completo (max: 100)
  username: string; // Nome de usuário único (max: 50)
  email: string; // Email único (max: 100)
  password: string; // Hash bcrypt (max: 255)
  isActive: boolean; // Status ativo (default: true)
  createdAt: Date; // Data de criação
  updatedAt: Date; // Data de atualização
}
```

## 🔧 Scripts Disponíveis

```bash
# Desenvolvimento
npm run start:dev          # Inicia com hot-reload
npm run start:debug        # Inicia com debug

# Build
npm run build              # Compila TypeScript
npm run start:prod         # Inicia versão produção

# Testes
npm run test               # Testes unitários
npm run test:e2e           # Testes end-to-end
npm run test:cov           # Coverage de testes

# Utilitários
npm run lint               # ESLint
npm run format             # Prettier
```

## 🛠️ Scripts de Setup

- **`fix-sqlite.bat`** - Instala e configura SQLite automaticamente
- **`setup-mysql.bat`** - Configura MySQL com Docker
- **`start-api.bat`** - Inicia aplicação (desenvolvimento)

## 📖 Documentação Adicional

- [`MYSQL-SETUP.md`](./MYSQL-SETUP.md) - Guia completo de setup MySQL
- [`DATABASE-FIXED.md`](./DATABASE-FIXED.md) - Correções de banco aplicadas
- [`TROUBLESHOOTING.md`](./TROUBLESHOOTING.md) - Solução de problemas
- [`API_DOCUMENTATION.md`](./API_DOCUMENTATION.md) - Documentação detalhada da API

## 🚦 Status do Projeto

- ✅ **Etapa 01:** Configuração inicial do projeto
- ✅ **Etapa 02:** Entidade e Repositório de Usuários
- ✅ **Etapa 03:** Serviço e Controlador CRUD
- ✅ **Correções:** Erros TypeScript e dependências
- ✅ **Banco de Dados:** SQLite/MySQL configurados

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma feature branch: `git checkout -b feature/nova-feature`
3. Commit suas mudanças: `git commit -m 'Add nova feature'`
4. Push para a branch: `git push origin feature/nova-feature`
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

**Cleiton Negreiros**

- GitHub: [@cleiton-negreiros](https://github.com/cleiton-negreiros)

---

⭐ **Se este projeto foi útil, considere dar uma estrela!**
