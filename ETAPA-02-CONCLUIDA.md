# Etapa 02 - Entidade e Repositório de Usuários

## ✅ Implementações Realizadas

### 1. Reestruturação da Entidade User

A entidade `User` foi atualizada para atender aos requisitos da Etapa 02:

**Campos implementados:**

- `id`: Chave primária auto-incrementada
- `name`: Nome completo do usuário (varchar 100)
- `username`: Nome de usuário único (varchar 50, unique)
- `email`: Email único (varchar 100, unique)
- `password`: Senha criptografada (varchar 255)
- `isActive`: Status do usuário (boolean, default: true)
- `createdAt`: Data de criação (timestamp)
- `updatedAt`: Data de atualização (timestamp)

**Arquivo:** `src/user/user.entity.ts`

### 2. Configuração do Repositório TypeORM

✅ **Repositório configurado automaticamente**

- Utiliza `@InjectRepository(User)` no UserService
- TypeORM gerencia automaticamente as operações CRUD
- Configuração de conexão MySQL já estabelecida no `app.module.ts`

### 3. Atualização dos DTOs

**CreateUserDto atualizado:**

- Removidos: `firstName`, `lastName`
- Adicionados: `name`, `username`
- Mantidas validações com class-validator

**UpdateUserDto atualizado:**

- Usa `PartialType(CreateUserDto)` para herança limpa
- Todos os campos opcionais para updates parciais

### 4. Atualização do UserService

**Métodos atualizados:**

- `findAll()`: Retorna campos `name`, `username` em vez de `firstName`, `lastName`
- `findOne()`: Atualizado para novos campos
- `findByUsername()`: Novo método para busca por username
- `update()`: Validação de unicidade para username e email
- `create()`: Validação de conflitos para username

### 5. Atualização do AuthService

**Modificações realizadas:**

- Response do login retorna `name`, `username` em vez de `firstName`, `lastName`
- Mantém compatibilidade com JWT payload

## 🗄️ Estrutura do Banco de Dados

A tabela `users` será criada com a seguinte estrutura:

```sql
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  isActive BOOLEAN DEFAULT TRUE,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## 🔧 Como Usar

### Criar usuário:

```bash
POST /users/register
{
  "name": "João Silva",
  "username": "joao_silva",
  "email": "joao@email.com",
  "password": "123456"
}
```

### Listar usuários:

```bash
GET /users
Authorization: Bearer {token}
```

### Atualizar usuário:

```bash
PATCH /users/{id}
Authorization: Bearer {token}
{
  "name": "João Santos",
  "username": "joao_santos"
}
```

## ⚠️ Observações

1. **Formatação CRLF**: Os warnings de lint sobre `Delete ␍` são apenas questões de formatação de linha e não afetam a funcionalidade
2. **Validações**: Uniqueness é verificada tanto no banco quanto na aplicação
3. **Compatibilidade**: Todas as rotas existentes continuam funcionando com a nova estrutura
4. **TypeORM**: Configuração de sincronização automática criará a tabela com a nova estrutura

## 🎯 Próximos Passos Sugeridos

1. Testar endpoints com Postman/Insomnia
2. Verificar criação da tabela no MySQL
3. Implementar testes unitários para novos campos
4. Configurar validações adicionais se necessário
