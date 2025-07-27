import { Injectable } from "@nestjs/common";
import { BaseRepository } from "src/core/base/base.repository";
import { TRANSACTION_DECORATOR } from "src/core/decorator/transaction.decorator";

@Injectable()
export class TestService extends BaseRepository {
  @TRANSACTION_DECORATOR.ACTIVE({ transactionLevel: "Serializable" })
  async test() {
    await this.db().user.create({
      data: {
        name: "test2",
        email: "test2",
      },
    });
  }
}
