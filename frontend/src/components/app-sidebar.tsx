"use client";

import {
  Asterisk,
  Banknote,
  // Bot,
  // Calculator,
  FileCheck,
  // Import,
  // Layers3,
  // LayoutDashboard,
  List,
  Receipt,
  ReceiptText,
  // Settings2,
  Ungroup,
  // Users,
  Warehouse,
} from "lucide-react";

import { NavMain } from "@/components/nav-main";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
  SidebarRail,
} from "@/components/ui/sidebar";
import { NavHeader } from "@/components/nav-header";
import { ModuleSwitcher } from "@/components/module-switcher";
import { usePathname } from "next/navigation";
import { ComponentProps } from "react";
import type { LucideIcon } from "lucide-react";

type NavItem = {
  title: string;
  url: string;
  icon?: LucideIcon;
  items?: NavItem[];
  isActive?: boolean;
};

const data = {
  // navTop: [
  //   {
  //     title: "Dashboard",
  //     url: "/",
  //     icon: LayoutDashboard,
  //   },
  //   {
  //     title: "Agents",
  //     url: "#",
  //     icon: Bot,
  //   },
  //   {
  //     title: "Saved Views",
  //     url: "#",
  //     icon: Layers3,
  //   },
  // ],
  navMain: [
    {
      title: "Master Data",
      url: "#",
      icon: Asterisk,
      isActive: false,
      items: [
        {
          title: "Contacts",
          url: "/master-data/contacts",
        },
        {
          title: "Products",
          url: "/master-data/products",
        },
        {
          title: "Product Variants",
          url: "/master-data/product-variants",
        },
      ],
    },
    {
      title: "Procurements",
      url: "#",
      icon: Receipt,
      isActive: false,
      items: [
        {
          title: "Purchase Orders",
          url: "/procurements/purchase-orders",
        },
        {
          title: "Receipts",
          url: "/procurements/receipts",
        },
        // {
        //   title: "Cost Pools",
        //   url: "/procurements/cost-pools",
        // },
      ],
    },
    {
      title: "Sales",
      url: "#",
      icon: Banknote,
      isActive: false,
      items: [
        {
          title: "Sales Orders",
          url: "/sales/sales-orders",
        },
        {
          title: "Shipments",
          url: "/sales/shipments",
        },
        // {
        //   title: "Invoices",
        //   url: "/sales/invoices",
        // },
      ],
    },
    {
      title: "Inventory",
      url: "/inventory/stock-summary",
      icon: Warehouse,
    },
    // {
    //   title: "Inventory",
    //   url: "#",
    //   icon: Warehouse,
    //   isActive: false,
    //   items: [
    //     {
    //       title: "Stock Summary",
    //       url: "/inventory/stock-summary",
    //     },
    //     {
    //       title: "Operational Ledger",
    //       url: "/inventory/operational-ledger",
    //     },
    //     {
    //       title: "Financial Ledger",
    //       url: "/inventory/financial-ledger",
    //     },
    //     {
    //       title: "Financial Stock Summary",
    //       url: "/inventory/financial-stock-summary",
    //     },
    //   ],
    // },
    {
      title: "Manufacturing Orders",
      url: "/manufacturing-orders/standard",
      icon: ReceiptText,
    },
    // {
    //   title: "Manufacturing Orders",
    //   url: "#",
    //   icon: ReceiptText,
    //   items: [
    //     {
    //       title: "Standard",
    //       url: "/manufacturing-orders/standard",
    //     },
    //     {
    //       title: "Batch",
    //       url: "/manufacturing-orders/batch",
    //     },
    //   ],
    // },
    {
      title: "Work Orders",
      url: "/work-orders",
      icon: FileCheck,
    },
    {
      title: "Bill of Materials",
      url: "/bill-of-materials",
      icon: List,
    },
    {
      title: "Items",
      url: "/items",
      icon: Ungroup,
    },
    // {
    //   title: "Employees",
    //   url: "#",
    //   icon: Users,
    // },
    // {
    //   title: "Simulator",
    //   url: "#",
    //   icon: Calculator,
    //   items: [
    //     {
    //       title: "Input Requirement BOM",
    //       url: "#",
    //     },
    //     {
    //       title: "Output by Ingredients",
    //       url: "#",
    //     },
    //   ],
    // },
  ],
  // navSettings: [
  //   {
  //     title: "Unit of Measures",
  //     url: "#",
  //     icon: Settings2,
  //     items: [
  //       {
  //         title: "Working Hours",
  //         url: "#",
  //       },
  //       {
  //         title: "Work Centers",
  //         url: "#",
  //       },
  //       {
  //         title: "Operations",
  //         url: "#",
  //       },
  //     ],
  //   },
  //   {
  //     title: "Import Inventory",
  //     url: "#",
  //     icon: Import,
  //   },
  // ],
};

const markActive = (items: NavItem[], pathname: string): NavItem[] => {
  return items.map((item) => {
    const childItems = item.items
      ? markActive(item.items, pathname)
      : undefined;

    const isActive =
      (item.url !== "#" && pathname.startsWith(item.url)) ||
      childItems?.some((child) => child.isActive);

    return { ...item, ...(childItems && { items: childItems }), isActive };
  });
};

export const AppSidebar = ({ ...props }: ComponentProps<typeof Sidebar>) => {
  const pathname = usePathname();

  // const updatedNavTop = markActive(data.navTop, pathname);
  const updatedNavMain = markActive(data.navMain, pathname);
  // const updatedNavSettings = markActive(data.navSettings, pathname);

  return (
    <Sidebar collapsible="icon" {...props}>
      <SidebarHeader>
        <NavHeader />
      </SidebarHeader>
      <SidebarContent>
        {/* <NavMain title="Workspaces" items={updatedNavTop} /> */}
        <NavMain title="Views" items={updatedNavMain} />
        {/* <NavMain title="Settings" items={updatedNavSettings} /> */}
      </SidebarContent>
      <SidebarFooter>
        <ModuleSwitcher
          modules={["Manufacturing Order"]}
          defaultModule={"Manufacturing Order"}
        />
      </SidebarFooter>
      <SidebarRail />
    </Sidebar>
  );
};
