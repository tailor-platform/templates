"use client";

import { RefreshProvider } from "@/app/(leftpanel)/refresh-context";
import { ReactNode, useCallback, useRef } from "react";

export function RefreshProviderClient({ children }: { children: ReactNode }) {
  const refreshCallbackRef = useRef<() => Promise<void>>(() =>
    Promise.resolve(),
  );

  const handleRefresh = useCallback(async () => {
    return refreshCallbackRef.current();
  }, []);

  const setRefreshCallback = useCallback((callback: () => Promise<void>) => {
    refreshCallbackRef.current = callback;
  }, []);

  return (
    <RefreshProvider
      onRefresh={handleRefresh}
      setRefreshCallback={setRefreshCallback}
    >
      {children}
    </RefreshProvider>
  );
}
