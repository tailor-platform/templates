import type {
  PermissionCondition,
  TailorTypeGqlPermission,
  TailorTypePermission,
} from "@tailor-platform/tailor-sdk";

export interface User {
  role: string;
}

export const loggedIn = [
  { user: "_loggedIn" },
  "=",
  true,
] as const satisfies PermissionCondition;

// Any logged-in user can do anything.
export const permissionLoggedIn = {
  create: [loggedIn],
  read: [loggedIn],
  update: [loggedIn],
  delete: [loggedIn],
} as const satisfies TailorTypePermission;

// Any logged-in user can perform all GraphQL operation.
export const gqlPermissionLoggedIn = [
  {
    conditions: [loggedIn],
    actions: "all",
    permit: true,
  },
] as const satisfies TailorTypeGqlPermission;
