import { 
  Injectable, 
  NotFoundException, 
  ConflictException 
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcryptjs';
import { User } from './user.entity';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
  ) {}

  /**
   * Criar um novo usuário com senha criptografada
   */
  async create(createUserDto: CreateUserDto): Promise<Omit<User, 'password'>> {
    // Verificar se o email já existe
    const existingUserByEmail = await this.findByEmail(createUserDto.email);
    if (existingUserByEmail) {
      throw new ConflictException('User with this email already exists');
    }

    // Verificar se o username já existe
    const existingUserByUsername = await this.findByUsername(createUserDto.username);
    if (existingUserByUsername) {
      throw new ConflictException('User with this username already exists');
    }

    // Criptografar a senha usando bcrypt
    const saltRounds = 12;
    const hashedPassword = await bcrypt.hash(createUserDto.password, saltRounds);

    // Criar o usuário com senha criptografada
    const user = this.userRepository.create({
      ...createUserDto,
      password: hashedPassword,
    });

    const savedUser = await this.userRepository.save(user);
    
    // Retornar usuário sem a senha para segurança
    return this.excludePassword(savedUser);
  }

  /**
   * Listar todos os usuários (sem senhas)
   */
  async findAll(): Promise<Omit<User, 'password'>[]> {
    return this.userRepository.find({
      select: [
        'id',
        'name',
        'username',
        'email',
        'isActive',
        'createdAt',
        'updatedAt',
      ],
    }) as Promise<Omit<User, 'password'>[]>;
  }

  /**
   * Buscar usuário por ID (sem senha)
   */
  async findOne(id: number): Promise<Omit<User, 'password'>> {
    if (!id || id <= 0) {
      throw new NotFoundException('Invalid user ID');
    }

    const user = await this.userRepository.findOne({
      where: { id },
      select: [
        'id',
        'name',
        'username',
        'email',
        'isActive',
        'createdAt',
        'updatedAt',
      ],
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    return this.excludePassword(user);
  }

  /**
   * Buscar usuário por email (usado para autenticação)
   */
  async findByEmail(email: string): Promise<User | null> {
    return this.userRepository.findOne({ where: { email } });
  }

  /**
   * Buscar usuário por username
   */
  async findByUsername(username: string): Promise<User | null> {
    return this.userRepository.findOne({ where: { username } });
  }

  /**
   * Atualizar usuário existente
   */
  async update(id: number, updateUserDto: UpdateUserDto): Promise<Omit<User, 'password'>> {
    // Verificar se o usuário existe
    const user = await this.userRepository.findOne({ where: { id } });
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    // Verificar unicidade do email se está sendo atualizado
    if (updateUserDto.email && updateUserDto.email !== user.email) {
      const existingUser = await this.findByEmail(updateUserDto.email);
      if (existingUser) {
        throw new ConflictException('User with this email already exists');
      }
    }

    // Verificar unicidade do username se está sendo atualizado
    if (updateUserDto.username && updateUserDto.username !== user.username) {
      const existingUser = await this.findByUsername(updateUserDto.username);
      if (existingUser) {
        throw new ConflictException('User with this username already exists');
      }
    }

    // Criptografar nova senha se fornecida
    if (updateUserDto.password) {
      const saltRounds = 12;
      updateUserDto.password = await bcrypt.hash(updateUserDto.password, saltRounds);
    }

    // Atualizar usuário
    await this.userRepository.update(id, updateUserDto);
    
    // Retornar usuário atualizado sem senha
    const updatedUser = await this.userRepository.findOne({ where: { id } });
    return this.excludePassword(updatedUser!);
  }

  /**
   * Remover usuário (soft delete - marca como inativo)
   */
  async remove(id: number): Promise<{ message: string }> {
    const user = await this.userRepository.findOne({ where: { id } });
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    // Soft delete - marca como inativo ao invés de deletar
    await this.userRepository.update(id, { isActive: false });
    
    return { message: `User with ID ${id} has been deactivated successfully` };
  }

  /**
   * Deletar usuário permanentemente
   */
  async hardDelete(id: number): Promise<{ message: string }> {
    const user = await this.userRepository.findOne({ where: { id } });
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    await this.userRepository.remove(user);
    return { message: `User with ID ${id} has been permanently deleted` };
  }

  /**
   * Validar senha de usuário (para autenticação)
   */
  async validatePassword(user: User, password: string): Promise<boolean> {
    return bcrypt.compare(password, user.password);
  }

  /**
   * Método privado para remover senha dos dados de resposta
   */
  private excludePassword(user: User): Omit<User, 'password'> {
    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  }
}
