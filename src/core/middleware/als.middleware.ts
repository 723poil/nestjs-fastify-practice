import { Injectable, Logger, NestMiddleware } from "@nestjs/common";
import { IncomingMessage, ServerResponse } from "http";
import { v4 as uuidv4 } from "uuid";
import { asyncLocalStorage, REQUEST_ID } from "../async-local-storage/async.local.storage";
import { BaseComponent } from "../base/base.component";

@Injectable()
export class AlsMiddleware extends BaseComponent implements NestMiddleware {
  constructor(logger: Logger) {
    super(logger);
  }

  use(request: IncomingMessage, response: ServerResponse, next: () => void): void {
    if (process.env.MODE !== "test") {
      this.debug("Hit");
    }

    asyncLocalStorage.run(new Map(), () => {
      if (process.env.MODE !== "test") {
        this.debug(`Run AsyncLocalStorage`);
      }

      const store = asyncLocalStorage.getStore();

      if (!store) {
        if (process.env.MODE !== "test") {
          this.error({ message: "AsyncLocalStorage store is not available" });
        }
        throw new Error("unhandled error: AsyncLocalStorage store is not available");
      }

      const uuid: string = uuidv4();

      store.set(REQUEST_ID, uuid);

      if (process.env.MODE !== "test") {
        this.debug(`Set connection in AsyncLocalStorage`);
      }

      next();
    });
  }
}
