import { Module } from "@nestjs/common";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { CoreModule } from "./core/core.module";
import { TestModule } from "./api/test/test.module";

@Module({
  imports: [CoreModule, TestModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
