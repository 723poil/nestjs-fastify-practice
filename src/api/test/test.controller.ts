import { TypedRoute } from "@nestia/core";
import { Controller } from "@nestjs/common";
import { ApiTags } from "@nestjs/swagger";

@ApiTags("TEST")
@Controller("test")
export class TestController {
  @TypedRoute.Get()
  test() {
    return "test";
  }
}
