import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { PanelRight } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { SidePanel } from "./side-panel";
import { type Contact } from "@/app/lib/IMS/types.generated";
import { DataTable } from "@/components/data-table";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { usePathname, useRouter, useSearchParams } from "next/navigation";

type Props = {
  contacts: Contact[];
  fetching: boolean;
};

const TableContent = ({ contacts, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("contactId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<Contact>[] = [
    {
      field: "name",
      headerName: "Name",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Contact>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("contactId", params.data?.id ?? null)}`,
              );
            }}
            className="invisible absolute inset-y-0 left-0 flex items-center group-hover:visible"
          >
            <button className="text-primary-500 hover:opacity-80">
              <PanelRight className="h-4 w-4" />
            </button>
          </div>
          {params.value}
        </div>
      ),
    },
    { field: "email", headerName: "Email", flex: 1 },
    { field: "company", headerName: "Company", flex: 1 },
    { field: "phone", headerName: "Phone", flex: 1 },
    { field: "address1", headerName: "Address", flex: 1 },
    { field: "city", headerName: "City", flex: 1 },
    { field: "province", headerName: "Province", flex: 1 },
    { field: "zip", headerName: "ZIP", flex: 1 },
    { field: "country", headerName: "Country", flex: 1 },
    {
      field: "creditLimit",
      headerName: "Credit Limit",
      flex: 1,
      valueFormatter: (params) => {
        if (params.value == null) return "";
        const numValue = Number(params.value);
        return isNaN(numValue) ? "" : numValue.toFixed(2);
      },
    },
    {
      field: "active",
      headerName: "Status",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Contact>) => (
        <Badge variant={params.value ? "default" : "destructive"}>
          {params.value ? "Active" : "Inactive"}
        </Badge>
      ),
    },
  ];

  return (
    <>
      <DataTable<Contact>
        rowData={contacts}
        columnDefs={colDefs}
        fetching={fetching}
        sideBar={{
          toolPanels: [
            {
              id: "columns",
              labelDefault: "Columns",
              labelKey: "columns",
              iconKey: "columns",
              toolPanel: "agColumnsToolPanel",
            },
            {
              id: "filters",
              labelDefault: "Filters",
              labelKey: "filters",
              iconKey: "filter",
              toolPanel: "agFiltersToolPanel",
            },
          ],
          defaultToolPanel: sidebarPanel || undefined,
          hiddenByDefault: !sidebarPanel,
        }}
        rowSelection="multiple"
        allowDragFromColumnsToolPanel
        rowGroupPanelShow="always"
        pivotPanelShow="always"
        onCellValueChanged={(event) => {
          console.log("Cell value changed:", event);
        }}
      />

      <SidePanel
        id={selectedId}
        onOpenChange={(open) => {
          if (open) return;
          router.push(`${pathname}?${createQueryString("contactId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ contacts, fetching }: Props) => {
  return <TableContent contacts={contacts} fetching={fetching} />;
};

export default Table;
