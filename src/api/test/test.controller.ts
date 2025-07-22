import { TypedRoute } from "@nestia/core";
import { Controller } from "@nestjs/common";
import { ApiTags } from "@nestjs/swagger";
import { PinoLogger } from "nestjs-pino";
import { BaseComponent } from "src/core/base/base.component";

@ApiTags("TEST")
@Controller("test")
export class TestController extends BaseComponent {
  constructor(logger: PinoLogger) {
    super(logger);
  }

  @TypedRoute.Get()
  test() {
    this.logger.info("test");
    return "test";
  }
}
