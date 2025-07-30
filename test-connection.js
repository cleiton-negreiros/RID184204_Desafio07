import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function testConnection() {
  try {
    console.log('🚀 Testando conexão da aplicação...');
    
    const app = await NestFactory.create(AppModule);
    
    console.log('✅ Aplicação criada com sucesso!');
    console.log('📦 Módulos carregados:');
    console.log('  - AppModule');
    console.log('  - UserModule');
    console.log('  - AuthModule');
    console.log('  - TypeOrmModule (MySQL)');
    
    await app.close();
    console.log('✅ Teste de conexão concluído com sucesso!');
    
  } catch (error) {
    console.error('❌ Erro durante o teste:', error.message);
    
    if (error.message.includes('ECONNREFUSED')) {
      console.log('\n🔧 Soluções possíveis:');
      console.log('1. Verifique se o MySQL está rodando');
      console.log('2. Verifique as configurações no arquivo .env');
      console.log('3. Execute: mysql -u root -p');
      console.log('4. Execute: CREATE DATABASE api_usuarios;');
    }
  }
}

testConnection();
