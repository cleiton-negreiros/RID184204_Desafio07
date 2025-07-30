# 🔧 CORREÇÃO DO ERRO DE CONEXÃO MYSQL

## 🔴 **Problema Identificado:**

```
[TypeOrmModule] Unable to connect to the database. Retrying...
AggregateError [ECONNREFUSED]: connect ECONNREFUSED 127.0.0.1:3306
```

**Causa:** MySQL não está instalado ou não está rodando na porta 3306.

## 🛠️ **SOLUÇÕES DISPONÍVEIS:**

### **OPÇÃO 1: Instalar MySQL Localmente** 💻

#### **Passo 1: Download e Instalação**

1. Acesse: https://dev.mysql.com/downloads/mysql/
2. Baixe MySQL Community Server para Windows
3. Execute o instalador e siga o wizard
4. **Importante:** Anote a senha do usuário `root`

#### **Passo 2: Configuração**

```sql
-- Criar banco de dados
CREATE DATABASE api_usuarios;

-- Criar usuário (opcional)
CREATE USER 'api_user'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON api_usuarios.* TO 'api_user'@'localhost';
FLUSH PRIVILEGES;
```

#### **Passo 3: Atualizar .env**

```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=sua_senha_mysql
DB_DATABASE=api_usuarios
```

---

### **OPÇÃO 2: Usar Docker (Recomendado)** 🐳

#### **Passo 1: Instalar Docker Desktop**

- Download: https://www.docker.com/products/docker-desktop

#### **Passo 2: Executar MySQL via Docker**

```bash
# Criar e executar container MySQL
docker run --name mysql-api-usuarios \
  -e MYSQL_ROOT_PASSWORD=senha123 \
  -e MYSQL_DATABASE=api_usuarios \
  -p 3306:3306 \
  -d mysql:8.0

# Verificar se está rodando
docker ps
```

#### **Passo 3: Atualizar .env**

```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=senha123
DB_DATABASE=api_usuarios
```

---

### **OPÇÃO 3: Usar XAMPP** 🔥

#### **Passo 1: Instalar XAMPP**

- Download: https://www.apachefriends.org/pt_br/index.html

#### **Passo 2: Iniciar MySQL**

1. Abrir XAMPP Control Panel
2. Clicar em "Start" ao lado de MySQL
3. Verificar se aparece "Running" em verde

#### **Passo 3: Criar Banco via phpMyAdmin**

1. Acessar: http://localhost/phpmyadmin
2. Criar novo banco: `api_usuarios`

#### **Passo 4: Atualizar .env**

```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=
DB_DATABASE=api_usuarios
```

---

### **OPÇÃO 4: MySQL Online (Para Testes)** ☁️

#### **Serviços Gratuitos:**

- **db4free.net** (MySQL gratuito)
- **PlanetScale** (MySQL serverless)
- **Railway** (PostgreSQL/MySQL)

#### **Exemplo com db4free.net:**

```env
DB_HOST=db4free.net
DB_PORT=3306
DB_USERNAME=seu_usuario
DB_PASSWORD=sua_senha
DB_DATABASE=seu_banco
```

---

## 🚀 **SOLUÇÃO RÁPIDA PARA TESTAR:**

### **Usar SQLite (Sem instalação externa)**

#### **Passo 1: Instalar dependência**

```bash
npm install sqlite3
```

#### **Passo 2: Atualizar app.module.ts**

```typescript
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: 'database.sqlite',
      entities: [User],
      synchronize: true,
    }),
    // ... outros imports
  ],
})
```

## 🎯 **RECOMENDAÇÃO:**

**Para desenvolvimento local:** Use **Docker** (Opção 2) - mais simples e isolado
**Para testes rápidos:** Use **SQLite** (Solução Rápida) - zero configuração
**Para produção:** Use **MySQL dedicado** (Opção 1) - mais robusta

## ✅ **Próximos Passos:**

1. Escolha uma das opções acima
2. Configure conforme instruções
3. Atualize o arquivo `.env`
4. Reinicie a aplicação: `npm run start:dev`

**Qual opção você prefere que eu configure primeiro?** 🤔
