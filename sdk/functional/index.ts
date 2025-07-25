/**
 * @packageDocumentation
 * @module api.functional
 * @nestia Generated by Nestia - https://github.com/samchon/nestia
 */
//================================================================
import type { IConnection } from "@nestia/fetcher";
import { PlainFetcher } from "@nestia/fetcher/lib/PlainFetcher";
import type { Primitive } from "typia";

/**
 * Get
 *
 * @returns
 *
 * @controller AppController.getHello
 * @path GET /
 * @nestia Generated by Nestia - https://github.com/samchon/nestia
 */
export async function getHello(connection: IConnection): Promise<getHello.Output> {
  return PlainFetcher.fetch(connection, {
    ...getHello.METADATA,
    template: getHello.METADATA.path,
    path: getHello.path(),
  });
}
export namespace getHello {
  export type Output = Primitive<string>;

  export const METADATA = {
    method: "GET",
    path: "/",
    request: null,
    response: {
      type: "application/json",
      encrypted: false,
    },
    status: 200,
  } as const;

  export const path = () => "/";
}

/**
 * @controller TestController.test
 * @path GET /test
 * @nestia Generated by Nestia - https://github.com/samchon/nestia
 */
export async function test(connection: IConnection): Promise<test.Output> {
  return PlainFetcher.fetch(connection, {
    ...test.METADATA,
    template: test.METADATA.path,
    path: test.path(),
  });
}
export namespace test {
  export type Output = Primitive<string>;

  export const METADATA = {
    method: "GET",
    path: "/test",
    request: null,
    response: {
      type: "application/json",
      encrypted: false,
    },
    status: 200,
  } as const;

  export const path = () => "/test";
}
