import { Injectable } from "@nestjs/common";
import { BaseRepository } from "src/core/base/base.repository";
import { TRANSACTION_DECORATOR } from "src/core/decorator/transaction.decorator";
import { getDateTimeForDb } from "src/util/prisma.helper";

@Injectable()
export class TestService extends BaseRepository {
  @TRANSACTION_DECORATOR.ACTIVE({ transactionLevel: "Serializable" })
  async test() {
    await this.db().users.create({
      data: {
        user_name: "test",
        social_type: "KAKAO",
        social_id: "kakao test",
        created_at: getDateTimeForDb(),
        updated_at: getDateTimeForDb(),
      },
    });
  }
}
