import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcryptjs';
import { UserService } from '../user/user.service';
import { LoginDto } from './dto/login.dto';

interface ValidatedUser {
  id: number;
  name: string;
  username: string;
  email: string;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

interface JwtPayload {
  email: string;
  sub: number;
  username: string;
  name: string;
  iat?: number;
}

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  async validateUser(email: string, password: string): Promise<ValidatedUser> {
    const user = await this.userService.findByEmail(email);
    
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    if (!user.isActive) {
      throw new UnauthorizedException('User account is inactive');
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Remove senha do objeto retornado
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password: _, ...result } = user;
    return result;
  }

  async login(loginDto: LoginDto) {
    const user: ValidatedUser = await this.validateUser(
      loginDto.email,
      loginDto.password,
    );

    const payload: JwtPayload = {
      email: user.email,
      sub: user.id,
      username: user.username,
      name: user.name,
      iat: Math.floor(Date.now() / 1000), // Issued at
    };

    const token = this.jwtService.sign(payload);

    return {
      access_token: token,
      token_type: 'Bearer',
      expires_in: process.env.JWT_EXPIRES_IN || '24h',
      user: {
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        isActive: user.isActive,
        createdAt: user.createdAt,
      },
    };
  }

  async refreshToken(userId: number) {
    const user = await this.userService.findOne(userId);
    
    if (!user || !user.isActive) {
      throw new UnauthorizedException('User not found or inactive');
    }

    const payload: JwtPayload = {
      email: user.email,
      sub: user.id,
      username: user.username,
      name: user.name,
      iat: Math.floor(Date.now() / 1000),
    };

    return {
      access_token: this.jwtService.sign(payload),
      token_type: 'Bearer',
      expires_in: process.env.JWT_EXPIRES_IN || '24h',
    };
  }

  async verifyToken(token: string): Promise<JwtPayload> {
    try {
      const payload: JwtPayload = this.jwtService.verify(token);
      const user = await this.userService.findOne(payload.sub);
      
      if (!user || !user.isActive) {
        throw new UnauthorizedException('Token invalid or user inactive');
      }

      return payload;
    } catch {
      throw new UnauthorizedException('Invalid or expired token');
    }
  }
}
