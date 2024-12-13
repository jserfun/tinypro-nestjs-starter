import { Controller, Get } from '@nestjs/common';
import { Public } from './public/public.decorator';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private appService: AppService) {}
  @Public()
  @Get('hello-world')
  helloWorld() {
    return this.appService.helloWorld();
  }
}
