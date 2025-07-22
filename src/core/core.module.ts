import { Global, Module } from "@nestjs/common";
import { LoggerModule } from "nestjs-pino";
import { PrismaService } from "./database/prisma.service";

@Global()
@Module({
  imports: [
    LoggerModule.forRootAsync({
      imports: [],
      providers: [],
      useFactory: () => {
        return {
          isGlobal: true,

          pinoHttp: {
            name: "practice",
            level: process.env.NODE_ENV !== "production" ? "debug" : "info",
            transport: {
              target: "pino-pretty",
              options: {
                colorize: true,
                singleLine: true,
                levelFirst: true,
                translateTime: "yyyy-mm-dd'T'HH:MM:ss.l'Z'",
                messageFormat: "{req.headers.x-request-id} [{context}] {msg}",
                ignore: "pid,hostname,context,res.headers",
                errorLikeObjectKeys: ["err", "error"],
              },
            },

            wrapSerializers: true,
            quietReqLogger: true,
          },
        };
      },
    }),
  ],
  providers: [PrismaService],
})
export class CoreModule {}
