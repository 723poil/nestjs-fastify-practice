import { Prisma } from "@prisma/client";
import { asyncLocalStorage, PRISMA, TRANSACTION } from "../async-local-storage/async.local.storage";
import { PrismaService } from "../database/prisma.service";

export const TRANSACTION_DECORATOR = {
  ACTIVE: (options: { transactionLevel?: Prisma.TransactionIsolationLevel; error?: Error }) => {
    return function (_target: object, _propertyKey: string | symbol, descriptor: TypedPropertyDescriptor<any>) {
      const originMethod = descriptor.value;

      descriptor.value = async function (...args: unknown[]) {
        const store = asyncLocalStorage.getStore();

        if (!store) {
          throw new Error(`서버 에러가 발생하였습니다. ${TRANSACTION}-store is not active`);
        }

        const isApplied: boolean = !!store.get(TRANSACTION);

        if (isApplied) {
          return originMethod.apply(this, args);
        }

        const connection: PrismaService = store.get(PRISMA) as PrismaService;

        if (!connection) {
          throw new Error(`서버 에러가 발생하였습니다. ${PRISMA}-connection is not active`);
        }

        return connection.$transaction(
          async (tx) => {
            store.set(TRANSACTION, tx);

            try {
              return await originMethod.apply(this, args);
            } finally {
              store.set(TRANSACTION, undefined);
            }
          },
          { isolationLevel: options?.transactionLevel ?? "Serializable" },
        );
      };
    };
  },
};
