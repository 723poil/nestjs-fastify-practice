import { Injectable, Logger, NestMiddleware } from "@nestjs/common";
import { IncomingMessage, ServerResponse } from "http";
import { BaseComponent } from "../base/base.component";

@Injectable()
export class LoggerMiddleware extends BaseComponent implements NestMiddleware {
  constructor(logger: Logger) {
    super(logger);
  }

  use(request: IncomingMessage, response: ServerResponse, next: () => void): void {
    const ip = request.socket.remoteAddress;
    const method = request.method;
    const userAgent = request.headers["user-agent"] || "unknown";

    const originalUrl: string = ((request as unknown as { originalUrl: string }).originalUrl || request.url) ?? "";
    const startTime: number = new Date().getTime();

    if (!originalUrl.endsWith("metrics") && process.env.MODE !== "test") {
      this.info({
        method,
        originalUrl,
        userAgent,
        ip,
      });
    }

    response.on("finish", () => {
      const elapsedTime: string = ((new Date().getTime() - startTime) / 1000).toFixed(3) + "s";
      const { statusCode } = response;
      const contentLength = response.getHeader("content-length");

      if (process.env.MODE === "test") {
        return;
      }

      const content = {
        method,
        originalUrl,
        statusCode,
        contentLength,
        elapsedTime,
      };

      if (statusCode >= 500) {
        this.error(content);
        return;
      }

      if (statusCode >= 400 && statusCode < 500) {
        this.warn(content);
        return;
      }

      if (!originalUrl.endsWith("metrics")) {
        this.info(content);
      }
    });

    next();
  }
}
