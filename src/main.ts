import { NestiaSwaggerComposer } from "@nestia/sdk";
import { NestFactory } from "@nestjs/core";
import { FastifyAdapter, NestFastifyApplication } from "@nestjs/platform-fastify";
import { SwaggerModule } from "@nestjs/swagger";
import { WINSTON_MODULE_NEST_PROVIDER } from "nest-winston";
import { AppModule } from "./app.module";

async function bootstrap() {
  const PORT: string = process.env.PORT ?? (3_000).toFixed();

  const adapter = new FastifyAdapter({
    trustProxy: true,
    logger: false,
  });

  const app = await NestFactory.create<NestFastifyApplication>(AppModule, adapter, {
    bufferLogs: true,
  });

  app.useLogger(app.get(WINSTON_MODULE_NEST_PROVIDER));

  const document = await NestiaSwaggerComposer.document(app, {
    openapi: "3.1",
    servers: [
      {
        url: `http://localhost:${PORT}`,
        description: "localhost",
      },
    ],
  });
  // eslint-disable-next-line @typescript-eslint/no-unsafe-argument
  SwaggerModule.setup("api", app, document as any);

  await app.listen(PORT, "0.0.0.0");
}

bootstrap();
