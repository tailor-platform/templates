import { z } from "zod";
import { ManufacturingOrder } from "@/app/(leftpanel)/manufacturing-orders/standard/page";
import { SubmitHandler, useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useEffect } from "react";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { cn } from "@/lib/utils";
import { format } from "date-fns";
import { Calendar as CalendarIcon } from "lucide-react";
import { Calendar } from "@/components/ui/calendar";

type Props = {
  manufacturingOrder: ManufacturingOrder;
};

const nameFormSchema = z.object({
  name: z.string(),
});

const dateFormSchema = z.object({
  date: z.date().optional().nullable(),
});

export const MOOverviewTab = ({ manufacturingOrder }: Props) => {
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
    if (manufacturingOrder?.name) {
      nameForm.reset({
        name: manufacturingOrder.name,
      });
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [manufacturingOrder]);

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

  const onUnplan = () => {
    console.log("Unplan"); // TODO: Unplan the manufacturing order
  };

  return (
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

        {manufacturingOrder?.status === "Planned" ? (
          <Button type="button" size="sm" onClick={onUnplan}>
            Unplan
          </Button>
        ) : (
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
        )}

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Bom</span>
            <span className="text-sm text-primary">
              {manufacturingOrder?.bom.name}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Quantity</span>
            <span className="text-sm text-primary">
              {manufacturingOrder?.quantity}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Status</span>
            <span className="text-sm text-primary">
              {manufacturingOrder?.status}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Component Status
            </span>
            <span className="text-sm text-primary">
              {manufacturingOrder?.componentsStatus}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Item</span>
            <span className="text-sm text-primary">
              {manufacturingOrder?.item?.name}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
