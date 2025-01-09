import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { zodResolver } from "@hookform/resolvers/zod";
import { themeQuartz } from "ag-grid-enterprise";
import { AgGridReact } from "ag-grid-react";
import { PlusIcon, X } from "lucide-react";
import { useTheme } from "next-themes";
import { useCallback, useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { gql, useMutation, useQuery } from "urql";
import { z } from "zod";

const baseThemeParams = {
  borderRadius: 2,
  fontFamily: {
    googleFont: "Inter",
  },
  fontSize: 13,
  headerFontSize: 14,
  spacing: 6,
  wrapperBorderRadius: 2,
};

const myDarkTheme = themeQuartz.withParams({
  ...baseThemeParams,
  backgroundColor: "#000",
  foregroundColor: "#fafafa",
  rowHoverColor: "#262626",
  checkboxCheckedBackgroundColor: "#fff",
  checkboxCheckedShapeColor: "#0a0a0a",
  checkboxCheckedBorderColor: "#fff",
});

const myLightTheme = themeQuartz.withParams({
  ...baseThemeParams,
  backgroundColor: "#FFFFFF",
  foregroundColor: "#0a0a0a",
  rowHoverColor: "#f5f5f5",
  checkboxCheckedBackgroundColor: "#0a0a0a",
  checkboxCheckedShapeColor: "#fff",
  checkboxCheckedBorderColor: "#0a0a0a",
});

const newMOSchema = z.object({
  item: z.string().nonempty(),
  quantity: z.number({ coerce: true }).min(1),
  name: z.string().nonempty(),
  bom: z.string(),
});

type MOFormValues = z.infer<typeof newMOSchema>;

export type BomItem = {
  id: string;
  item: {
    id: string;
    name: string;
  };
};

type TableViewProps =
  | {
      type: "work-order";
      data: {
        calculatedDuration: number;
        description: string;
        documentUrl: string;
        duration: number;
        order: number;
        id: string;
        isActive: boolean;
        name: string;
        workCenter: string;
        workCenterId: string;
      }[];
    }
  | {
      type: "items";
      data: {
        id: string;
        itemId: string;
        itemName: string;
        itemDescription: string;
        itemInventoryType: string;
        itemIsActive: boolean;
        itemIsFinalProduct: boolean;
        uomName: string;
        outputQuantity: number;
        uomId: string;
      }[];
    };

function Grid({ type, data }: TableViewProps) {
  const { theme } = useTheme();
  const appliedTheme = theme === "dark" ? myDarkTheme : myLightTheme;

  if (type === "work-order") {
    return (
      <AgGridReact
        theme={appliedTheme}
        defaultColDef={{
          filter: true,
          resizable: true,
          sortable: true,
          enableValue: true,
        }}
        rowData={data}
        columnDefs={[
          {
            field: "name",
            headerName: "Name",
            flex: 1,
          },
          {
            field: "workCenter",
            headerName: "Work Center",
            flex: 1,
          },
          {
            field: "order",
            headerName: "Order",
            flex: 1,
          },
          {
            field: "calculatedDuration",
            headerName: "Expected Duration",
            flex: 1,
          },
          {
            field: "documentUrl",
            headerName: "Document URL",
            flex: 1,
          },
        ]}
      />
    );
  }

  if (type === "items") {
    return (
      <AgGridReact
        theme={appliedTheme}
        defaultColDef={{
          filter: true,
          resizable: true,
          sortable: true,
          enableValue: true,
        }}
        rowData={data}
        columnDefs={[
          {
            field: "itemName",
            headerName: "Name",
            flex: 1,
          },
          {
            field: "itemDescription",
            headerName: "Description",
            flex: 1,
          },
          {
            field: "itemInventoryType",
            headerName: "Inventory Type",
            flex: 1,
          },
          {
            field: "itemIsFinalProduct",
            headerName: "Inventory Type",
            flex: 1,
          },
          {
            field: "outputQuantity",
            headerName: "Inventory Type",
            flex: 1,
          },
          {
            field: "uomName",
            headerName: "Unit of Measure",
            flex: 1,
          },
        ]}
      />
    );
  }
}

function TableView(props: TableViewProps) {
  return (
    <TabsContent
      className="mt-0 h-[250px] px-4 lg:h-[calc(100%-68px)] lg:px-0"
      value={props.type}
    >
      <Grid {...props} />
    </TabsContent>
  );
}

export default function CreateNewManufacturingOrder() {
  const [open, setOpen] = useState(false);
  const createMOForm = useForm<MOFormValues>({
    resolver: zodResolver(newMOSchema),
    defaultValues: {
      item: "",
      quantity: 0,
      name: "",
      bom: "",
    },
  });

  const [{ data }] = useQuery({
    query: gql`
      query {
        boms(
          first: 1000
          order: { field: createdAt, direction: Desc }
          query: { isActive: { eq: true } }
        ) {
          edges {
            node {
              id
              item {
                id
                name
              }
            }
          }
        }
      }
    `,
  });

  const [{ fetching }, createMo] = useMutation(gql`
    mutation CreateManufacturingOrder($input: createManufacturingInput!) {
      createManufacturingOrderAndWorkOrders(input: $input) {
        manufacturingOrderId
      }
    }
  `);

  const handleSubmit = useCallback(
    async (values: MOFormValues) => {
      await createMo(
        {
          input: {
            name: values.name,
            quantity: values.quantity,
            bomId: values.bom,
          },
        },
        { additionalTypenames: ["ManufacturingOrderConnection"] },
      );

      setOpen(false);
    },
    [createMo],
  );

  const items: BomItem[] =
    data?.boms?.edges?.map((edge: { node: BomItem }) => edge.node) || [];

  const [bomItem, selectedBom, quantity] = createMOForm.watch([
    "item",
    "bom",
    "quantity",
  ]);
  const bomItems = bomItem
    ? items.filter(({ item }) => item.id === bomItem)
    : items;

  useEffect(() => {
    if (!bomItem || !bomItems[0]) return;

    if (selectedBom === bomItems[0].id) return;

    createMOForm.setValue("bom", bomItems[0].id);
  }, [bomItem, bomItems, selectedBom, createMOForm]);

  const [{ data: previewData }] = useQuery({
    query: gql`
      query ($bomId: ID!, $outputQuantity: Float!) {
        previewManufacturing(
          input: { bomId: $bomId, outputQuantity: $outputQuantity }
        ) {
          requiredItems {
            id
            itemId
            itemName
            itemDescription
            itemInventoryType
            itemIsActive
            itemIsFinalProduct
            uomName
            outputQuantity
            uomId
          }
          workOperations {
            calculatedDuration
            description
            documentUrl
            duration
            order
            id
            isActive
            name
            workCenter
            workCenterId
          }
        }
      }
    `,
    variables: {
      bomId: selectedBom,
      outputQuantity: Number(quantity),
    },
    pause: !bomItem || !selectedBom || Number(quantity) <= -1,
  });

  const itemsData = previewData?.previewManufacturing?.requiredItems || [];
  const workOrderData = previewData?.previewManufacturing?.workOperations || [];

  return (
    <Drawer open={open} onOpenChange={setOpen}>
      <DrawerTrigger asChild>
        <Button size="sm">
          <PlusIcon />
          New
        </Button>
      </DrawerTrigger>
      <DrawerContent className="bg-card">
        <Form {...createMOForm}>
          <form onSubmit={createMOForm.handleSubmit(handleSubmit)}>
            <div className="flex h-screen flex-col justify-between">
              <DrawerHeader className="flex flex-row items-center justify-between gap-4 bg-accent p-4">
                <DrawerTitle className="leading-normal">
                  Create a new manufacturing order
                </DrawerTitle>
                <DrawerClose asChild>
                  <Button variant="ghost" size="icon">
                    <X />
                  </Button>
                </DrawerClose>
              </DrawerHeader>

              {/* Content - This should be passed-in */}
              <div className="flex flex-1 flex-col lg:flex-row">
                <div className="flex flex-col gap-4 p-4 lg:basis-1/2">
                  <Card className="p-4">
                    <CardHeader>
                      <CardTitle className="text-muted-foreground">
                        Overview
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="grid grid-cols-2 gap-4">
                        <FormField
                          control={createMOForm.control}
                          name="item"
                          render={({ field }) => (
                            <FormItem>
                              <FormLabel>Item*</FormLabel>
                              <FormControl>
                                <Select
                                  onValueChange={field.onChange}
                                  defaultValue={field.value}
                                  value={field.value}
                                >
                                  <SelectTrigger className="w-full">
                                    <SelectValue placeholder="Select item to create MO for" />
                                  </SelectTrigger>
                                  <SelectContent>
                                    {items.map(({ item }) => (
                                      <SelectItem key={item.id} value={item.id}>
                                        {item.name}
                                      </SelectItem>
                                    ))}
                                  </SelectContent>
                                </Select>
                              </FormControl>
                              <FormMessage />
                            </FormItem>
                          )}
                        />
                        <FormField
                          control={createMOForm.control}
                          name="name"
                          render={({ field }) => (
                            <FormItem>
                              <FormLabel>Name*</FormLabel>
                              <FormControl>
                                <Input placeholder="Name" {...field} />
                              </FormControl>
                              <FormMessage />
                            </FormItem>
                          )}
                        />
                        <FormField
                          control={createMOForm.control}
                          name="quantity"
                          render={({ field }) => (
                            <FormItem>
                              <FormLabel>Quantity*</FormLabel>
                              <FormControl>
                                <Input
                                  placeholder="Quantity"
                                  type="number"
                                  {...field}
                                />
                              </FormControl>
                              <FormMessage />
                            </FormItem>
                          )}
                        />
                      </div>
                    </CardContent>
                  </Card>
                  <Card className="p-4">
                    <CardHeader>
                      <CardTitle className="text-muted-foreground">
                        Read only
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="grid grid-cols-2 gap-4">
                        <FormField
                          control={createMOForm.control}
                          name="bom"
                          render={({ field }) => (
                            <FormItem>
                              <FormLabel>Bill of Material</FormLabel>
                              <FormControl>
                                <Select
                                  onValueChange={field.onChange}
                                  defaultValue={field.value}
                                  value={field.value}
                                >
                                  <SelectTrigger className="w-full">
                                    <SelectValue placeholder="Select to view bill" />
                                  </SelectTrigger>
                                  <SelectContent>
                                    {bomItems.map(({ id, item }) => (
                                      <SelectItem key={id} value={id}>
                                        {item.name}
                                      </SelectItem>
                                    ))}
                                  </SelectContent>
                                </Select>
                              </FormControl>
                              <FormMessage />
                            </FormItem>
                          )}
                        />
                      </div>
                    </CardContent>
                  </Card>
                </div>

                {/* Workder Orders and Items */}
                <div className="self-stretch lg:basis-1/2 lg:border-l-[1px]">
                  <Tabs defaultValue="items" className="h-full">
                    <div className="px-4 pb-4 lg:py-4">
                      <TabsList>
                        <TabsTrigger value="items">Items</TabsTrigger>
                        <TabsTrigger value="work-order">
                          Work Orders
                        </TabsTrigger>
                      </TabsList>
                    </div>

                    <TableView type="items" data={itemsData} />
                    <TableView type="work-order" data={workOrderData} />
                  </Tabs>
                </div>
              </div>
              {/* End Content */}

              <DrawerFooter className="flex flex-row justify-end gap-4 bg-accent">
                <DrawerClose asChild>
                  <Button
                    type="reset"
                    size="sm"
                    variant="ghost"
                    disabled={fetching}
                  >
                    Cancel
                  </Button>
                </DrawerClose>
                <Button
                  type="submit"
                  size="sm"
                  disabled={fetching || !createMOForm.formState.isValid}
                >
                  Create
                </Button>
              </DrawerFooter>
            </div>
          </form>
        </Form>
      </DrawerContent>
    </Drawer>
  );
}
