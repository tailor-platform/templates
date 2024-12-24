"use client";

import React, {
  createContext,
  useContext,
  useEffect,
  useState,
  ReactNode,
} from "react";

export type ViewType = "table" | "kanban" | "calendar" | "timeline";

type ViewContextType = {
  viewType: ViewType;
  setViewType: (view: ViewType) => void;
};

const LOCAL_STORAGE_KEY = "viewType";

const ViewContext = createContext<ViewContextType | undefined>(undefined);

export const ViewProvider = ({ children }: { children: ReactNode }) => {
  const [viewType, setViewTypeState] = useState<ViewType>("table");

  useEffect(() => {
    const savedView = localStorage.getItem(
      LOCAL_STORAGE_KEY,
    ) as ViewType | null;
    if (savedView) {
      setViewTypeState(savedView);
    }
  }, []);

  const setViewType = (view: ViewType) => {
    setViewTypeState(view);
    localStorage.setItem(LOCAL_STORAGE_KEY, view);
  };

  return (
    <ViewContext.Provider value={{ viewType, setViewType }}>
      {children}
    </ViewContext.Provider>
  );
};

export const useViewContext = () => {
  const context = useContext(ViewContext);
  if (!context) {
    throw new Error("useViewContext must be used within a ViewProvider");
  }
  return context;
};
