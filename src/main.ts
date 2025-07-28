import { NestiaSwaggerComposer } from "@nestia/sdk";
import { NestFactory } from "@nestjs/core";
import { FastifyAdapter, NestFastifyApplication } from "@nestjs/platform-fastify";
import { SwaggerModule } from "@nestjs/swagger";
import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";
import timezone from "dayjs/plugin/timezone";
import { WINSTON_MODULE_NEST_PROVIDER } from "nest-winston";
import { AppModule } from "./app.module";
import { getDateTimeForDb } from "./util/prisma.helper";

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

  const KST = process.env.TZ ?? "Asia/Seoul";

  dayjs.extend(utc);
  dayjs.extend(timezone);
  dayjs.tz.setDefault(KST);

  console.log(getDateTimeForDb());

  await app.listen(PORT, "0.0.0.0");
}

bootstrap();
