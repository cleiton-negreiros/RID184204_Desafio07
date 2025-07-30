import {
  Controller,
  Get,
  Post,
  Put,
  Patch,
  Delete,
  Body,
  Param,
  ParseIntPipe,
  UseGuards,
  HttpStatus,
  HttpCode,
  Query,
} from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { Public } from '../auth/decorators/public.decorator';

@Controller('users')
@UseGuards(JwtAuthGuard) // Aplica JWT guard a todo o controlador
export class UserController {
  constructor(private readonly userService: UserService) {}

  /**
   * Registro público de usuários
   * POST /users/register
   */
  @Public() // Rota pública - não requer autenticação
  @Post('register')
  @HttpCode(HttpStatus.CREATED)
  async register(@Body() createUserDto: CreateUserDto) {
    return {
      success: true,
      message: 'User registered successfully',
      data: await this.userService.create(createUserDto),
    };
  }

  /**
   * Criar usuário (rota protegida para admins)
   * POST /users
   */
  @Post()
  @HttpCode(HttpStatus.CREATED)
  async create(@Body() createUserDto: CreateUserDto) {
    return {
      success: true,
      message: 'User created successfully',
      data: await this.userService.create(createUserDto),
    };
  }

  /**
   * Listar todos os usuários
   * GET /users
   */
  @Get()
  async findAll(@Query('active') active?: string) {
    const users = await this.userService.findAll();
    
    // Filtrar por status ativo se especificado
    const filteredUsers =
      active !== undefined
        ? users.filter((user) => user.isActive === (active === 'true'))
        : users;

    return {
      success: true,
      message: 'Users retrieved successfully',
      data: filteredUsers,
      count: filteredUsers.length,
    };
  }

  /**
   * Buscar usuário por ID
   * GET /users/:id
   */
  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number) {
    return {
      success: true,
      message: 'User retrieved successfully',
      data: await this.userService.findOne(id),
    };
  }

  /**
   * Atualizar usuário (PATCH - atualização parcial)
   * PATCH /users/:id
   */
  @Patch(':id')
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return {
      success: true,
      message: 'User updated successfully',
      data: await this.userService.update(id, updateUserDto),
    };
  }

  /**
   * Atualizar usuário completamente (PUT - substituição completa)
   * PUT /users/:id
   */
  @Put(':id')
  async replace(
    @Param('id', ParseIntPipe) id: number,
    @Body() createUserDto: CreateUserDto,
  ) {
    // Para PUT, primeiro verificamos se o usuário existe
    await this.userService.findOne(id);
    
    // Removemos o usuário atual e criamos um novo com os dados fornecidos
    await this.userService.hardDelete(id);
    
    return {
      success: true,
      message: 'User replaced successfully',
      data: await this.userService.create(createUserDto),
    };
  }

  /**
   * Desativar usuário (soft delete)
   * DELETE /users/:id
   */
  @Delete(':id')
  @HttpCode(HttpStatus.OK)
  async remove(@Param('id', ParseIntPipe) id: number) {
    const result = await this.userService.remove(id);
    return {
      success: true,
      message: result.message,
    };
  }

  /**
   * Deletar usuário permanentemente
   * DELETE /users/:id/permanent
   */
  @Delete(':id/permanent')
  @HttpCode(HttpStatus.OK)
  async hardDelete(@Param('id', ParseIntPipe) id: number) {
    const result = await this.userService.hardDelete(id);
    return {
      success: true,
      message: result.message,
    };
  }
}
