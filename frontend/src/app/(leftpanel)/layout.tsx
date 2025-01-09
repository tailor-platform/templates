import { SidebarInset, SidebarTrigger } from "@/components/ui/sidebar";
import { Separator } from "@/components/ui/separator";
import { Breadcrumb } from "@/components/ui/breadcrumb";
import { PropsWithChildren } from "react";
import { ChevronRight } from "lucide-react";
// import { ButtonIcon } from "@/components/ui/button-icon";
import { ThemeToggle } from "@/components/ui/theme-toggle";
import { ViewProvider } from "@/app/(leftpanel)/view-context";
import { SidebarProvider } from "./sidebar-context";
import SubNav from "@/app/(leftpanel)/sub-nav";
import { RefreshProviderClient } from "./refresh-provider-client";

export default function LeftPanelLayout({ children }: PropsWithChildren) {
  return (
    <ViewProvider>
      <SidebarProvider>
        <RefreshProviderClient>
          <SidebarInset>
            <header className="flex h-16 shrink-0 items-center gap-2 transition-[width,height] ease-linear group-has-[[data-collapsible=icon]]/sidebar-wrapper:h-12">
              <div className="flex w-full items-center justify-between">
                <div className="flex items-center gap-2 px-4">
                  <SidebarTrigger className="-ml-1" />
                  <Separator orientation="vertical" className="mr-2 h-4" />
                  <Breadcrumb dynamic separator={<ChevronRight />} />
                </div>
                <div className="flex gap-2 px-4">
                  <ThemeToggle />
                  {/* <ButtonIcon>
                    <Sparkles />
                  </ButtonIcon> */}
                </div>
              </div>
            </header>

            <SubNav />

            <div className="flex flex-1 flex-col gap-4 p-4 pt-0">
              {children}
            </div>
          </SidebarInset>
        </RefreshProviderClient>
      </SidebarProvider>
    </ViewProvider>
  );
}
