import { Dispatch, SetStateAction, useEffect, useState } from "react";
import { useQuery } from "urql";
import { useRouter, useSearchParams } from "next/navigation";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { gql } from "@fabrix-framework/fabrix";
import { MOWorkOrdersTab } from "@/app/(leftpanel)/manufacturing-orders/standard/tab-work-orders";
import { MOLineItemsTab } from "@/app/(leftpanel)/manufacturing-orders/standard/tab-line-items";
import { MOOverviewTab } from "@/app/(leftpanel)/manufacturing-orders/standard/tab-overview";

type MOSidePanelProps = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

type Tabs = "overview" | "items" | "work-orders";

const MO_QUERY = gql`
  query mo($id: ID!) {
    manufacturingOrder(id: $id) {
      id
      name
      quantity
      bom {
        id
        name
      }
      status
      startDateTime
      endDateTime
      componentsStatus
      item {
        id
        name
      }
    }
    mOLineItems(query: { moId: { eq: $id } }) {
      edges {
        node {
          id
          requiredQuantity
          totalCost
          itemMoId
          bomLineItem {
            item {
              id
              name
              inventoryType
              bomId
            }
            uom {
              name
              id
            }
          }
        }
      }
    }
    workOrders(query: { moId: { eq: $id } }) {
      edges {
        node {
          operation {
            name
            workCenter {
              name
            }
          }
          status
          order
          expectedDuration
          realDuration
          startDate
          endDate
        }
      }
    }
  }
`;

export function MOSidePanel({ id, onOpenChange }: MOSidePanelProps) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [selectedTab, setSelectedTab] = useState<Tabs>("overview");

  const [{ data }] = useQuery({
    query: MO_QUERY,
    variables: { id },
    pause: !id,
  });

  useEffect(() => {
    const tabVal = searchParams.get("tab") as Tabs;
    if (tabVal) {
      setSelectedTab(tabVal);
    } else {
      setSelectedTab("overview"); // Default tab
    }
  }, [searchParams]);

  const handleTabChange = (newTab: Tabs) => {
    setSelectedTab(newTab);
    if (id) {
      router.push(`/manufacturing-orders/standard?id=${id}&tab=${newTab}`);
    }
  };

  const handleExpand = () => {
    if (id) {
      router.push(`/manufacturing-orders/standard/${id}/?tab=items`);
    }
  };

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && data && (
        <SheetContent
          className="h-full w-[80vh] overflow-auto sm:w-[80vh]"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
          onExpand={handleExpand}
        >
          <SheetHeader>
            <SheetTitle>{data.manufacturingOrder.name}</SheetTitle>
          </SheetHeader>
          <Tabs
            value={selectedTab}
            onValueChange={(newTab) => handleTabChange(newTab as Tabs)}
          >
            <TabsList>
              <TabsTrigger value="overview">Overview</TabsTrigger>
              <TabsTrigger value="items">Items</TabsTrigger>
              <TabsTrigger value="work-orders">Work Orders</TabsTrigger>
            </TabsList>
            <TabsContent value="overview" className="overflow-auto">
              <MOOverviewTab manufacturingOrder={data.manufacturingOrder} />
            </TabsContent>
            <TabsContent value="items" className="overflow-auto">
              <MOLineItemsTab moLineItems={data.mOLineItems.edges} />
            </TabsContent>
            <TabsContent value="work-orders" className="overflow-auto">
              <MOWorkOrdersTab workOrders={data.workOrders.edges} />
            </TabsContent>
          </Tabs>
        </SheetContent>
      )}
    </Sheet>
  );
}
