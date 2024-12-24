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
import { ManufacturingOrder } from "@/app/(leftpanel)/manufacturing-orders/standard/page";

type Props = {
  manufacturingOrders: ManufacturingOrder[];
  statuses: Status[];
};

export const StandardManufacturingOrdersCalendar = ({
  manufacturingOrders,
  statuses,
}: Props) => {
  const items = manufacturingOrders.map((order) => ({
    id: order.id,
    name: order.name,
    startAt: order.startDateTime ? new Date(order.startDateTime) : new Date(), // Default to today if not set
    endAt: order.endDateTime ? new Date(order.endDateTime) : new Date(), // Default to today if not set
    status: statuses.find((status) => status.id === order.status) || {
      id: order.status,
      name: order.status.replace(/_/g, " "),
      color: "bg-gray-300",
    },
  }));

  const earliestYear =
    items.map((item) => item.startAt.getFullYear()).sort()[0] ||
    new Date().getFullYear();

  const latestYear =
    items
      .map((item) => item.endAt.getFullYear())
      .sort()
      .at(-1) || new Date().getFullYear();

  return (
    <div className="ml-0 w-[100vh] overflow-hidden rounded-xl border">
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
