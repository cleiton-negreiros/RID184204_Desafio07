import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UserService } from '../../user/user.service';

interface JwtPayload {
  sub: number;
  email: string;
  username: string;
  name: string;
  iat?: number;
}

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly userService: UserService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey:
        process.env.JWT_SECRET ||
        'sua_chave_secreta_aqui_muito_forte_123456789',
      algorithms: ['HS256'], // Especifica o algoritmo para maior segurança
    });
  }

  async validate(payload: JwtPayload) {
    // Valida se o usuário ainda existe e está ativo
    const user = await this.userService.findOne(payload.sub);
    if (!user || !user.isActive) {
      throw new UnauthorizedException('User not found or inactive');
    }

    // Retorna dados do usuário para uso nos controladores
    return {
      userId: payload.sub,
      email: payload.email,
      name: user.name,
      username: user.username,
      isActive: user.isActive,
    };
  }
}
