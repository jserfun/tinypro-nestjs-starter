import { HttpException, Logger, Module, OnModuleInit } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { DbModule } from '@app/db';
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
export class AppModule implements OnModuleInit {
  constructor(
    private user: UserService,
    private role: RoleService,
    private permission: PermissionService,
    private menu: MenuService,
    private lang: I18LangService,
    private i18: I18Service
  ) {}
  async onModuleInit() {
    return;
    try {
      const ROOT = __dirname;
      const data = join(ROOT, 'data');

      // make data dir in dist folder
      if (!existsSync(data)) {
        mkdirSync(data);
      }

      const LOCK_FILE = join(data, 'lock');
      if (existsSync(LOCK_FILE)) {
        Logger.warn(
          'Lock file exists, if you want init agin, please remove dist or dist/lock'
        );
        return;
      }

      // TODO: wait for typeorm init database
      Logger.warn(
        '[AppModule] [onModuleInit] init: now wait for typeorm with 2 seconds to sync mysql ddl'
      );

      await new Promise((resolve) => {
        setTimeout(() => {
          resolve(true);
        }, 2 * 1000);
      });

      Logger.warn('[AppModule] [onModuleInit] init: now starts seeding data');

      const I18_INIT_FILE_PATH = join(process.cwd(), 'locales.json');
      // console.log('I18_INIT_FILE_PATH: %s', I18_INIT_FILE_PATH);
      const I18_INIT_FILE = JSON.parse(
        readFileSync(I18_INIT_FILE_PATH).toString()
      );
      // console.log('I18_INIT_FILE: %o', I18_INIT_FILE);

      const dbLangNames = (await this.lang.findAll()).map((lang) => lang.name);
      const langs = Object.keys(I18_INIT_FILE).filter(
        (key) => !dbLangNames.includes(key)
      );
      for (const name of langs) {
        const { id } = await this.lang.create({ name });
        for (const [key, value] of Object.entries(I18_INIT_FILE[name])) {
          const dbValue = await this.i18.has(key, id);
          if (dbValue) {
            Logger.warn(`${name} - ${key} exists value is ${dbValue.content}`);
            continue;
          }
          Logger.log(`${name} - ${key} not exists`);
          await this.i18.create({ key, content: value as string, lang: id });
          Logger.log(`${name} - ${key} save success`);
        }
      }
      const permissions = {
        user: ['add', 'remove', 'update', 'query', 'password::force-update'],
        permission: ['add', 'remove', 'update', 'get'],
        role: ['add', 'remove', 'update', 'query'],
        menu: ['add', 'remove', 'update', 'query'],
        i18n: ['add', 'remove', 'update', 'query'],
        lang: ['add', 'remove', 'update', 'query'],
      };
      const tasks = [];
      let permission;
      const isInit = true;
      try {
        permission = await this.permission.create(
          {
            name: '*',
            desc: 'super permission',
          },
          isInit
        );
      } catch (e) {
        const err = e as HttpException;
        Logger.error(err.message);
        Logger.error(`Please clear the database and try again`);
        process.exit(-1);
      }
      for (const [module, actions] of Object.entries(permissions)) {
        for (const action of actions) {
          tasks.push(
            this.permission.create(
              {
                name: `${module}::${action}`,
                desc: '',
              },
              isInit
            )
          );
        }
      }
      // TODO Menu
      try {
        for (const item of menuData) {
          await this.menu.createMenu(item, isInit);
        }
      } catch (e) {
        const err = e as HttpException;
        Logger.error(err.message);
        Logger.error(`Please clear the database and try again`);
        process.exit(-1);
      }
      const status = Promise.allSettled(tasks);
      const statusData = await status;
      const hasFail = statusData.some((data) => data.status === 'rejected');
      if (hasFail) {
        const fail: any[] = statusData.filter(
          (data) => data.status === 'rejected'
        );
        fail.forEach((data) => {
          Logger.error(`${data.reason}`);
        });
        Logger.error('Please clear the database and try again');
        process.exit(-1);
      }
      const menuId = this.menu.getMenuAllId();
      const role = await this.role.create(
        {
          name: 'admin',
          permissionIds: [permission.id],
          menuIds: await menuId,
        },
        isInit
      );
      const user = await this.user.create(
        {
          email: 'admin@no-reply.com',
          // 密码都明文写在代码里了~
          password: 'admin',
          roleIds: [role.id],
          name: 'admin',
          status: 1,
        },
        isInit
      );

      Logger.log(`[APP]: create admin user success`);
      Logger.log(`[APP]: email: ${user.email}`);
      Logger.log(`[APP]: password: 'admin'`);
      Logger.log('Enjoy!');
      writeFileSync(LOCK_FILE, '');
    } catch (err) {
      if (err instanceof Error) {
        console.log('------------- [AppModule] [onModuleInit] -------------');
        console.log(err.message);
        console.log(err.stack);

        Logger.error(err.stack, 'AppModule');
      }

      throw err;
    }
  }
}
