"use client";

import {
  CalendarProvider,
  CalendarBody,
  CalendarHeader,
  CalendarItem,
  CalendarDate,
  CalendarDatePagination,
  CalendarMonthPicker,
  CalendarYearPicker,
  CalendarDatePicker,
  Status,
} from "@/components/roadmap-ui/calendar";
import { SalesOrder } from "@/app/lib/IMS/types.generated";

type Props = {
  salesOrders: SalesOrder[];
  statuses: Status[];
};

export const SalesOrdersCalendar = ({ salesOrders, statuses }: Props) => {
  const items = salesOrders.map((order) => ({
    id: order.id,
    name: `#${order.orderNumber} - ${order.customerName}`,
    startAt: order.shopifyCreatedAt
      ? new Date(order.shopifyCreatedAt)
      : new Date(),
    endAt: order.shopifyCreatedAt
      ? new Date(order.shopifyCreatedAt)
      : new Date(),
    status:
      statuses.find(
        (status) => status.id === order.shipStationOrderStatus?.toLowerCase(),
      ) || statuses[0],
  }));

  const earliestYear = Math.min(
    ...items.map((item) => item.startAt.getFullYear()),
  );
  const latestYear = Math.max(...items.map((item) => item.endAt.getFullYear()));

  return (
    <div className="ml-0 mt-4 w-full overflow-hidden rounded-xl border">
      <CalendarProvider>
        <CalendarDate>
          <CalendarDatePicker>
            <CalendarMonthPicker />
            <CalendarYearPicker start={earliestYear} end={latestYear} />
          </CalendarDatePicker>
          <CalendarDatePagination />
        </CalendarDate>
        <CalendarHeader />
        <CalendarBody items={items}>
          {({ item }) => <CalendarItem key={item.id} item={item} />}
        </CalendarBody>
      </CalendarProvider>
    </div>
  );
};
