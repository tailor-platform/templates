// [NOTE]: Temporary type definitions until platform provides proper type information
type QueryArguments = unknown[] | readonly unknown[] | Record<string, unknown>;
export interface Client {
  connect(): Promise<void>;
  end(): Promise<void>;
  queryObject<T>(sql: string, args?: readonly any[]): Promise<{ rows: T[] }>;
  createTransaction(name: string): Transaction;
  new(config?: {
    namespace?: string;
  }): Client;
}

export interface Transaction {
  begin(): Promise<void>;
  commit(): Promise<void>;
  rollback(): Promise<void>;
  queryObject<T>(sql: string, args?: readonly any[]): Promise<{ rows: T[] }>;
};