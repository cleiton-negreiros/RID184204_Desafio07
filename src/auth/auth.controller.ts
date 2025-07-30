import {
  Controller,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  UseGuards,
  Get,
  Request,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { GetUser } from './decorators/get-user.decorator';
import { Public } from './decorators/public.decorator';

interface JwtUser {
  userId: number;
  username: string;
  name: string;
  email: string;
}

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  /**
   * Login de usuário
   * POST /auth/login
   */
  @Public()
  @HttpCode(HttpStatus.OK)
  @Post('login')
  async login(@Body() loginDto: LoginDto) {
    return this.authService.login(loginDto);
  }

  /**
   * Refresh token
   * POST /auth/refresh
   */
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  @Post('refresh')
  async refreshToken(@GetUser('userId') userId: number) {
    return this.authService.refreshToken(userId);
  }

  /**
   * Verificar token e obter perfil do usuário
   * GET /auth/profile
   */
  @UseGuards(JwtAuthGuard)
  @Get('profile')
  getProfile(@GetUser() user: JwtUser) {
    return {
      success: true,
      message: 'User profile retrieved successfully',
      data: {
        id: user.userId,
        email: user.email,
        name: user.name,
        username: user.username,
      },
    };
  }

  /**
   * Verificar se o token é válido
   * POST /auth/verify
   */
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  @Post('verify')
  verifyToken(@GetUser() user: JwtUser) {
    return {
      success: true,
      message: 'Token is valid',
      data: {
        valid: true,
        user: {
          id: user.userId,
          email: user.email,
          name: user.name,
          username: user.username,
        },
      },
    };
  }

  /**
   * Logout (endpoint informativo - o token deve ser removido no client)
   * POST /auth/logout
   */
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  @Post('logout')
  logout() {
    return {
      success: true,
      message:
        'Logout successful. Please remove the token from client storage.',
      data: {
        instruction:
          'Remove the JWT token from localStorage, sessionStorage, or cookies',
      },
    };
  }
}
