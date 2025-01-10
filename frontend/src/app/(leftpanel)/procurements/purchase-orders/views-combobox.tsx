"use client";

import * as React from "react";
import {
  Check,
  ChevronsUpDown,
  Table,
  Calendar,
  GanttChart,
  User,
  Truck,
  type LucideIcon,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { useState } from "react";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { GridConfig } from "@/app/(leftpanel)/view-context";

type SavedView = {
  value: string;
  label: string;
  icon: LucideIcon;
  gridConfig: GridConfig;
};

const viewOptions: { savedViews: SavedView[] } = {
  savedViews: [
    {
      value: "default",
      label: "Default Grid",
      icon: Table,
      gridConfig: {
        pivotMode: false,
        groupBy: [],
        pivot: [],
      },
    },

    {
      value: "grouped-customer",
      label: "Grouped by Customer",
      icon: User,
      gridConfig: {
        pivotMode: false,
        groupBy: ["customerName"],
        groupIncludeTotalFooter: true,
        groupDefaultExpanded: 1,
      },
    },

    {
      value: "grouped-status",
      label: "Grouped by Status",
      icon: Truck,
      gridConfig: {
        pivotMode: false,
        groupBy: ["shipStationOrderStatus"],
        groupIncludeTotalFooter: true,
        groupDefaultExpanded: 1,
      },
    },
    {
      value: "customer-revenue-per-status",
      label: "Revenue by Customer and Status",
      icon: GanttChart,
      gridConfig: {
        pivotMode: true,
        groupBy: ["customerName"],
        pivot: ["shipStationOrderStatus"],
        sideBar: {
          toolPanels: [
            {
              id: "columns",
              labelDefault: "Columns",
              labelKey: "columns",
              iconKey: "columns",
              toolPanel: "agColumnsToolPanel",
            },
          ],
        },
        defaultColDef: {
          flex: 1,
          minWidth: 130,
          enablePivot: true,
          enableRowGroup: true,
          enableValue: true,
          sortable: true,
          resizable: true,
        },
        rowGroupPanelShow: "always" as const,
        pivotPanelShow: "always" as const,
        groupDefaultExpanded: 1,
      },
    },
    {
      value: "customer-daily-revenue",
      label: "Daily Revenue by Customer",
      icon: Calendar,
      gridConfig: {
        pivotMode: true,
        groupBy: ["customerName"],
        pivot: ["shopifyCreatedAt"],
        defaultColDef: {
          flex: 1,
          minWidth: 130,
          enablePivot: true,
          enableRowGroup: true,
          enableValue: true,
          sortable: true,
          resizable: true,
        },
        sideBar: {
          toolPanels: [
            {
              id: "columns",
              labelDefault: "Columns",
              labelKey: "columns",
              iconKey: "columns",
              toolPanel: "agColumnsToolPanel",
            },
          ],
        },
        pivotPanelShow: "always",
        groupDefaultExpanded: 1,
      },
    },
  ],
};

export function ViewsComboBox() {
  const [open, setOpen] = useState(false);
  const [value, setValue] = useState("default");
  const { setViewType, setGridConfig } = useViewContext();

  const handleSelect = (currentValue: string) => {
    setValue(currentValue);
    setOpen(false);

    const savedView = viewOptions.savedViews.find(
      (v) => v.value === currentValue,
    );
    if (savedView) {
      setViewType("table");
      setGridConfig(savedView.gridConfig || null);
    }
  };

  const getSelectedLabel = () => {
    const allViews = [...viewOptions.savedViews];
    return (
      allViews.find((option) => option.value === value)?.label || "Select view"
    );
  };

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          role="combobox"
          aria-expanded={open}
          className="w-[260px] justify-between"
          size="sm"
        >
          {getSelectedLabel()}
          <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-[280px] p-0">
        <Command>
          <CommandInput placeholder="Search views..." />
          <CommandList>
            <CommandEmpty>No views found.</CommandEmpty>
            <CommandGroup heading="Saved Views">
              {viewOptions.savedViews.map((option) => (
                <CommandItem
                  key={option.value}
                  value={option.value}
                  onSelect={handleSelect}
                >
                  <option.icon className="h-4 w-4" />
                  <Check
                    className={cn(
                      "h-4 w-4",
                      value === option.value ? "opacity-100" : "opacity-0",
                    )}
                  />
                  {option.label}
                </CommandItem>
              ))}
            </CommandGroup>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  );
}
