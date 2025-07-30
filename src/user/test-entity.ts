// Arquivo temporário para testar a estrutura da entidade User após a Etapa 02
import { User } from './user.entity';

// Teste da estrutura da entidade
const testUser: User = {
  id: 1,
  name: 'João Silva',
  username: 'joao_silva',
  email: 'joao@email.com',
  password: 'hashedPassword',
  isActive: true,
  createdAt: new Date(),
  updatedAt: new Date(),
};

console.log('Entidade User configurada corretamente com os campos:', Object.keys(testUser));
console.log('Estrutura esperada para Etapa 02: id, name, username, email, password');

export { testUser };
