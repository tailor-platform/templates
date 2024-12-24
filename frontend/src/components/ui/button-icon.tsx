import { Button } from "@/components/ui/button";
import { PropsWithChildren } from "react";

export function ButtonIcon({ children }: PropsWithChildren) {
  return (
    <Button variant="secondary" size="icon">
      {children}
    </Button>
  );
}
