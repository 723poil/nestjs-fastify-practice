import { TypedRoute } from "@nestia/core";
import { Controller } from "@nestjs/common";
import { AppService } from "./app.service";

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  /**
   * Get
   * @returns
   */
  @TypedRoute.Get()
  getHello(): string {
    return this.appService.getHello();
  }
}
