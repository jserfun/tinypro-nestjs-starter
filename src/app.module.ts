import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { DbModule } from '@libs/db';
import { PermissionModule } from './permission/permission.module';
import { AuthModule } from './auth/auth.module';
import { APP_GUARD } from '@nestjs/core';
import { AuthGuard } from './auth/auth.guard';
import { PermissionGuard } from './permission/permission.guard';
import { RoleModule } from './role/role.module';
import { join } from 'path';
import { MenuModule } from './menu/menu.module';
import { ConfigModule } from '@nestjs/config';
import { I18Module } from './i18/i18.module';
import { HeaderResolver, I18nModule } from 'nestjs-i18n';

@Module({
  imports: [
    DbModule,
    UserModule,
    PermissionModule,
    AuthModule,
    RoleModule,
    MenuModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    I18Module,
    I18nModule.forRoot({
      fallbackLanguage: 'enUS',
      loaderOptions: {
        path: join(__dirname, '/i18n/'),
        watch: true,
      },
      resolvers: [new HeaderResolver(['x-lang'])],
      typesOutputPath: join(__dirname, '../src/.generate/i18n.generated.ts'),
    }),
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
    {
      provide: APP_GUARD,
      useClass: PermissionGuard,
    },
  ],
})
export class AppModule {}
