import { TypedRoute } from "@nestia/core";
import { Controller, Logger } from "@nestjs/common";
import { ApiTags } from "@nestjs/swagger";
import { BaseComponent } from "src/core/base/base.component";
import { TestService } from "./service/test.service";

@ApiTags("TEST")
@Controller("test")
export class TestController extends BaseComponent {
  constructor(
    logger: Logger,
    private readonly testService: TestService,
  ) {
    super(logger);
  }

  @TypedRoute.Get()
  async test() {
    this.info("test info");
    this.warn("test warn");
    this.error("test error");
    this.debug("test debug");
    this.info(await this.testService.test());

    return "test";
  }
}
