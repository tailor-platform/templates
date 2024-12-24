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
import { ManufacturingOrder } from "@/app/(leftpanel)/manufacturing-orders/standard/page";

type Props = {
  manufacturingOrders: ManufacturingOrder[];
};

export const StandardManufacturingOrdersTimeline = ({
  manufacturingOrders,
}: Props) => {
  const { toast } = useToast();

  // Roadmap UI's Gantt chart requires the data to be grouped by a specific key and includes specific properties.
  // In this case, we're grouping by "All" and adding the required properties.
  // This is a simplified example, grouping all items in "All" with no owner, product, initiative, or release.
  // Here is an example of the expected format:
  // https://github.com/haydenbleasel/roadmap-ui/blob/main/lib/content.ts#L18-L339
  const groupedFeatures = {
    All: manufacturingOrders.map((order) => {
      // Default start and end dates in case the values are null
      // It is just defaulting to a one month time duration.
      const defaultStartAt = new Date();
      const defaultEndAt = new Date();
      defaultEndAt.setMonth(defaultEndAt.getMonth() + 1); // One month from today

      return {
        id: order.id,
        name: order.name,
        startAt: order.startDateTime
          ? new Date(order.startDateTime)
          : defaultStartAt,
        endAt: order.endDateTime ? new Date(order.endDateTime) : defaultEndAt,
        status: { id: order.status, name: order.status, color: "bg-gray-300" },
        group: { id: "all", name: "All" },
        owner: null,
        product: null,
        initiative: null,
        release: null,
      };
    }),
  };

  const handleViewFeature = (id: string) =>
    toast({ description: `Feature selected: ${id}` });

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
