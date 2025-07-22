import { NestiaSwaggerComposer } from "@nestia/sdk";
import { NestFactory } from "@nestjs/core";
import { FastifyAdapter, NestFastifyApplication } from "@nestjs/platform-fastify";
import { SwaggerModule } from "@nestjs/swagger";
import { randomUUID } from "crypto";
import { Logger } from "nestjs-pino";
import { AppModule } from "./app.module";

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter({
      logger: false,
      genReqId: () => randomUUID(),
    }),
    {
      bufferLogs: true,
    },
  );

  app.useLogger(app.get(Logger));

  const document = await NestiaSwaggerComposer.document(app, {
    openapi: "3.1",
    servers: [
      {
        url: "http://localhost:3000",
        description: "localhost",
      },
    ],
  });
  // eslint-disable-next-line @typescript-eslint/no-unsafe-argument
  SwaggerModule.setup("api", app, document as any);

  await app.listen(process.env.PORT ?? 3_000, "0.0.0.0");
}

bootstrap();
