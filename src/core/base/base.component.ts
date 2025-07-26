import { Logger } from "@nestjs/common";

export class BaseComponent {
  constructor(protected readonly logger: Logger) {}

  protected info(message: any) {
    this.logger.log(message, this.constructor.name);
  }

  protected warn(message: any) {
    this.logger.warn(message, this.constructor.name);
  }

  protected error(message: any, stack?: string) {
    this.logger.error(message, stack, this.constructor.name);
  }

  protected debug(message: any) {
    this.logger.debug(message, this.constructor.name);
  }
}
