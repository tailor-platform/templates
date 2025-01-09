import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import { CheckIcon } from "lucide-react";

const StatusIcons = {
  Completed: <CheckIcon className="mr-2 h-4 w-4 text-green-500" />,
  Pending: <div className="ml-1 mr-3 h-2 w-2 rounded-full bg-primary" />,
  InProgress: (
    <div className="p-0.75 ml-0.5 mr-2.5 flex h-3 w-3 items-center justify-center rounded-full border border-[#ffc53d]">
      <div className="h-2 w-2 rounded-full bg-[#ffc53d]" />
    </div>
  ),
};

const LOG_SEQUENCE = [
  {
    id: 1,
    title: "Sales order received",
    status: "Completed",
    substeps: [
      {
        id: 1,
        title: "Sales order created",
        status: "Completed",
      },
      {
        id: 2,
        title: "Stock allocated",
        status: "Completed",
      },
      {
        id: 3,
        title: "Downpayment confirmed",
        status: "Completed",
      },
      {
        id: 4,
        title: "Order to manufacture",
        status: "Completed",
      },
    ],
  },
  {
    id: 2,
    title: "Manufacture order",
    status: "InProgress",
    substeps: [
      {
        id: 1,
        title: "Items ordered",
        status: "Completed",
      },
      {
        id: 2,
        title: "Items received",
        status: "Completed",
      },
      {
        id: 3,
        title: "Assembly in progress",
        status: "InProgress",
      },
      {
        id: 4,
        title: "Assembly completed",
        status: "Pending",
      },
    ],
  },
  {
    id: 3,
    title: "Ready for shipment",
    status: "Pending",
    substeps: [
      {
        id: 0,
        title: "Order picked",
        status: "Pending",
      },
      {
        id: 1,
        title: "Order packed",
        status: "Pending",
      },
      {
        id: 2,
        title: "Order shipped",
        status: "Pending",
      },
      {
        id: 3,
        title: "Tracking details added",
        status: "Pending",
      },
    ],
  },
  {
    id: 4,
    title: "Order delivered",
    status: "Pending",
    substeps: [
      {
        id: 1,
        title: "Shipped to local warehouse",
        status: "Pending",
      },
      {
        id: 2,
        title: "Delivered to customer",
        status: "Pending",
      },
    ],
  },
] as const;

export const ActivityLog = () => {
  return (
    <Accordion type="multiple">
      {LOG_SEQUENCE.map((log) => (
        <AccordionItem
          key={log.id}
          value={log.id.toString()}
          className="border-b-0"
        >
          <AccordionTrigger className="py-2">
            <div className="flex items-center">
              {StatusIcons[log.status]}
              {log.title}
            </div>
          </AccordionTrigger>
          <AccordionContent>
            <div className="ml-1.5 flex flex-col space-y-2 border-l-[1px] px-2">
              {log.substeps.map((substep) => (
                <div key={substep.id} className="ml-2 flex items-center">
                  {StatusIcons[substep.status]}
                  {substep.title}
                </div>
              ))}
            </div>
          </AccordionContent>
        </AccordionItem>
      ))}
    </Accordion>
  );
};
