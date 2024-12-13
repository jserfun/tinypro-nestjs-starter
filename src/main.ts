import { NestFactory } from '@nestjs/core';
import * as dotenv from 'dotenv';
import { I18nValidationExceptionFilter, I18nValidationPipe } from 'nestjs-i18n';

dotenv.config({ path: '.env' });

declare const module: any;

async function bootstrap() {
  // wait dotenv config env data
  const { AppModule } = await import('./app.module');

  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new I18nValidationPipe());
  app.useGlobalFilters(
    new I18nValidationExceptionFilter({
      errorFormatter: (errors) => {
        const reason: string[] = [];
        for (const err of errors) {
          reason.push(...Object.values(err.constraints));
        }
        return reason;
      },
    })
  );
  await app.listen(3000);
  console.log(`Application is running on: ${await app.getUrl()}`);

  if (module.hot) {
    module.hot.accept();
    module.hot.dispose(() => app.close());
  }
}

bootstrap();
