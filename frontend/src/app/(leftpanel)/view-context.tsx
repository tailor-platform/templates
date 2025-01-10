"use client";

import React, {
  createContext,
  useContext,
  useEffect,
  useState,
  ReactNode,
} from "react";
import { ColDef, SideBarDef } from "ag-grid-enterprise";

export type ViewType = "table" | "kanban" | "calendar" | "timeline";

export type GridConfig = {
  groupBy?: string[];
  groupIncludeTotalFooter?: boolean;
  pivotMode?: boolean;
  rowGroup?: string[];
  pivot?: string[];
  values?: string[];
  aggFunc?: string;
  valueFormatter?: (params: {
    value: unknown;
    data?: Record<string, unknown>;
  }) => string;
  defaultColDef?: ColDef;
  sideBar?: SideBarDef;
  rowGroupPanelShow?: "always" | "onlyWhenGrouping";
  pivotPanelShow?: "always" | "onlyWhenPivoting";
  groupDefaultExpanded?: number;
};

export type ViewContextType = {
  viewType: ViewType;
  setViewType: (type: ViewType) => void;
  gridConfig: GridConfig | null;
  setGridConfig: (config: GridConfig | null) => void;
};

const LOCAL_STORAGE_KEY = "viewType";
const GRID_CONFIG_KEY = "gridConfig";

const ViewContext = createContext<ViewContextType | undefined>(undefined);

export const ViewProvider = ({ children }: { children: ReactNode }) => {
  const [viewType, setViewTypeState] = useState<ViewType>("table");
  const [gridConfig, setGridConfigState] = useState<GridConfig | null>(null);

  useEffect(() => {
    const savedView = localStorage.getItem(
      LOCAL_STORAGE_KEY,
    ) as ViewType | null;
    if (savedView) {
      setViewTypeState(savedView);
    }

    const savedGridConfig = localStorage.getItem(GRID_CONFIG_KEY);
    if (savedGridConfig) {
      setGridConfigState(JSON.parse(savedGridConfig));
    }
  }, []);

  const setViewType = (view: ViewType) => {
    setViewTypeState(view);
    localStorage.setItem(LOCAL_STORAGE_KEY, view);
  };

  const setGridConfig = (config: GridConfig | null) => {
    setGridConfigState(config);
    if (config) {
      localStorage.setItem(GRID_CONFIG_KEY, JSON.stringify(config));
    } else {
      localStorage.removeItem(GRID_CONFIG_KEY);
    }
  };

  return (
    <ViewContext.Provider
      value={{ viewType, setViewType, gridConfig, setGridConfig }}
    >
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
