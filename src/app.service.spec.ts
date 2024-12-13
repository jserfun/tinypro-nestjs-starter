import { Test, TestingModule } from '@nestjs/testing';
import { AppService } from './app.service';

describe('AppService test', () => {
  let service: AppService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AppService],
    }).compile();

    service = module.get<AppService>(AppService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('test appService.helloWorld()', () => {
    expect(service.helloWorld()).toEqual('Hello World!');
  });
});
