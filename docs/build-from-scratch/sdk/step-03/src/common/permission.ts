import type {
  PermissionCondition,
  TailorTypeGqlPermission,
  TailorTypePermission,
} from "@tailor-platform/tailor-sdk";

export interface User {
  role: string;
}

export const managerRole = [
  { user: "role" },
  "=",
  "MANAGER",
] as const satisfies PermissionCondition;
export const loggedIn = [
  { user: "_loggedIn" },
  "=",
  true,
] as const satisfies PermissionCondition;

// Manager can do anything, Staff can only read.
export const permissionManager = {
  create: [managerRole],
  read: [loggedIn],
  update: [managerRole],
  delete: [managerRole],
} as const satisfies TailorTypePermission;

// Manager can perform any GraphQL operations, Staff can only read.
export const gqlPermissionManager = [
  {
    conditions: [managerRole],
    actions: "all",
    permit: true,
  },
  {
    conditions: [loggedIn],
    actions: ["read"],
    permit: true,
  },
] as const satisfies TailorTypeGqlPermission;

// Any logged-in user can do anything.
export const permissionLoggedIn = {
  create: [loggedIn],
  read: [loggedIn],
  update: [loggedIn],
  delete: [loggedIn],
} as const satisfies TailorTypePermission;

// Any logged-in user can perform read GraphQL operation.
export const gqlPermissionLoggedIn = [
  {
    conditions: [loggedIn],
    actions: "all",
    permit: true,
  },
] as const satisfies TailorTypeGqlPermission;
