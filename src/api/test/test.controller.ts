import { TypedRoute } from "@nestia/core";
import { Controller, Logger } from "@nestjs/common";
import { ApiTags } from "@nestjs/swagger";
import { BaseComponent } from "src/core/base/base.component";

@ApiTags("TEST")
@Controller("test")
export class TestController extends BaseComponent {
  constructor(logger: Logger) {
    super(logger);
  }

  @TypedRoute.Get()
  test() {
    this.info("test info");
    this.warn("test warn");
    this.error("test error");
    this.debug("test debug");
    return "test";
  }
}
