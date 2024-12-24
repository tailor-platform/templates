import { authExchange } from "@urql/exchange-auth";
import { getMachineUserToken } from "@/lib/auth";
import { fetchExchange, cacheExchange } from "urql";

type AuthState = {
  access_token: string;
  expiresAt: number;
};

function loadAuthFromSessionStorage(): AuthState | null {
  if (typeof window === "undefined") return null;
  const token = sessionStorage.getItem("machineUserToken");
  const expiresAt = sessionStorage.getItem("machineUserTokenExpiresAt");
  if (!token || !expiresAt) return null;

  const numericExpiresAt = parseInt(expiresAt, 10);

  if (!numericExpiresAt || Date.now() >= numericExpiresAt) return null;

  return { access_token: token, expiresAt: numericExpiresAt };
}

function saveAuthToSessionStorage(state: AuthState) {
  if (typeof window === "undefined") return;
  sessionStorage.setItem("machineUserToken", state.access_token);
  sessionStorage.setItem(
    "machineUserTokenExpiresAt",
    state.expiresAt.toString(),
  );
}

let globalAuthState: AuthState | null = null;

export const dumbAuthExchange = authExchange(async (utils) => {
  if (!globalAuthState) {
    globalAuthState = loadAuthFromSessionStorage();
  }

  if (!globalAuthState || Date.now() >= globalAuthState.expiresAt) {
    const { access_token, expires_in } = await getMachineUserToken();
    globalAuthState = {
      access_token,
      expiresAt: Date.now() + expires_in * 1000,
    };
    saveAuthToSessionStorage(globalAuthState);
  }

  return {
    addAuthToOperation: (operation) => {
      if (!globalAuthState?.access_token) return operation;
      return utils.appendHeaders(operation, {
        Authorization: `Bearer ${globalAuthState.access_token}`,
      });
    },
    didAuthError: (error) =>
      error.graphQLErrors.some(
        (e) =>
          e.extensions?.code === "FORBIDDEN" ||
          e.message.includes("not authorized"),
      ),
    async refreshAuth() {
      if (globalAuthState && Date.now() < globalAuthState.expiresAt) {
        return;
      }
      const { access_token, expires_in } = await getMachineUserToken();
      globalAuthState = {
        access_token,
        expiresAt: Date.now() + expires_in * 1000,
      };
      saveAuthToSessionStorage(globalAuthState);
    },
    exchanges: [cacheExchange, fetchExchange],
  };
});
