import { PinoLogger } from "nestjs-pino";

export class BaseComponent {
  constructor(protected readonly logger: PinoLogger) {
    this.logger.setContext(this.constructor.name);
  }
}
