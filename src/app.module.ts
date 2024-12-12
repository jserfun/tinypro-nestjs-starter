import { HttpException, Logger, Module, OnModuleInit } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { DbModule } from '@libs/db';
import { PermissionModule } from './permission/permission.module';
import { AuthModule } from './auth/auth.module';
import { APP_GUARD } from '@nestjs/core';
import { AuthGuard } from './auth/auth.guard';
import { PermissionGuard } from './permission/permission.guard';
import { RoleModule } from './role/role.module';
import { join } from 'path';
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'fs';
import { UserService } from './user/user.service';
import { RoleService } from './role/role.service';
import { PermissionService } from './permission/permission.service';
import { MenuService } from './menu/menu.service';
import { MenuModule } from './menu/menu.module';
import { ConfigModule } from '@nestjs/config';
import { menuData } from './menu/init/menuData';
import { I18Module } from './i18/i18.module';
import { I18LangService } from './i18/lang.service';
import { I18Service } from './i18/i18.service';
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
        // TODO: it would be unwiseful to watch dir in production env
        watch: true,
      },
      resolvers: [new HeaderResolver(['x-lang'])],
      // TODO: what if there is only a dist folder on server ?
      // TODO: why there is just copy dist dir in the dockerfile ?
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
