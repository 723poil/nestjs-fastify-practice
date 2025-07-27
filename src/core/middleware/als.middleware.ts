import { Injectable, Logger, NestMiddleware } from "@nestjs/common";
import { IncomingMessage, ServerResponse } from "http";
import { v4 as uuidv4 } from "uuid";
import { asyncLocalStorage, REQUEST_ID } from "../async-local-storage/async.local.storage";
import { BaseComponent } from "../base/base.component";

@Injectable()
export class AlsMiddleware extends BaseComponent implements NestMiddleware {
  private readonly IS_TEST: boolean;

  constructor(logger: Logger) {
    super(logger);

    this.IS_TEST = process.env.MODE === "test";
  }

  use(request: IncomingMessage, response: ServerResponse, next: () => void): void {
    if (!this.IS_TEST) {
      this.debug("Hit");
    }

    asyncLocalStorage.run(new Map(), () => {
      if (!this.IS_TEST) {
        this.debug(`Run AsyncLocalStorage`);
      }

      const store = asyncLocalStorage.getStore();

      if (!store) {
        if (!this.IS_TEST) {
          this.error({ message: "AsyncLocalStorage store is not available" });
        }
        throw new Error("unhandled error: AsyncLocalStorage store is not available");
      }

      const uuid: string = uuidv4();

      store.set(REQUEST_ID, uuid);

      if (!this.IS_TEST) {
        this.debug(`Set connection in AsyncLocalStorage`);
      }

      next();
    });
  }
}
