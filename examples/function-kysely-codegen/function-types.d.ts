// Definition of types and global variables available in the Function service.
// It is expected to be published in a public repository in the future.
declare namespace Tailordb {
  class Client {
    constructor(config?: { namespace?: string });
    connect(): Promise<void>;
    end(): Promise<void>;
    queryObject<O>(
      sql: string,
      args?: readonly unknown[]
    ): Promise<QueryResult<O>>;
  }

  interface QueryResult<T> {
    rows: T[];
    command: CommandType;
    rowCount: number;
  }

  type CommandType =
    | "INSERT"
    | "DELETE"
    | "UPDATE"
    | "SELECT"
    | "MOVE"
    | "FETCH"
    | "COPY"
    | "CREATE";
}

declare const tailordb: {
  Client: typeof Tailordb.Client;
};
