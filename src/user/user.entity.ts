import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 100 })
  name: string;

  @Column({ 
    type: 'varchar', 
    length: 50, 
    unique: true 
  })
  username: string;

  @Column({ 
    type: 'varchar', 
    length: 100, 
    unique: true 
  })
  email: string;

  @Column({ type: 'varchar', length: 255 })
  password: string;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
