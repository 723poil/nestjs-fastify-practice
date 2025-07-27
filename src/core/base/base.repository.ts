import { Injectable, Logger } from "@nestjs/common";
import { asyncLocalStorage, PRISMA, TRANSACTION } from "../async-local-storage/async.local.storage";
import { PrismaService } from "../database/prisma.service";
import { BaseComponent } from "./base.component";

@Injectable()
export class BaseRepository extends BaseComponent {
  constructor(
    logger: Logger,
    protected readonly prisma: PrismaService,
  ) {
    super(logger);
  }

  protected db(getTransaction: boolean = true): PrismaService {
    const store = asyncLocalStorage.getStore();

    this.info(store);

    if (!store) {
      throw new Error(`서버 에러가 발생하였습니다. ${TRANSACTION}-store is not active`);
    }

    const connection = getTransaction ? (store.get(TRANSACTION) as PrismaService) : (store.get(PRISMA) ?? this.prisma);

    if (!connection) {
      throw new Error(`서버 에러가 발생하였습니다. ${TRANSACTION}-store is not active`);
    }

    return connection;
  }
}
