import { Injectable, Logger, OnModuleInit } from "@nestjs/common";
import { Prisma, PrismaClient } from "@prisma/client";

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  constructor(private readonly logger: Logger) {
    super({
      log: [
        { emit: "event", level: "query" }, // query 로그를 이벤트로 받음
        { emit: "event", level: "error" },
        { emit: "event", level: "info" },
        { emit: "event", level: "warn" },
      ],
      errorFormat: "colorless",
    });
  }

  async onModuleInit() {
    await this.$connect();

    this.$on("query" as never, (e: Prisma.QueryEvent) => {
      this.logger.debug(`[PRISMA QUERY] ${e.query} -- ${e.params}`);
    });
  }
}
