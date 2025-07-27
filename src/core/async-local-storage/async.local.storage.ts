import { AsyncLocalStorage } from "async_hooks";
import { v4 as uuidv4 } from "uuid";

export const asyncLocalStorage: AsyncLocalStorage<Map<string, any>> = new AsyncLocalStorage<Map<string, any>>();

export const getStore = () => {
  return asyncLocalStorage.getStore();
};

export const getRequestId = (): string => {
  const store = getStore();

  if (!store) return "undefined";

  if (!store.get(REQUEST_ID)) {
    store.set(REQUEST_ID, uuidv4());
  }

  return (store.get(REQUEST_ID) as string) ?? "undefined";
};

export const REQUEST_ID = "storage/reqId";
