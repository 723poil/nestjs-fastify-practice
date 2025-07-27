import { Injectable, Logger } from "@nestjs/common";
import { getRequestId } from "../async-local-storage/async.local.storage";

@Injectable()
export class BaseComponent {
  constructor(protected readonly logger: Logger) {}

  protected info(message: any) {
    this.logger.log(message, [this.constructor.name, getRequestId()]);
  }

  protected warn(message: any) {
    this.logger.warn(message, [this.constructor.name, getRequestId()]);
  }

  protected error(message: any, stack?: string) {
    this.logger.error(message, stack, [this.constructor.name, getRequestId()]);
  }

  protected debug(message: any) {
    this.logger.debug(message, [this.constructor.name, getRequestId()]);
  }
}
