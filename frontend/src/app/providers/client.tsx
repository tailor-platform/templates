"use client";

import { FabrixProvider } from "@fabrix-framework/fabrix";
import { dumbAuthExchange } from "@/lib/exchange";
import { omakaseFabrixComponents } from "@/components/fabrix/components";
import "ag-grid-enterprise";
import { LicenseManager } from "ag-grid-enterprise";
import { Toaster } from "@/components/ui/sonner";

LicenseManager.setLicenseKey(process.env.NEXT_PUBLIC_AG_GRID_LICENSE_KEY!);

export default function ClientProviders({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <FabrixProvider
      url={`${process.env.NEXT_PUBLIC_TAILOR_PF_URL}/query`}
      componentRegistry={omakaseFabrixComponents}
      prependExchanges={[dumbAuthExchange]}
    >
      {children}
      <Toaster />
    </FabrixProvider>
  );
}
