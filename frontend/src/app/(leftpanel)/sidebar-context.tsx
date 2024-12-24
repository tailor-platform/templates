"use client";

import React, { createContext, useContext, useState, ReactNode } from "react";

export type SidebarPanel = "columns" | "filters" | null;

type SidebarContextType = {
  sidebarPanel: SidebarPanel;
  setSidebarPanel: (panel: SidebarPanel) => void;
};

const SidebarContext = createContext<SidebarContextType | undefined>(undefined);

export function SidebarProvider({ children }: { children: ReactNode }) {
  const [sidebarPanel, setSidebarPanel] = useState<SidebarPanel>("columns");

  return (
    <SidebarContext.Provider value={{ sidebarPanel, setSidebarPanel }}>
      {children}
    </SidebarContext.Provider>
  );
}

export function useSidebarContext() {
  const context = useContext(SidebarContext);
  if (!context) {
    throw new Error("useSidebarContext must be used within a SidebarProvider");
  }
  return context;
}
