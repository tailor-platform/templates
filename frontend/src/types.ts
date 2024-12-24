export interface Item {
  id: string;
  name: string;
  inventoryType: string;
  bomId: string;
  __typename: string;
}

export interface Uom {
  name: string;
  id: string;
  __typename: string;
}

export interface BomLineItem {
  item: Item;
  uom: Uom;
  __typename: string;
}

export interface MOLineItem {
  id: string;
  requiredQuantity: number;
  totalCost: number;
  itemMoId: string | null;
  bomLineItem: BomLineItem;
  __typename: string;
}

export interface MOLineItemEdge {
  node: MOLineItem;
  __typename: string;
}

export interface MOLineItemConnection {
  edges: MOLineItemEdge[];
  __typename: string;
}
