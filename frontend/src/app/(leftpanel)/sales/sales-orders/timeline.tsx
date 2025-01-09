"use client";

import {
  GanttFeatureItem,
  GanttFeatureList,
  GanttFeatureListGroup,
  GanttHeader,
  GanttProvider,
  GanttSidebar,
  GanttSidebarGroup,
  GanttSidebarItem,
  GanttTimeline,
  GanttToday,
} from "@/components/roadmap-ui/gantt";
import { useToast } from "@/hooks/use-toast";
import { SalesOrder } from "@/app/lib/IMS/types.generated";

type Props = {
  salesOrders: SalesOrder[];
};

export const SalesOrdersTimeline = ({ salesOrders }: Props) => {
  const { toast } = useToast();

  const groupedFeatures = {
    All: salesOrders.map((order) => {
      const orderDate = order.shopifyCreatedAt
        ? new Date(order.shopifyCreatedAt)
        : new Date();

      return {
        id: order.id,
        name: `#${order.orderNumber} - ${order.customerName}`,
        startAt: orderDate,
        endAt: orderDate,
        status: {
          id: order.shipStationOrderStatus || "not_sent",
          name: order.shipStationOrderStatus || "Not Sent",
          color: "bg-gray-300",
        },
        group: { id: "all", name: "All" },
        owner: null,
        product: null,
        initiative: null,
        release: null,
      };
    }),
  };

  const handleViewFeature = (id: string) =>
    toast({ description: `Order selected: ${id}` });

  return (
    <div className="ml-0 w-[100vh] overflow-hidden rounded-xl border">
      <GanttProvider range="monthly" zoom={100}>
        <GanttSidebar>
          {Object.entries(groupedFeatures).map(([group, features]) => (
            <GanttSidebarGroup key={group} name={group}>
              {features.map((feature) => (
                <GanttSidebarItem
                  key={feature.id}
                  feature={feature}
                  onSelectItem={handleViewFeature}
                />
              ))}
            </GanttSidebarGroup>
          ))}
        </GanttSidebar>
        <GanttTimeline>
          <GanttHeader />
          <GanttFeatureList>
            {Object.entries(groupedFeatures).map(([group, features]) => (
              <GanttFeatureListGroup key={group}>
                {features.map((feature) => (
                  <GanttFeatureItem key={feature.id} {...feature} />
                ))}
              </GanttFeatureListGroup>
            ))}
          </GanttFeatureList>
          <GanttToday />
        </GanttTimeline>
      </GanttProvider>
    </div>
  );
};
