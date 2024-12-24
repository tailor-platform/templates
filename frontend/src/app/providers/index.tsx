import ServerProviders from "./server";
import ClientProviders from "./client";

export default function Providers({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <ServerProviders>
      <ClientProviders>{children}</ClientProviders>
    </ServerProviders>
  );
}
