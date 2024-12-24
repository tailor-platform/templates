"use client";

import { useState } from "react";
import {
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Check, ChevronsUpDown } from "lucide-react";
import Avatar from "boring-avatars";

type Props = {
  modules: string[];
  defaultModule: string;
};

export const ModuleSwitcher = ({ modules, defaultModule }: Props) => {
  const [selectedModule, setSelectedModule] = useState(defaultModule);

  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <SidebarMenuButton
              size="lg"
              className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
            >
              <div className="flex aspect-square size-8 items-center justify-center text-sidebar-primary-foreground">
                <Avatar size={20} name={selectedModule} variant="marble" />
              </div>
              <div className="flex flex-col gap-0.5 leading-none">
                <span className="">{selectedModule}</span>
              </div>
              <ChevronsUpDown className="ml-auto" />
            </SidebarMenuButton>
          </DropdownMenuTrigger>

          <DropdownMenuContent
            className="w-[--radix-dropdown-menu-trigger-width]"
            align="start"
          >
            {modules.map((module) => (
              <DropdownMenuItem
                key={module}
                onSelect={() => setSelectedModule(module)}
              >
                {module} {module === module && <Check className="ml-auto" />}
              </DropdownMenuItem>
            ))}
          </DropdownMenuContent>
        </DropdownMenu>
      </SidebarMenuItem>
    </SidebarMenu>
  );
};
