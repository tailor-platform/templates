"use client";

import { createContext, useContext, ReactNode } from "react";

type RefreshContextType = {
  onRefresh: () => Promise<void>;
  setRefreshCallback: (callback: () => Promise<void>) => void;
};

const RefreshContext = createContext<RefreshContextType | null>(null);

export const RefreshProvider = ({
  children,
  onRefresh,
  setRefreshCallback,
}: {
  children: ReactNode;
  onRefresh: () => Promise<void>;
  setRefreshCallback?: (callback: () => Promise<void>) => void;
}) => {
  return (
    <RefreshContext.Provider
      value={{
        onRefresh,
        setRefreshCallback: setRefreshCallback || (() => {}),
      }}
    >
      {children}
    </RefreshContext.Provider>
  );
};

export const useRefreshContext = () => {
  const context = useContext(RefreshContext);
  if (!context)
    throw new Error("useRefreshContext must be used within RefreshProvider");
  return context;
};

export { RefreshContext };
