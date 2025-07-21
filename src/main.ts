import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { FastifyAdapter, NestFastifyApplication } from "@nestjs/platform-fastify";
import { NestiaSwaggerComposer } from "@nestia/sdk";
import { SwaggerModule } from "@nestjs/swagger";

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(AppModule, new FastifyAdapter());
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
