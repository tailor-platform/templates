"use client";

import * as React from "react";
import {
  Check,
  ChevronsUpDown,
  Table,
  Kanban,
  Calendar,
  GanttChart,
  User,
  Truck,
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
  CommandSeparator,
} from "@/components/ui/command";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { useState } from "react";
import { useViewContext, ViewType } from "@/app/(leftpanel)/view-context";

// Define view options with categories
const viewOptions = {
  layouts: [
    {
      value: "table",
      label: "Table View",
      icon: Table,
    },
    {
      value: "kanban",
      label: "Kanban Board",
      icon: Kanban,
    },
    {
      value: "calendar",
      label: "Calendar View",
      icon: Calendar,
    },
    {
      value: "timeline",
      label: "Timeline View",
      icon: GanttChart,
    },
  ],
  tableViews: [
    {
      value: "default",
      label: "Default Grid",
      icon: Table,
    },
    {
      value: "grouped-customer",
      label: "Grouped by Customer",
      icon: User,
      gridConfig: {
        groupBy: ["customerName"],
        groupIncludeTotalFooter: true,
      },
    },
    {
      value: "grouped-status",
      label: "Grouped by Status",
      icon: Truck,
      gridConfig: {
        groupBy: ["shipStationOrderStatus"],
        groupIncludeTotalFooter: true,
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

    // Find the selected view configuration
    const layoutView = viewOptions.layouts.find(
      (v) => v.value === currentValue,
    );
    const tableView = viewOptions.tableViews.find(
      (v) => v.value === currentValue,
    );

    if (layoutView) {
      setViewType(layoutView.value as ViewType);
      setGridConfig(null); // Reset gridConfig for non-table views
    } else if (tableView) {
      setViewType("table");
      setGridConfig(tableView.gridConfig || null); // Apply gridConfig if available
    }
  };

  const getSelectedLabel = () => {
    const allViews = [...viewOptions.layouts, ...viewOptions.tableViews];
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
          className="w-[200px] justify-between"
          size="sm"
        >
          {getSelectedLabel()}
          <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-[340px] p-0">
        <Command>
          <CommandInput placeholder="Search views..." />
          <CommandList>
            <CommandEmpty>No views found.</CommandEmpty>
            <CommandGroup heading="Layouts">
              {viewOptions.layouts.map((option) => (
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
            <CommandSeparator />
            <CommandGroup heading="Tables">
              {viewOptions.tableViews.map((option) => (
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
