import { Global, Logger, MiddlewareConsumer, Module, NestModule } from "@nestjs/common";
import { WinstonModule } from "nest-winston";
import { PrismaService } from "./database/prisma.service";
import { LoggerMiddleware } from "./middleware/logger.middleware";
import { transportList } from "./winston/winson.setup";
import { AlsMiddleware } from "./middleware/als.middleware";

@Global()
@Module({
  imports: [
    WinstonModule.forRoot({
      transports: transportList,
    }),
  ],
  providers: [Logger, PrismaService],
  exports: [Logger],
})
export class CoreModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(AlsMiddleware, LoggerMiddleware).forRoutes("*");
  }
}
