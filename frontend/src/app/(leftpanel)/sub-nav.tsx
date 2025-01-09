"use client";

import React, { useState } from "react";
import { useSidebarContext, SidebarPanel } from "./sidebar-context";
import {
  CompactSelect,
  CompactSelectContent,
  CompactSelectItem,
  CompactSelectTrigger,
} from "@/components/ui/compact-select";
import {
  Calendar,
  Columns3,
  GanttChart,
  Kanban,
  Layers2,
  ListFilter,
  RefreshCw,
  Table,
} from "lucide-react";
import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group";
import { ViewsComboBox } from "@/app/(leftpanel)/procurements/purchase-orders/views-combobox";
import { Button } from "@/components/ui/button";
import { useViewContext, ViewType } from "@/app/(leftpanel)/view-context";
import { useRefreshContext } from "@/app/(leftpanel)/refresh-context";
import { toast } from "sonner";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";

import CreateNewManufacturingOrder from "./manufacturing-orders/standard/create-new";

export default function SubNav() {
  const { viewType, setViewType } = useViewContext();
  const { sidebarPanel, setSidebarPanel } = useSidebarContext();
  const { onRefresh } = useRefreshContext();
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [showSaveModal, setShowSaveModal] = useState(false);
  const [viewName, setViewName] = useState("");

  const iconMap = {
    table: Table,
    kanban: Kanban,
    calendar: Calendar,
    timeline: GanttChart,
  };

  const handleToggleChange = (value: SidebarPanel) => {
    setSidebarPanel(value === sidebarPanel ? null : value);
  };

  const handleRefresh = async () => {
    try {
      setIsRefreshing(true);
      await onRefresh();
      toast.success("Data refreshed successfully");
    } catch (error) {
      toast.error(
        error instanceof Error ? error.message : "Failed to refresh data",
      );
    } finally {
      setIsRefreshing(false);
    }
  };

  const handleSaveView = () => {
    toast.success(`View "${viewName}" saved successfully`);
    setViewName("");
    setShowSaveModal(false);
  };

  return (
    <>
      <div className="flex w-full justify-between gap-4 px-4 py-2">
        <div className="flex w-auto max-w-[50%] flex-grow items-center gap-4">
          <ViewsComboBox />
          <Button
            size="sm"
            variant="ghost"
            onClick={() => setShowSaveModal(true)}
          >
            <Layers2 />
            Save this view
          </Button>
        </div>

        <div className="flex w-auto items-center gap-4">
          <Button
            size="sm"
            variant="outline"
            onClick={handleRefresh}
            disabled={isRefreshing}
            className="flex items-center gap-2"
          >
            <RefreshCw
              className={`h-4 w-4 ${isRefreshing ? "animate-spin" : ""}`}
            />
            {isRefreshing ? "Refreshing..." : "Refresh"}
          </Button>

          {viewType === "table" && (
            <ToggleGroup
              type="single"
              size="xs"
              value={sidebarPanel || ""}
              onValueChange={(value) =>
                handleToggleChange(value as SidebarPanel)
              }
            >
              <ToggleGroupItem value="columns" aria-label="Toggle Column">
                <Columns3 /> Columns
              </ToggleGroupItem>
              <ToggleGroupItem value="filters" aria-label="Toggle Filters">
                <ListFilter />
                Filters
              </ToggleGroupItem>
            </ToggleGroup>
          )}

          <div className="mr-8 flex w-auto max-w-[40%]">
            <CompactSelect
              value={viewType}
              onValueChange={(value: ViewType) => setViewType(value)}
            >
              <CompactSelectTrigger
                placeholder="Select an option"
                value={viewType}
                iconMap={iconMap}
              />
              <CompactSelectContent>
                <CompactSelectItem value="table" iconMap={iconMap}>
                  Table
                </CompactSelectItem>
                <CompactSelectItem value="kanban" iconMap={iconMap}>
                  Kanban
                </CompactSelectItem>
                <CompactSelectItem value="calendar" iconMap={iconMap}>
                  Calendar
                </CompactSelectItem>
                <CompactSelectItem value="timeline" iconMap={iconMap}>
                  Timeline
                </CompactSelectItem>
              </CompactSelectContent>
            </CompactSelect>
          </div>

          <CreateNewManufacturingOrder />
        </div>
      </div>

      <Dialog open={showSaveModal} onOpenChange={setShowSaveModal}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Save View</DialogTitle>
          </DialogHeader>
          <div className="py-4">
            <Input
              placeholder="Enter view name"
              value={viewName}
              onChange={(e) => setViewName(e.target.value)}
            />
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowSaveModal(false)}>
              Cancel
            </Button>
            <Button onClick={handleSaveView} disabled={!viewName.trim()}>
              Save
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
