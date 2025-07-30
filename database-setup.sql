-- Script para criar o banco de dados MySQL
CREATE DATABASE IF NOT EXISTS api_usuarios CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Opcional: Criar um usuário específico para a aplicação
-- CREATE USER 'api_user'@'localhost' IDENTIFIED BY 'senha_forte';
-- GRANT ALL PRIVILEGES ON api_usuarios.* TO 'api_user'@'localhost';
-- FLUSH PRIVILEGES;

-- Use o banco criado
USE api_usuarios;

-- O TypeORM criará as tabelas automaticamente devido ao synchronize: true