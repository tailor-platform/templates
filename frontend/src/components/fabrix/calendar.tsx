import { TableComponentProps } from "@fabrix-framework/fabrix";
import {
  CalendarProvider,
  CalendarDate,
  CalendarDatePicker,
  CalendarMonthPicker,
  CalendarYearPicker,
  CalendarDatePagination,
  CalendarBody,
  CalendarHeader,
  CalendarItem,
} from "../roadmap-ui/calendar";
import { get } from "es-toolkit/compat";
import { colorMap } from "./shared";
import * as changeCase from "change-case";

type OMKSCalendarProps = TableComponentProps<{
  startDateField: string;
  endDateField: string;
  statusField: string;
}>;

const fallbackStatusColor = "bg-gray-300";

export const OMKSCalendar = (props: OMKSCalendarProps) => {
  const enumTypes = props.headers.flatMap((header) => {
    if (header.type?.type !== "Enum") {
      return [];
    }

    return {
      name: header.key,
      values: header.type.meta.values,
    };
  });

  const statusTypes = enumTypes
    .find((e) => e.name === props.customProps.statusField)
    ?.values.map((value) => {
      const name = changeCase.capitalCase(value);

      return {
        id: value,
        name,
        color: colorMap[name] ?? fallbackStatusColor,
      };
    });

  const items = props.values.map((value) => {
    const startDate = get(value, props.customProps.startDateField);
    const endDate = get(value, props.customProps.endDateField);
    const status = statusTypes?.find(
      (status) => status.id === value.status,
    ) ?? {
      id: value.status as string,
      name: changeCase.capitalCase(value.status as string),
      color: fallbackStatusColor,
    };

    return {
      id: value.id as string,
      name: value.name as string,
      startAt: startDate ? new Date(startDate as string) : new Date(),
      endAt: startDate ? new Date(endDate as string) : new Date(),
      status,
    };
  });

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
