"use client";

import * as React from "react";
import * as SelectPrimitive from "@radix-ui/react-select";
import { Check, ChevronDown, ChevronUp } from "lucide-react";
import { cn } from "@/lib/utils";

const CompactSelect = SelectPrimitive.Root;

const CompactSelectGroup = SelectPrimitive.Group;

const CompactSelectValue = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Value>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Value>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.Value
    ref={ref}
    className={cn("line-clamp-1", className)}
    {...props}
  />
));
CompactSelectValue.displayName = "CompactSelectValue";

const CompactSelectTrigger = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Trigger>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Trigger> & {
    placeholder?: string;
    value?: string;
    iconMap?: Record<string, React.ElementType | undefined>;
  }
>(({ className, placeholder, iconMap = {}, ...props }, ref) => {
  const measurementRef = React.useRef<HTMLSpanElement>(null);

  // Get the selected icon dynamically from Radix's context
  const selectedValue = props.value; // Automatically passed by Radix
  const SelectedIcon =
    selectedValue && iconMap ? iconMap[selectedValue] : undefined;

  React.useEffect(() => {
    if (measurementRef.current) {
      const width = measurementRef.current.offsetWidth;
      measurementRef.current.parentElement!.style.width = `${width + 40}px`; // Adjust for padding
    }
  }, [selectedValue, placeholder]);

  return (
    <>
      {/* Hidden element to measure the selected value or placeholder */}
      <span
        ref={measurementRef}
        className="invisible absolute whitespace-nowrap"
      >
        {selectedValue || placeholder || "Select"}
      </span>
      <SelectPrimitive.Trigger
        ref={ref}
        className={cn(
          "flex h-8 items-center whitespace-nowrap rounded-md border border-input bg-transparent px-3 text-xs shadow-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-1 focus:ring-ring disabled:cursor-not-allowed disabled:opacity-50",
          className,
        )}
        {...props}
      >
        <div className="flex flex-1 items-center gap-2 truncate">
          {SelectedIcon && (
            <SelectedIcon className="h-4 w-4 flex-shrink-0 text-muted-foreground" />
          )}
          <SelectPrimitive.Value
            placeholder={placeholder}
            className="flex-1 truncate"
          />
        </div>
        <div className="ml-2 flex flex-shrink-0 items-center">
          <SelectPrimitive.Icon asChild>
            <ChevronDown className="h-4 w-4 opacity-50" />
          </SelectPrimitive.Icon>
        </div>
      </SelectPrimitive.Trigger>
    </>
  );
});
CompactSelectTrigger.displayName = "CompactSelectTrigger";

const CompactSelectScrollUpButton = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.ScrollUpButton>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.ScrollUpButton>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.ScrollUpButton
    ref={ref}
    className={cn(
      "flex cursor-default items-center justify-center py-1",
      className,
    )}
    {...props}
  >
    <ChevronUp className="h-4 w-4" />
  </SelectPrimitive.ScrollUpButton>
));
CompactSelectScrollUpButton.displayName = "CompactSelectScrollUpButton";

const CompactSelectScrollDownButton = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.ScrollDownButton>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.ScrollDownButton>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.ScrollDownButton
    ref={ref}
    className={cn(
      "flex cursor-default items-center justify-center py-1",
      className,
    )}
    {...props}
  >
    <ChevronDown className="h-4 w-4" />
  </SelectPrimitive.ScrollDownButton>
));
CompactSelectScrollDownButton.displayName = "CompactSelectScrollDownButton";

const CompactSelectContent = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Content>
>(({ className, children, position = "popper", ...props }, ref) => (
  <SelectPrimitive.Portal>
    <SelectPrimitive.Content
      ref={ref}
      className={cn(
        "relative z-50 max-h-96 min-w-[8rem] overflow-hidden rounded-md border bg-popover text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
        position === "popper" &&
          "data-[side=bottom]:translate-y-1 data-[side=left]:-translate-x-1 data-[side=right]:translate-x-1 data-[side=top]:-translate-y-1",
        className,
      )}
      position={position}
      {...props}
    >
      <CompactSelectScrollUpButton />
      <SelectPrimitive.Viewport
        className={cn(
          "p-1",
          position === "popper" &&
            "h-[var(--radix-select-trigger-height)] w-full min-w-[var(--radix-select-trigger-width)]",
        )}
      >
        {children}
      </SelectPrimitive.Viewport>
      <CompactSelectScrollDownButton />
    </SelectPrimitive.Content>
  </SelectPrimitive.Portal>
));
CompactSelectContent.displayName = "CompactSelectContent";

const CompactSelectLabel = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Label>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Label>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.Label
    ref={ref}
    className={cn("px-2 py-1.5 text-xs font-semibold", className)}
    {...props}
  />
));
CompactSelectLabel.displayName = "CompactSelectLabel";

const CompactSelectItem = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Item>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Item> & {
    iconMap?: Record<string, React.ElementType | undefined>;
    value: string; // Ensure value is available and forwarded
  }
>(({ className, children, iconMap = {}, value, ...props }, ref) => {
  const Icon = value && iconMap[value] ? iconMap[value] : undefined;

  return (
    <SelectPrimitive.Item
      ref={ref}
      value={value}
      className={cn(
        "relative flex w-full cursor-default select-none items-center gap-2 rounded-sm py-1.5 pl-2 pr-8 text-xs outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
        className,
      )}
      {...props}
    >
      {Icon && <Icon className="h-4 w-4 flex-shrink-0 text-muted-foreground" />}
      <SelectPrimitive.ItemText>{children}</SelectPrimitive.ItemText>
      <span className="absolute right-2 flex h-3.5 w-3.5 items-center justify-center">
        <SelectPrimitive.ItemIndicator>
          <Check className="h-4 w-4" />
        </SelectPrimitive.ItemIndicator>
      </span>
    </SelectPrimitive.Item>
  );
});
CompactSelectItem.displayName = "CompactSelectItem";

const CompactSelectSeparator = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Separator>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Separator>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.Separator
    ref={ref}
    className={cn("-mx-1 my-1 h-px bg-muted", className)}
    {...props}
  />
));
CompactSelectSeparator.displayName = "CompactSelectSeparator";

export {
  CompactSelect,
  CompactSelectGroup,
  CompactSelectValue,
  CompactSelectTrigger,
  CompactSelectContent,
  CompactSelectLabel,
  CompactSelectItem,
  CompactSelectSeparator,
  CompactSelectScrollUpButton,
  CompactSelectScrollDownButton,
};
