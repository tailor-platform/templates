export type TokenResponse = {
  access_token: string;
  token_type: string;
  expires_in: number;
};

export const getMachineUserToken = async () => {
  // Get base URL
  const baseUrl =
    typeof window === undefined
      ? process.env.NEXT_PUBLIC_BASE_URL || "http://localhost:3000"
      : window.location.origin;

  const res = await fetch(`${baseUrl}/api/token`, {
    method: "POST",
  });

  if (!res.ok) {
    throw new Error("Failed to fetch token");
  }

  return (await res.json()) as TokenResponse;
};
