"use client";

import { Input } from "@/components/ui/input";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { Calendar as CalendarIcon } from "lucide-react";
import { Calendar } from "@/components/ui/calendar";
import { format } from "date-fns";
import { z } from "zod";
import { SubmitHandler, useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { gql } from "@fabrix-framework/fabrix";
import { useParams, useRouter, useSearchParams } from "next/navigation";
import { useQuery } from "urql";
import { useEffect } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import dynamic from "next/dynamic";
import { MOWorkOrdersTab } from "../tab-work-orders";

const MOLineItemsTab = dynamic(() => import("./items-table"), {
  ssr: false,
});

const QUERY = gql`
  query GetManufacturingOrderAndLineItems($id: ID!) {
    manufacturingOrder(id: $id) {
      name
      quantity
      bom {
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

const nameFormSchema = z.object({
  name: z.string(),
});

const dateFormSchema = z.object({
  date: z.date().optional().nullable(),
});

export default function StandardManufacturingOrderDetails({}) {
  const params = useParams();
  const id = params?.id;
  const router = useRouter();
  const searchParams = useSearchParams();

  const activeTab = searchParams.get("tab") || "items";

  const handleTabChange = (tabValue: string) => {
    const params = new URLSearchParams(searchParams);
    params.set("tab", tabValue);
    router.push(`?${params.toString()}`, undefined);
  };

  const [{ data }] = useQuery({
    query: QUERY,
    variables: { id },
  });

  const nameForm = useForm<z.infer<typeof nameFormSchema>>({
    resolver: zodResolver(nameFormSchema),
    defaultValues: {
      name: "",
    },
  });

  const dateForm = useForm<z.infer<typeof dateFormSchema>>({
    resolver: zodResolver(dateFormSchema),
    defaultValues: {
      date: null,
    },
  });

  useEffect(() => {
    if (data?.manufacturingOrder?.name) {
      nameForm.reset({
        name: data.manufacturingOrder.name,
      });
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data]);

  const onNameSubmit: SubmitHandler<z.infer<typeof nameFormSchema>> = (
    data,
  ) => {
    console.log(data); // TODO: Update the manufacturing order name
  };

  const onDateSubmit: SubmitHandler<z.infer<typeof dateFormSchema>> = (
    data,
  ) => {
    console.log(data); // TODO: Update the manufacturing order date
  };

  // @ts-expect-error - edges is not defined on type
  const moLineItems = data?.mOLineItems?.edges.map((edge) => edge.node) || [];
  const moWorkOrders = data?.workOrders?.edges || [];

  return (
    <div className="grid auto-rows-min gap-4 md:grid-cols-[30%_auto]">
      <div className="flex flex-col gap-4 rounded-xl">
        <div className="flex flex-col gap-4 rounded-xl border p-4">
          <header className="text-sm text-muted-foreground">Overview</header>

          <Form {...nameForm}>
            <form
              onSubmit={nameForm.handleSubmit(onNameSubmit)}
              className="space-y-8"
            >
              <div className="flex items-end space-x-4">
                <FormField
                  control={nameForm.control}
                  name="name"
                  render={({ field }) => (
                    <FormItem className="flex-1">
                      <FormLabel>Name</FormLabel>
                      <FormControl>
                        <Input placeholder="Name" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <Button type="submit" size="sm" className="mb-1">
                  Update
                </Button>
              </div>
            </form>
          </Form>

          <Form {...dateForm}>
            <form
              onSubmit={dateForm.handleSubmit(onDateSubmit)}
              className="space-y-8"
            >
              <div className="flex items-end space-x-4">
                <FormField
                  control={dateForm.control}
                  name="date"
                  render={({ field }) => (
                    <FormItem className="flex-1">
                      <FormLabel>Preferred Schedule</FormLabel>
                      <FormControl>
                        <Popover>
                          <PopoverTrigger asChild>
                            <Button
                              variant={"outline"}
                              className={cn(
                                "w-full pl-3 text-left font-normal",
                                !field.value && "text-muted-foreground",
                              )}
                            >
                              {field.value ? (
                                format(field.value, "PPP")
                              ) : (
                                <span>Pick a date</span>
                              )}
                              <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                            </Button>
                          </PopoverTrigger>
                          <PopoverContent className="w-full p-0" align="start">
                            <Calendar
                              mode="single"
                              selected={field.value ?? undefined}
                              onSelect={field.onChange}
                              disabled={(date) => date < new Date("1900-01-01")}
                              initialFocus
                            />
                          </PopoverContent>
                        </Popover>
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <Button type="submit" size="sm" className="mb-1">
                  Plan
                </Button>
              </div>
            </form>
          </Form>

          <div className="flex flex-col gap-4">
            <div className="flex items-center justify-between gap-2">
              <span className="text-sm text-muted-foreground">Bom</span>
              <span className="text-sm text-primary">
                {data?.manufacturingOrder?.bom.name}
              </span>
            </div>
            <div className="flex items-center justify-between gap-2">
              <span className="text-sm text-muted-foreground">Quantity</span>
              <span className="text-sm text-primary">
                {data?.manufacturingOrder?.quantity}
              </span>
            </div>
            <div className="flex items-center justify-between gap-2">
              <span className="text-sm text-muted-foreground">Status</span>
              <span className="text-sm text-primary">
                {data?.manufacturingOrder?.status}
              </span>
            </div>
            <div className="flex items-center justify-between gap-2">
              <span className="text-sm text-muted-foreground">
                Component Status
              </span>
              <span className="text-sm text-primary">
                {data?.manufacturingOrder?.componentsStatus}
              </span>
            </div>
            <div className="flex items-center justify-between gap-2">
              <span className="text-sm text-muted-foreground">Item</span>
              <span className="text-sm text-primary">
                {data?.manufacturingOrder?.item.name}
              </span>
            </div>
          </div>
        </div>
      </div>

      <div className="rounded-xl">
        <Tabs defaultValue={activeTab} onValueChange={handleTabChange}>
          <TabsList>
            <TabsTrigger value="items">Items</TabsTrigger>
            <TabsTrigger value="work-order">Work Order</TabsTrigger>
          </TabsList>
          <TabsContent value="items">
            <MOLineItemsTab moLineItems={moLineItems} />
          </TabsContent>
          <TabsContent value="work-order">
            <MOWorkOrdersTab workOrders={moWorkOrders} />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
