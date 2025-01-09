export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
  Date: { input: any; output: any; }
  DateTime: { input: any; output: any; }
  FieldSet: { input: any; output: any; }
  Time: { input: any; output: any; }
};

/** BOM description */
export type Bom = {
  __typename?: 'Bom';
  /** Type or category of the BOM */
  bomType: BomBomType;
  /** Indicates bom lineitems and operations are linked properly or not message */
  configureMessage?: Maybe<Scalars['String']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Detailed description of the BOM */
  description?: Maybe<Scalars['String']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Indicates if the BOM is active */
  isActive?: Maybe<Scalars['Boolean']['output']>;
  /** Indicates bom lineitems and operations are linked properly or not */
  isConfiguredProperly?: Maybe<Scalars['Boolean']['output']>;
  /** Link to the Item */
  item?: Maybe<Item>;
  /** Unique identifier of the associated item */
  itemId: Scalars['ID']['output'];
  /** Name of the BOM */
  name: Scalars['String']['output'];
  /** Quantity of the final product produced */
  outputQuantity?: Maybe<Scalars['Int']['output']>;
  /** Name of the SKU */
  sku: Scalars['String']['output'];
  /** Link to the Unit of Measure */
  uom?: Maybe<Uom>;
  /** Unique identifier of the unit of measure */
  uomId: Scalars['ID']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

export enum BomBomType {
  /** The BOM represents a component to build an item. */
  Component = 'COMPONENT',
  /** The BOM represents the final product. */
  FinalProduct = 'FINAL_PRODUCT',
  /** The BOM is used to bundle multiple items together. */
  Kit = 'KIT',
  /** The BOM is used to produce an item using a manufacturing or assembly process. */
  Recipe = 'RECIPE'
}

export type BomBomTypeEnumFilter = {
  eq?: InputMaybe<BomBomType>;
  in?: InputMaybe<Array<InputMaybe<BomBomType>>>;
  ne?: InputMaybe<BomBomType>;
  nin?: InputMaybe<Array<InputMaybe<BomBomType>>>;
};

/** BOM description(Connection) */
export type BomConnection = {
  __typename?: 'BomConnection';
  edges: Array<BomEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** BOM description(CreateInput) */
export type BomCreateInput = {
  /** Type or category of the BOM */
  bomType: BomBomType;
  /** Indicates bom lineitems and operations are linked properly or not message */
  configureMessage?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Detailed description of the BOM */
  description?: InputMaybe<Scalars['String']['input']>;
  /** ID of the BOM description */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Indicates if the BOM is active */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Indicates bom lineitems and operations are linked properly or not */
  isConfiguredProperly?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated item */
  itemId: Scalars['ID']['input'];
  /** Name of the BOM */
  name: Scalars['String']['input'];
  /** Quantity of the final product produced */
  outputQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** Name of the SKU */
  sku: Scalars['String']['input'];
  /** Unique identifier of the unit of measure */
  uomId: Scalars['ID']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** bom(Edge) */
export type BomEdge = {
  __typename?: 'BomEdge';
  cursor: Scalars['String']['output'];
  node: Bom;
};

export type BomItemCompositeKey = {
  /** Unique identifier of the associated BOM */
  bomId: Scalars['ID']['input'];
  /** Unique identifier of the associated item */
  itemId: Scalars['ID']['input'];
};

/** BOMLineItem description */
export type BomLineItem = {
  __typename?: 'BomLineItem';
  /** Link to the BOM */
  bom?: Maybe<Bom>;
  /** Unique identifier of the associated BOM */
  bomId: Scalars['ID']['output'];
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Quantity of input items required */
  inputQuantity?: Maybe<Scalars['Int']['output']>;
  /** Link to the Item */
  item?: Maybe<Item>;
  /** Unique identifier of the associated item */
  itemId: Scalars['ID']['output'];
  /** Link to the Item */
  returnAsNewSkuItem?: Maybe<Item>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: Maybe<Scalars['ID']['output']>;
  /** Scrap action for item */
  scrapAction?: Maybe<BomLineItemScrapAction>;
  /** Total cost of the component based on input quantity, uom and unit cost */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /** Cost per unit of the component */
  unitCost?: Maybe<Scalars['Float']['output']>;
  /** Link to the Unit of Measure */
  uom?: Maybe<Uom>;
  /** Unique identifier of the unit of measure */
  uomId: Scalars['ID']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** BOMLineItem description(Connection) */
export type BomLineItemConnection = {
  __typename?: 'BomLineItemConnection';
  edges: Array<BomLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** BOMLineItem description(CreateInput) */
export type BomLineItemCreateInput = {
  /** Unique identifier of the associated BOM */
  bomId: Scalars['ID']['input'];
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the BOMLineItem description */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Quantity of input items required */
  inputQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated item */
  itemId: Scalars['ID']['input'];
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<BomLineItemScrapAction>;
  /** Total cost of the component based on input quantity, uom and unit cost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** Cost per unit of the component */
  unitCost?: InputMaybe<Scalars['Float']['input']>;
  /** Unique identifier of the unit of measure */
  uomId: Scalars['ID']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** bomLineItem(Edge) */
export type BomLineItemEdge = {
  __typename?: 'BomLineItemEdge';
  cursor: Scalars['String']['output'];
  node: BomLineItem;
};

export enum BomLineItemOrderFieldEnum {
  CreatedAt = 'createdAt',
  InputQuantity = 'inputQuantity',
  ScrapAction = 'scrapAction',
  TotalCost = 'totalCost',
  UnitCost = 'unitCost',
  UpdatedAt = 'updatedAt'
}

export type BomLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: BomLineItemOrderFieldEnum;
};

/** BOMLineItem description(Input) */
export type BomLineItemQueryInput = {
  and?: InputMaybe<Array<BomLineItemQueryInput>>;
  bomId?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  inputQuantity?: InputMaybe<IntegerFilter>;
  itemId?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<BomLineItemQueryInput>>;
  or?: InputMaybe<Array<BomLineItemQueryInput>>;
  returnAsNewSkuItemId?: InputMaybe<UuidFilter>;
  scrapAction?: InputMaybe<BomLineItemScrapActionEnumFilter>;
  totalCost?: InputMaybe<FloatFilter>;
  unitCost?: InputMaybe<FloatFilter>;
  uomId?: InputMaybe<UuidFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

export enum BomLineItemScrapAction {
  /** Return */
  Return = 'Return',
  /** Return as new SKU */
  ReturnAsNewSku = 'Return_as_new_SKU',
  /** Waste */
  Waste = 'Waste'
}

export type BomLineItemScrapActionEnumFilter = {
  eq?: InputMaybe<BomLineItemScrapAction>;
  in?: InputMaybe<Array<InputMaybe<BomLineItemScrapAction>>>;
  ne?: InputMaybe<BomLineItemScrapAction>;
  nin?: InputMaybe<Array<InputMaybe<BomLineItemScrapAction>>>;
};

/** BOMLineItem description(UpdateInput) */
export type BomLineItemUpdateInput = {
  /** Unique identifier of the associated BOM */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Quantity of input items required */
  inputQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated item */
  itemId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<BomLineItemScrapAction>;
  /** Total cost of the component based on input quantity, uom and unit cost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** Cost per unit of the component */
  unitCost?: InputMaybe<Scalars['Float']['input']>;
  /** Unique identifier of the unit of measure */
  uomId?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export enum BomOrderFieldEnum {
  BomType = 'bomType',
  ConfigureMessage = 'configureMessage',
  CreatedAt = 'createdAt',
  Description = 'description',
  IsActive = 'isActive',
  IsConfiguredProperly = 'isConfiguredProperly',
  Name = 'name',
  OutputQuantity = 'outputQuantity',
  Sku = 'sku',
  UpdatedAt = 'updatedAt'
}

export type BomOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: BomOrderFieldEnum;
};

/** BOM description(Input) */
export type BomQueryInput = {
  and?: InputMaybe<Array<BomQueryInput>>;
  bomType?: InputMaybe<BomBomTypeEnumFilter>;
  configureMessage?: InputMaybe<StringFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  description?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  isActive?: InputMaybe<BoolFilter>;
  isConfiguredProperly?: InputMaybe<BoolFilter>;
  itemId?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<BomQueryInput>>;
  or?: InputMaybe<Array<BomQueryInput>>;
  outputQuantity?: InputMaybe<IntegerFilter>;
  sku?: InputMaybe<StringFilter>;
  uomId?: InputMaybe<UuidFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** BOM description(UpdateInput) */
export type BomUpdateInput = {
  /** Type or category of the BOM */
  bomType?: InputMaybe<BomBomType>;
  /** Indicates bom lineitems and operations are linked properly or not message */
  configureMessage?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Detailed description of the BOM */
  description?: InputMaybe<Scalars['String']['input']>;
  /** Indicates if the BOM is active */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Indicates bom lineitems and operations are linked properly or not */
  isConfiguredProperly?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated item */
  itemId?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the BOM */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Quantity of the final product produced */
  outputQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** Name of the SKU */
  sku?: InputMaybe<Scalars['String']['input']>;
  /** Unique identifier of the unit of measure */
  uomId?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type BoolFilter = {
  eq?: InputMaybe<Scalars['Boolean']['input']>;
  ne?: InputMaybe<Scalars['Boolean']['input']>;
};

export enum BulkUpsertBomLineItemByFieldEnum {
  /** Available bulk upsert key: bomItemCompositeKey */
  BomItemCompositeKey = 'bomItemCompositeKey',
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertContactByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertCostPoolLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertDailyScheduleByFieldEnum {
  /** Available bulk upsert key: dailyScheduleUniquenessCompositeKey */
  DailyScheduleUniquenessCompositeKey = 'dailyScheduleUniquenessCompositeKey',
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertEmployeeByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertFinancialStockSummaryByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertInventoryItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertInvoiceLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertLocationByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertMoLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id',
  /** Available bulk upsert key: moLineItemCompositeKey */
  MoLineItemCompositeKey = 'moLineItemCompositeKey'
}

export enum BulkUpsertManufacturingOrderTransitionByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertOperationByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertOperationDependencyByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id',
  /** Available bulk upsert key: operationDependenciesCompositeKey */
  OperationDependenciesCompositeKey = 'operationDependenciesCompositeKey'
}

export enum BulkUpsertOperationLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertProductByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertProductImageByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertProductVariantByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertPurchaseOrderLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertReceiptLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertSalesOrderByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertSalesOrderLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertShipmentLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertUomByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id',
  /** Available bulk upsert key: name */
  Name = 'name'
}

export enum BulkUpsertUomConversionByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id',
  /** Available bulk upsert key: uomConversionCompositeKey */
  UomConversionCompositeKey = 'uomConversionCompositeKey'
}

export enum BulkUpsertWoTimeTrackingByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertWorkCenterByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertWorkOrderByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertWorkOrderDependencyByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id',
  /** Available bulk upsert key: workOrderDependenciesCompositeKey */
  WorkOrderDependenciesCompositeKey = 'workOrderDependenciesCompositeKey'
}

export enum BulkUpsertWorkOrderLineItemByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertWorkOrderTransitionByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export enum BulkUpsertWorkingHourByFieldEnum {
  /** Available bulk upsert key: id */
  Id = 'id'
}

export type ComputeManufacturingOrderCostInput = {
  manufacturingOrderId: Scalars['ID']['input'];
};

export type ComputeManufacturingOrderCostOutput = {
  __typename?: 'ComputeManufacturingOrderCostOutput';
  calculatedWorkOrders?: Maybe<Array<Maybe<CalculatedWorkOrderListResult>>>;
  manufacturingOrderTotalCost?: Maybe<Scalars['Float']['output']>;
  manufacturingOrderTotalExpectedCost?: Maybe<Scalars['Float']['output']>;
  manufacturingOrderUnitCost?: Maybe<Scalars['Float']['output']>;
  manufacturingOrderUnitExpectedCost?: Maybe<Scalars['Float']['output']>;
  moLineItemsTotalCost?: Maybe<Scalars['Float']['output']>;
  workOrderTotalCost?: Maybe<Scalars['Float']['output']>;
  workOrderTotalDuration?: Maybe<Scalars['Float']['output']>;
  workOrderTotalExpectedCost?: Maybe<Scalars['Float']['output']>;
  workOrderTotalExpectedDuration?: Maybe<Scalars['Float']['output']>;
};

export type ComputeWorkOrderCostInput = {
  workOrderId: Scalars['ID']['input'];
};

export type ComputeWorkOrderCostOutput = {
  __typename?: 'ComputeWorkOrderCostOutput';
  costPerEmployee?: Maybe<Scalars['Float']['output']>;
  hourlyProcessingCost?: Maybe<Scalars['Float']['output']>;
  totalCost?: Maybe<Scalars['Float']['output']>;
  totalDuration?: Maybe<Scalars['Float']['output']>;
  totalExpectedCost?: Maybe<Scalars['Float']['output']>;
  totalExpectedDuration?: Maybe<Scalars['Float']['output']>;
};

export type ComputeWorkOrderCostRealDurationInput = {
  workOrderId: Scalars['ID']['input'];
};

export type ComputeWorkOrderCostRealDurationOutput = {
  __typename?: 'ComputeWorkOrderCostRealDurationOutput';
  totalDuration?: Maybe<Scalars['Float']['output']>;
};

/** Contact model */
export type Contact = {
  __typename?: 'Contact';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** address1 */
  address1?: Maybe<Scalars['String']['output']>;
  /** address2 */
  address2?: Maybe<Scalars['String']['output']>;
  /** The amount of credit available to the customer. */
  availableCredit?: Maybe<Scalars['Float']['output']>;
  /** city */
  city?: Maybe<Scalars['String']['output']>;
  /** company */
  company?: Maybe<Scalars['String']['output']>;
  /** country */
  country?: Maybe<Scalars['String']['output']>;
  /** countryCode */
  countryCode?: Maybe<Scalars['String']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** The amount of credit limit of the customer. */
  creditLimit?: Maybe<Scalars['Float']['output']>;
  /** email */
  email: Scalars['String']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /** name */
  name: Scalars['String']['output'];
  /** The amount of open balance of the customer. */
  openBalance?: Maybe<Scalars['Float']['output']>;
  /** phone */
  phone?: Maybe<Scalars['String']['output']>;
  /** province */
  province?: Maybe<Scalars['String']['output']>;
  /** province_code */
  provinceCode?: Maybe<Scalars['String']['output']>;
  /** the reference id of the customer in quickbook */
  quickBookCustomerId?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** zip */
  zip?: Maybe<Scalars['String']['output']>;
};

/** Contact model(Connection) */
export type ContactConnection = {
  __typename?: 'ContactConnection';
  edges: Array<ContactEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Contact model(CreateInput) */
export type ContactCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** address1 */
  address1?: InputMaybe<Scalars['String']['input']>;
  /** address2 */
  address2?: InputMaybe<Scalars['String']['input']>;
  /** The amount of credit available to the customer. */
  availableCredit?: InputMaybe<Scalars['Float']['input']>;
  /** city */
  city?: InputMaybe<Scalars['String']['input']>;
  /** company */
  company?: InputMaybe<Scalars['String']['input']>;
  /** country */
  country?: InputMaybe<Scalars['String']['input']>;
  /** countryCode */
  countryCode?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** The amount of credit limit of the customer. */
  creditLimit?: InputMaybe<Scalars['Float']['input']>;
  /** email */
  email: Scalars['String']['input'];
  /** ID of the Contact model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** name */
  name: Scalars['String']['input'];
  /** The amount of open balance of the customer. */
  openBalance?: InputMaybe<Scalars['Float']['input']>;
  /** phone */
  phone?: InputMaybe<Scalars['String']['input']>;
  /** province */
  province?: InputMaybe<Scalars['String']['input']>;
  /** province_code */
  provinceCode?: InputMaybe<Scalars['String']['input']>;
  /** the reference id of the customer in quickbook */
  quickBookCustomerId?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** zip */
  zip?: InputMaybe<Scalars['String']['input']>;
};

/** contact(Edge) */
export type ContactEdge = {
  __typename?: 'ContactEdge';
  cursor: Scalars['String']['output'];
  node: Contact;
};

export enum ContactOrderFieldEnum {
  Active = 'active',
  Address1 = 'address1',
  Address2 = 'address2',
  AvailableCredit = 'availableCredit',
  City = 'city',
  Company = 'company',
  Country = 'country',
  CountryCode = 'countryCode',
  CreatedAt = 'createdAt',
  CreditLimit = 'creditLimit',
  Email = 'email',
  Name = 'name',
  OpenBalance = 'openBalance',
  Phone = 'phone',
  Province = 'province',
  ProvinceCode = 'provinceCode',
  QuickBookCustomerId = 'quickBookCustomerId',
  UpdatedAt = 'updatedAt',
  Zip = 'zip'
}

export type ContactOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ContactOrderFieldEnum;
};

/** Contact model(Input) */
export type ContactQueryInput = {
  active?: InputMaybe<BoolFilter>;
  address1?: InputMaybe<StringFilter>;
  address2?: InputMaybe<StringFilter>;
  and?: InputMaybe<Array<ContactQueryInput>>;
  availableCredit?: InputMaybe<FloatFilter>;
  city?: InputMaybe<StringFilter>;
  company?: InputMaybe<StringFilter>;
  country?: InputMaybe<StringFilter>;
  countryCode?: InputMaybe<StringFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  creditLimit?: InputMaybe<FloatFilter>;
  email?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<ContactQueryInput>>;
  openBalance?: InputMaybe<FloatFilter>;
  or?: InputMaybe<Array<ContactQueryInput>>;
  phone?: InputMaybe<StringFilter>;
  province?: InputMaybe<StringFilter>;
  provinceCode?: InputMaybe<StringFilter>;
  quickBookCustomerId?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  zip?: InputMaybe<StringFilter>;
};

/** Contact model(UpdateInput) */
export type ContactUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** address1 */
  address1?: InputMaybe<Scalars['String']['input']>;
  /** address2 */
  address2?: InputMaybe<Scalars['String']['input']>;
  /** The amount of credit available to the customer. */
  availableCredit?: InputMaybe<Scalars['Float']['input']>;
  /** city */
  city?: InputMaybe<Scalars['String']['input']>;
  /** company */
  company?: InputMaybe<Scalars['String']['input']>;
  /** country */
  country?: InputMaybe<Scalars['String']['input']>;
  /** countryCode */
  countryCode?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** The amount of credit limit of the customer. */
  creditLimit?: InputMaybe<Scalars['Float']['input']>;
  /** email */
  email?: InputMaybe<Scalars['String']['input']>;
  /** name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** The amount of open balance of the customer. */
  openBalance?: InputMaybe<Scalars['Float']['input']>;
  /** phone */
  phone?: InputMaybe<Scalars['String']['input']>;
  /** province */
  province?: InputMaybe<Scalars['String']['input']>;
  /** province_code */
  provinceCode?: InputMaybe<Scalars['String']['input']>;
  /** the reference id of the customer in quickbook */
  quickBookCustomerId?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** zip */
  zip?: InputMaybe<Scalars['String']['input']>;
};

export type ConvertQuantityInput = {
  fromUOMId: Scalars['ID']['input'];
  quantity: Scalars['Float']['input'];
  toUOMId: Scalars['ID']['input'];
};

export type ConvertQuantityOutput = {
  __typename?: 'ConvertQuantityOutput';
  convertedQuantity?: Maybe<Scalars['Float']['output']>;
};

/** CostPool model */
export type CostPool = {
  __typename?: 'CostPool';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** closedAt */
  closedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** isClosed */
  isClosed?: Maybe<Scalars['Boolean']['output']>;
  /** name */
  name: Scalars['String']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** CostPool model(Connection) */
export type CostPoolConnection = {
  __typename?: 'CostPoolConnection';
  edges: Array<CostPoolEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** CostPool model(CreateInput) */
export type CostPoolCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** closedAt */
  closedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the CostPool model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** isClosed */
  isClosed?: InputMaybe<Scalars['Boolean']['input']>;
  /** name */
  name: Scalars['String']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** costPool(Edge) */
export type CostPoolEdge = {
  __typename?: 'CostPoolEdge';
  cursor: Scalars['String']['output'];
  node: CostPool;
};

/** CostPoolLineItem model */
export type CostPoolLineItem = {
  __typename?: 'CostPoolLineItem';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** allocationBase */
  allocationBase: CostPoolLineItemAllocationBase;
  /** amount */
  amount: Scalars['Float']['output'];
  /** CostPool model. CostPool and this model is n:1. */
  costPool?: Maybe<CostPool>;
  /** costPool ID */
  costPoolID: Scalars['ID']['output'];
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** name */
  name: Scalars['String']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

export enum CostPoolLineItemAllocationBase {
  /** DOLLAR_AMOUNT item */
  DollarAmount = 'DOLLAR_AMOUNT',
  /** VOLUME item */
  Volume = 'VOLUME'
}

export type CostPoolLineItemAllocationBaseEnumFilter = {
  eq?: InputMaybe<CostPoolLineItemAllocationBase>;
  in?: InputMaybe<Array<InputMaybe<CostPoolLineItemAllocationBase>>>;
  ne?: InputMaybe<CostPoolLineItemAllocationBase>;
  nin?: InputMaybe<Array<InputMaybe<CostPoolLineItemAllocationBase>>>;
};

/** CostPoolLineItem model(Connection) */
export type CostPoolLineItemConnection = {
  __typename?: 'CostPoolLineItemConnection';
  edges: Array<CostPoolLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** CostPoolLineItem model(CreateInput) */
export type CostPoolLineItemCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** allocationBase */
  allocationBase: CostPoolLineItemAllocationBase;
  /** amount */
  amount: Scalars['Float']['input'];
  /** costPool ID */
  costPoolID: Scalars['ID']['input'];
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the CostPoolLineItem model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** name */
  name: Scalars['String']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** costPoolLineItem(Edge) */
export type CostPoolLineItemEdge = {
  __typename?: 'CostPoolLineItemEdge';
  cursor: Scalars['String']['output'];
  node: CostPoolLineItem;
};

export enum CostPoolLineItemOrderFieldEnum {
  Active = 'active',
  AllocationBase = 'allocationBase',
  Amount = 'amount',
  CreatedAt = 'createdAt',
  Name = 'name',
  UpdatedAt = 'updatedAt'
}

export type CostPoolLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: CostPoolLineItemOrderFieldEnum;
};

/** CostPoolLineItem model(Input) */
export type CostPoolLineItemQueryInput = {
  active?: InputMaybe<BoolFilter>;
  allocationBase?: InputMaybe<CostPoolLineItemAllocationBaseEnumFilter>;
  amount?: InputMaybe<FloatFilter>;
  and?: InputMaybe<Array<CostPoolLineItemQueryInput>>;
  costPoolID?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<CostPoolLineItemQueryInput>>;
  or?: InputMaybe<Array<CostPoolLineItemQueryInput>>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** CostPoolLineItem model(UpdateInput) */
export type CostPoolLineItemUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** allocationBase */
  allocationBase?: InputMaybe<CostPoolLineItemAllocationBase>;
  /** amount */
  amount?: InputMaybe<Scalars['Float']['input']>;
  /** costPool ID */
  costPoolID?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type CostPoolLineItemsAggregationAvgResult = {
  __typename?: 'CostPoolLineItemsAggregationAvgResult';
  /** amount is aggregation field */
  amount?: Maybe<Scalars['Float']['output']>;
};

export type CostPoolLineItemsAggregationCountResult = {
  __typename?: 'CostPoolLineItemsAggregationCountResult';
  /** allocationBase is aggregation field */
  allocationBase?: Maybe<Scalars['Int']['output']>;
  /** amount is aggregation field */
  amount?: Maybe<Scalars['Int']['output']>;
  /** costPoolID is aggregation field */
  costPoolID?: Maybe<Scalars['Int']['output']>;
  /** name is aggregation field */
  name?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<CostPoolLineItemsAggregationCountToDayFunc>;
  toHour?: Maybe<CostPoolLineItemsAggregationCountToHourFunc>;
  toMinute?: Maybe<CostPoolLineItemsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<CostPoolLineItemsAggregationCountToMonthFunc>;
  toYear?: Maybe<CostPoolLineItemsAggregationCountToYearFunc>;
};

export type CostPoolLineItemsAggregationCountToDayFunc = {
  __typename?: 'CostPoolLineItemsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type CostPoolLineItemsAggregationCountToHourFunc = {
  __typename?: 'CostPoolLineItemsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type CostPoolLineItemsAggregationCountToMinuteFunc = {
  __typename?: 'CostPoolLineItemsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type CostPoolLineItemsAggregationCountToMonthFunc = {
  __typename?: 'CostPoolLineItemsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type CostPoolLineItemsAggregationCountToYearFunc = {
  __typename?: 'CostPoolLineItemsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type CostPoolLineItemsAggregationGroupByResult = {
  __typename?: 'CostPoolLineItemsAggregationGroupByResult';
  /** allocationBase */
  allocationBase?: Maybe<CostPoolLineItemsAllocationBase>;
  /** amount */
  amount?: Maybe<Scalars['Float']['output']>;
  /** costPool ID */
  costPoolID?: Maybe<Scalars['ID']['output']>;
  /** name */
  name?: Maybe<Scalars['String']['output']>;
  toDay?: Maybe<CostPoolLineItemsAggregationGroupByToDayFunc>;
  toHour?: Maybe<CostPoolLineItemsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<CostPoolLineItemsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<CostPoolLineItemsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<CostPoolLineItemsAggregationGroupByToYearFunc>;
};

export type CostPoolLineItemsAggregationGroupByToDayFunc = {
  __typename?: 'CostPoolLineItemsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type CostPoolLineItemsAggregationGroupByToHourFunc = {
  __typename?: 'CostPoolLineItemsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type CostPoolLineItemsAggregationGroupByToMinuteFunc = {
  __typename?: 'CostPoolLineItemsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type CostPoolLineItemsAggregationGroupByToMonthFunc = {
  __typename?: 'CostPoolLineItemsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type CostPoolLineItemsAggregationGroupByToYearFunc = {
  __typename?: 'CostPoolLineItemsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type CostPoolLineItemsAggregationQuantityResult = {
  __typename?: 'CostPoolLineItemsAggregationQuantityResult';
  /** amount is aggregation field */
  amount?: Maybe<Scalars['Float']['output']>;
};

export type CostPoolLineItemsAggregationResult = {
  __typename?: 'CostPoolLineItemsAggregationResult';
  avg?: Maybe<CostPoolLineItemsAggregationAvgResult>;
  count?: Maybe<CostPoolLineItemsAggregationCountResult>;
  groupBy: CostPoolLineItemsAggregationGroupByResult;
  max?: Maybe<CostPoolLineItemsAggregationQuantityResult>;
  min?: Maybe<CostPoolLineItemsAggregationQuantityResult>;
  sum?: Maybe<CostPoolLineItemsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum CostPoolLineItemsAllocationBase {
  DollarAmount = 'DOLLAR_AMOUNT',
  Volume = 'VOLUME'
}

export enum CostPoolOrderFieldEnum {
  Active = 'active',
  ClosedAt = 'closedAt',
  CreatedAt = 'createdAt',
  IsClosed = 'isClosed',
  Name = 'name',
  UpdatedAt = 'updatedAt'
}

export type CostPoolOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: CostPoolOrderFieldEnum;
};

/** CostPool model(Input) */
export type CostPoolQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<CostPoolQueryInput>>;
  closedAt?: InputMaybe<DatetimeFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  isClosed?: InputMaybe<BoolFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<CostPoolQueryInput>>;
  or?: InputMaybe<Array<CostPoolQueryInput>>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** CostPool model(UpdateInput) */
export type CostPoolUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** closedAt */
  closedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** isClosed */
  isClosed?: InputMaybe<Scalars['Boolean']['input']>;
  /** name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type CostPoolsQueryInput = {
  costPoolID?: InputMaybe<UuidFilter>;
};

/** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours. */
export type DailySchedule = {
  __typename?: 'DailySchedule';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Day of the week */
  dayOfWeek: DailyScheduleDayOfWeek;
  /** Duration of the work in hours */
  duration: Scalars['Int']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Work from time. Format: HH:MM */
  workFrom: Scalars['String']['output'];
  /** Work to time. Format: HH:MM */
  workTo: Scalars['String']['output'];
  /** Link to the WorkingHour */
  workingHours?: Maybe<WorkingHour>;
  /** ID of the WorkingHour */
  workingHoursId: Scalars['ID']['output'];
};

/** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Connection) */
export type DailyScheduleConnection = {
  __typename?: 'DailyScheduleConnection';
  edges: Array<DailyScheduleEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(CreateInput) */
export type DailyScheduleCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Day of the week */
  dayOfWeek: DailyScheduleDayOfWeek;
  /** Duration of the work in hours */
  duration: Scalars['Int']['input'];
  /** ID of the Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours. */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work from time. Format: HH:MM */
  workFrom: Scalars['String']['input'];
  /** Work to time. Format: HH:MM */
  workTo: Scalars['String']['input'];
  /** ID of the WorkingHour */
  workingHoursId: Scalars['ID']['input'];
};

export enum DailyScheduleDayOfWeek {
  /** Friday */
  Friday = 'Friday',
  /** Monday */
  Monday = 'Monday',
  /** Saturday */
  Saturday = 'Saturday',
  /** Sunday */
  Sunday = 'Sunday',
  /** Thursday */
  Thursday = 'Thursday',
  /** Tuesday */
  Tuesday = 'Tuesday',
  /** Wednesday */
  Wednesday = 'Wednesday'
}

export type DailyScheduleDayOfWeekEnumFilter = {
  eq?: InputMaybe<DailyScheduleDayOfWeek>;
  in?: InputMaybe<Array<InputMaybe<DailyScheduleDayOfWeek>>>;
  ne?: InputMaybe<DailyScheduleDayOfWeek>;
  nin?: InputMaybe<Array<InputMaybe<DailyScheduleDayOfWeek>>>;
};

/** dailySchedule(Edge) */
export type DailyScheduleEdge = {
  __typename?: 'DailyScheduleEdge';
  cursor: Scalars['String']['output'];
  node: DailySchedule;
};

export enum DailyScheduleOrderFieldEnum {
  CreatedAt = 'createdAt',
  DayOfWeek = 'dayOfWeek',
  Duration = 'duration',
  UpdatedAt = 'updatedAt',
  WorkFrom = 'workFrom',
  WorkTo = 'workTo'
}

export type DailyScheduleOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: DailyScheduleOrderFieldEnum;
};

/** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Input) */
export type DailyScheduleQueryInput = {
  and?: InputMaybe<Array<DailyScheduleQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  dayOfWeek?: InputMaybe<DailyScheduleDayOfWeekEnumFilter>;
  duration?: InputMaybe<IntegerFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<DailyScheduleQueryInput>>;
  or?: InputMaybe<Array<DailyScheduleQueryInput>>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  workFrom?: InputMaybe<StringFilter>;
  workTo?: InputMaybe<StringFilter>;
  workingHoursId?: InputMaybe<UuidFilter>;
};

export type DailyScheduleUniquenessCompositeKey = {
  /** Day of the week */
  dayOfWeek: DailyScheduleDayOfWeek;
  /** Work from time. Format: HH:MM */
  workFrom: Scalars['String']['input'];
  /** Work to time. Format: HH:MM */
  workTo: Scalars['String']['input'];
  /** ID of the WorkingHour */
  workingHoursId: Scalars['ID']['input'];
};

/** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(UpdateInput) */
export type DailyScheduleUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Day of the week */
  dayOfWeek?: InputMaybe<DailyScheduleDayOfWeek>;
  /** Duration of the work in hours */
  duration?: InputMaybe<Scalars['Int']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work from time. Format: HH:MM */
  workFrom?: InputMaybe<Scalars['String']['input']>;
  /** Work to time. Format: HH:MM */
  workTo?: InputMaybe<Scalars['String']['input']>;
  /** ID of the WorkingHour */
  workingHoursId?: InputMaybe<Scalars['ID']['input']>;
};

export type DailySchedulesAggregationAvgResult = {
  __typename?: 'DailySchedulesAggregationAvgResult';
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Float']['output']>;
};

export type DailySchedulesAggregationCountResult = {
  __typename?: 'DailySchedulesAggregationCountResult';
  /** dayOfWeek is aggregation field */
  dayOfWeek?: Maybe<Scalars['Int']['output']>;
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<DailySchedulesAggregationCountToDayFunc>;
  toHour?: Maybe<DailySchedulesAggregationCountToHourFunc>;
  toMinute?: Maybe<DailySchedulesAggregationCountToMinuteFunc>;
  toMonth?: Maybe<DailySchedulesAggregationCountToMonthFunc>;
  toYear?: Maybe<DailySchedulesAggregationCountToYearFunc>;
  /** workFrom is aggregation field */
  workFrom?: Maybe<Scalars['Int']['output']>;
  /** workTo is aggregation field */
  workTo?: Maybe<Scalars['Int']['output']>;
  /** workingHoursId is aggregation field */
  workingHoursId?: Maybe<Scalars['Int']['output']>;
};

export type DailySchedulesAggregationCountToDayFunc = {
  __typename?: 'DailySchedulesAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type DailySchedulesAggregationCountToHourFunc = {
  __typename?: 'DailySchedulesAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type DailySchedulesAggregationCountToMinuteFunc = {
  __typename?: 'DailySchedulesAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type DailySchedulesAggregationCountToMonthFunc = {
  __typename?: 'DailySchedulesAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type DailySchedulesAggregationCountToYearFunc = {
  __typename?: 'DailySchedulesAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type DailySchedulesAggregationGroupByResult = {
  __typename?: 'DailySchedulesAggregationGroupByResult';
  /** Day of the week */
  dayOfWeek?: Maybe<DailySchedulesDayOfWeek>;
  /** Duration of the work in hours */
  duration?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<DailySchedulesAggregationGroupByToDayFunc>;
  toHour?: Maybe<DailySchedulesAggregationGroupByToHourFunc>;
  toMinute?: Maybe<DailySchedulesAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<DailySchedulesAggregationGroupByToMonthFunc>;
  toYear?: Maybe<DailySchedulesAggregationGroupByToYearFunc>;
  /** Work from time. Format: HH:MM */
  workFrom?: Maybe<Scalars['String']['output']>;
  /** Work to time. Format: HH:MM */
  workTo?: Maybe<Scalars['String']['output']>;
  /** ID of the WorkingHour */
  workingHoursId?: Maybe<Scalars['ID']['output']>;
};

export type DailySchedulesAggregationGroupByToDayFunc = {
  __typename?: 'DailySchedulesAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type DailySchedulesAggregationGroupByToHourFunc = {
  __typename?: 'DailySchedulesAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type DailySchedulesAggregationGroupByToMinuteFunc = {
  __typename?: 'DailySchedulesAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type DailySchedulesAggregationGroupByToMonthFunc = {
  __typename?: 'DailySchedulesAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type DailySchedulesAggregationGroupByToYearFunc = {
  __typename?: 'DailySchedulesAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type DailySchedulesAggregationQuantityResult = {
  __typename?: 'DailySchedulesAggregationQuantityResult';
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Int']['output']>;
};

export type DailySchedulesAggregationResult = {
  __typename?: 'DailySchedulesAggregationResult';
  avg?: Maybe<DailySchedulesAggregationAvgResult>;
  count?: Maybe<DailySchedulesAggregationCountResult>;
  groupBy: DailySchedulesAggregationGroupByResult;
  max?: Maybe<DailySchedulesAggregationQuantityResult>;
  min?: Maybe<DailySchedulesAggregationQuantityResult>;
  sum?: Maybe<DailySchedulesAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum DailySchedulesDayOfWeek {
  Friday = 'Friday',
  Monday = 'Monday',
  Saturday = 'Saturday',
  Sunday = 'Sunday',
  Thursday = 'Thursday',
  Tuesday = 'Tuesday',
  Wednesday = 'Wednesday'
}

export type DateBetweenFilter = {
  max?: InputMaybe<Scalars['Date']['input']>;
  min?: InputMaybe<Scalars['Date']['input']>;
};

export type DateFilter = {
  between?: InputMaybe<DateBetweenFilter>;
  eq?: InputMaybe<Scalars['Date']['input']>;
  gt?: InputMaybe<Scalars['Date']['input']>;
  gte?: InputMaybe<Scalars['Date']['input']>;
  in?: InputMaybe<Array<InputMaybe<Scalars['Date']['input']>>>;
  lt?: InputMaybe<Scalars['Date']['input']>;
  lte?: InputMaybe<Scalars['Date']['input']>;
  ne?: InputMaybe<Scalars['Date']['input']>;
  nin?: InputMaybe<Array<InputMaybe<Scalars['Date']['input']>>>;
};

export type DatetimeBetweenFilter = {
  max?: InputMaybe<Scalars['DateTime']['input']>;
  min?: InputMaybe<Scalars['DateTime']['input']>;
};

export type DatetimeFilter = {
  between?: InputMaybe<DatetimeBetweenFilter>;
  eq?: InputMaybe<Scalars['DateTime']['input']>;
  gt?: InputMaybe<Scalars['DateTime']['input']>;
  gte?: InputMaybe<Scalars['DateTime']['input']>;
  in?: InputMaybe<Array<InputMaybe<Scalars['DateTime']['input']>>>;
  lt?: InputMaybe<Scalars['DateTime']['input']>;
  lte?: InputMaybe<Scalars['DateTime']['input']>;
  ne?: InputMaybe<Scalars['DateTime']['input']>;
  nin?: InputMaybe<Array<InputMaybe<Scalars['DateTime']['input']>>>;
};

/** Basic Employee details */
export type Employee = {
  __typename?: 'Employee';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Is the employee active? */
  isActive?: Maybe<Scalars['Boolean']['output']>;
  /** Name of the Employee */
  name?: Maybe<Scalars['String']['output']>;
  /** Role of the Employee */
  role?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Basic Employee details(Connection) */
export type EmployeeConnection = {
  __typename?: 'EmployeeConnection';
  edges: Array<EmployeeEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Basic Employee details(CreateInput) */
export type EmployeeCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Basic Employee details */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Is the employee active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Name of the Employee */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Role of the Employee */
  role?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** employee(Edge) */
export type EmployeeEdge = {
  __typename?: 'EmployeeEdge';
  cursor: Scalars['String']['output'];
  node: Employee;
};

export enum EmployeeOrderFieldEnum {
  CreatedAt = 'createdAt',
  IsActive = 'isActive',
  Name = 'name',
  Role = 'role',
  UpdatedAt = 'updatedAt'
}

export type EmployeeOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: EmployeeOrderFieldEnum;
};

/** Basic Employee details(Input) */
export type EmployeeQueryInput = {
  and?: InputMaybe<Array<EmployeeQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  isActive?: InputMaybe<BoolFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<EmployeeQueryInput>>;
  or?: InputMaybe<Array<EmployeeQueryInput>>;
  role?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Basic Employee details(UpdateInput) */
export type EmployeeUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Is the employee active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Name of the Employee */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Role of the Employee */
  role?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type EmployeesAggregationCountResult = {
  __typename?: 'EmployeesAggregationCountResult';
  /** name is aggregation field */
  name?: Maybe<Scalars['Int']['output']>;
  /** role is aggregation field */
  role?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<EmployeesAggregationCountToDayFunc>;
  toHour?: Maybe<EmployeesAggregationCountToHourFunc>;
  toMinute?: Maybe<EmployeesAggregationCountToMinuteFunc>;
  toMonth?: Maybe<EmployeesAggregationCountToMonthFunc>;
  toYear?: Maybe<EmployeesAggregationCountToYearFunc>;
};

export type EmployeesAggregationCountToDayFunc = {
  __typename?: 'EmployeesAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type EmployeesAggregationCountToHourFunc = {
  __typename?: 'EmployeesAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type EmployeesAggregationCountToMinuteFunc = {
  __typename?: 'EmployeesAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type EmployeesAggregationCountToMonthFunc = {
  __typename?: 'EmployeesAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type EmployeesAggregationCountToYearFunc = {
  __typename?: 'EmployeesAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type EmployeesAggregationGroupByResult = {
  __typename?: 'EmployeesAggregationGroupByResult';
  /** Name of the Employee */
  name?: Maybe<Scalars['String']['output']>;
  /** Role of the Employee */
  role?: Maybe<Scalars['String']['output']>;
  toDay?: Maybe<EmployeesAggregationGroupByToDayFunc>;
  toHour?: Maybe<EmployeesAggregationGroupByToHourFunc>;
  toMinute?: Maybe<EmployeesAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<EmployeesAggregationGroupByToMonthFunc>;
  toYear?: Maybe<EmployeesAggregationGroupByToYearFunc>;
};

export type EmployeesAggregationGroupByToDayFunc = {
  __typename?: 'EmployeesAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type EmployeesAggregationGroupByToHourFunc = {
  __typename?: 'EmployeesAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type EmployeesAggregationGroupByToMinuteFunc = {
  __typename?: 'EmployeesAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type EmployeesAggregationGroupByToMonthFunc = {
  __typename?: 'EmployeesAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type EmployeesAggregationGroupByToYearFunc = {
  __typename?: 'EmployeesAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type EmployeesAggregationResult = {
  __typename?: 'EmployeesAggregationResult';
  count?: Maybe<EmployeesAggregationCountResult>;
  groupBy: EmployeesAggregationGroupByResult;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

/** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore. */
export type FinancialStockEvent = {
  __typename?: 'FinancialStockEvent';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** Available for sale quantity. */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** The quantity of the product in stock. */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** incrementalQuantity */
  incrementalQuantity: Scalars['Float']['output'];
  /** isOnHold */
  isOnHold: Scalars['Boolean']['output'];
  /** Quantity of the product that is on hold. */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  /** OperationalStockEvent model. OperationalStockEvent and this model is n:1. One stock event is only related o either one receipt or shipment. */
  operationalStockEvent?: Maybe<OperationalStockEvent>;
  /** OperationalStockEvent where the StockEvents come from */
  operationalStockEventID: Scalars['ID']['output'];
  /** ReceiptLineItem model. ReceiptLineItem and this model is 1:1. One stock event is only related o either one receipt or shipment */
  receiptLineItem?: Maybe<ReceiptLineItem>;
  /** ReceiptLineItem where the StockEvent come from */
  receiptLineItemID?: Maybe<Scalars['ID']['output']>;
  /** ShipmentLineItem model. ShipmentLineItem and this model is 1:1. One stock event is only related o either one receipt or shipment. */
  shipmentLineItem?: Maybe<ShipmentLineItem>;
  /** Shipment where the StockEvents come from */
  shipmentLineItemID?: Maybe<Scalars['ID']['output']>;
  /** totalCost */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /** transactionTotalCost */
  transactionTotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost */
  unitCost: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

/** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(Connection) */
export type FinancialStockEventConnection = {
  __typename?: 'FinancialStockEventConnection';
  edges: Array<FinancialStockEventEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(CreateInput) */
export type FinancialStockEventCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Available for sale quantity. */
  availableQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore. */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** incrementalQuantity */
  incrementalQuantity: Scalars['Float']['input'];
  /** isOnHold */
  isOnHold: Scalars['Boolean']['input'];
  /** Quantity of the product that is on hold. */
  onHoldQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** OperationalStockEvent where the StockEvents come from */
  operationalStockEventID: Scalars['ID']['input'];
  /** ReceiptLineItem where the StockEvent come from */
  receiptLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** Shipment where the StockEvents come from */
  shipmentLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** totalCost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** transactionTotalCost */
  transactionTotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCost */
  unitCost: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

/** financialStockEvent(Edge) */
export type FinancialStockEventEdge = {
  __typename?: 'FinancialStockEventEdge';
  cursor: Scalars['String']['output'];
  node: FinancialStockEvent;
};

export enum FinancialStockEventOrderFieldEnum {
  Active = 'active',
  AvailableQuantity = 'availableQuantity',
  AverageCost = 'averageCost',
  CreatedAt = 'createdAt',
  InStockQuantity = 'inStockQuantity',
  IncrementalQuantity = 'incrementalQuantity',
  IsOnHold = 'isOnHold',
  OnHoldQuantity = 'onHoldQuantity',
  TotalCost = 'totalCost',
  TransactionTotalCost = 'transactionTotalCost',
  UnitCost = 'unitCost',
  UpdatedAt = 'updatedAt'
}

export type FinancialStockEventOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: FinancialStockEventOrderFieldEnum;
};

/** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(Input) */
export type FinancialStockEventQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<FinancialStockEventQueryInput>>;
  availableQuantity?: InputMaybe<FloatFilter>;
  averageCost?: InputMaybe<FloatFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  inStockQuantity?: InputMaybe<FloatFilter>;
  incrementalQuantity?: InputMaybe<FloatFilter>;
  isOnHold?: InputMaybe<BoolFilter>;
  not?: InputMaybe<Array<FinancialStockEventQueryInput>>;
  onHoldQuantity?: InputMaybe<FloatFilter>;
  operationalStockEventID?: InputMaybe<UuidFilter>;
  or?: InputMaybe<Array<FinancialStockEventQueryInput>>;
  receiptLineItemID?: InputMaybe<UuidFilter>;
  shipmentLineItemID?: InputMaybe<UuidFilter>;
  totalCost?: InputMaybe<FloatFilter>;
  transactionTotalCost?: InputMaybe<FloatFilter>;
  unitCost?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

/** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(UpdateInput) */
export type FinancialStockEventUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Available for sale quantity. */
  availableQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** incrementalQuantity */
  incrementalQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** isOnHold */
  isOnHold?: InputMaybe<Scalars['Boolean']['input']>;
  /** Quantity of the product that is on hold. */
  onHoldQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** OperationalStockEvent where the StockEvents come from */
  operationalStockEventID?: InputMaybe<Scalars['ID']['input']>;
  /** ReceiptLineItem where the StockEvent come from */
  receiptLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** Shipment where the StockEvents come from */
  shipmentLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** totalCost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** transactionTotalCost */
  transactionTotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCost */
  unitCost?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type FinancialStockSummariesAggregationAvgResult = {
  __typename?: 'FinancialStockSummariesAggregationAvgResult';
  /** availableQuantity is aggregation field */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** averageCost is aggregation field */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /** inStockQuantity is aggregation field */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** onHoldQuantity is aggregation field */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Float']['output']>;
};

export type FinancialStockSummariesAggregationCountResult = {
  __typename?: 'FinancialStockSummariesAggregationCountResult';
  /** availableQuantity is aggregation field */
  availableQuantity?: Maybe<Scalars['Int']['output']>;
  /** averageCost is aggregation field */
  averageCost?: Maybe<Scalars['Int']['output']>;
  /** inStockQuantity is aggregation field */
  inStockQuantity?: Maybe<Scalars['Int']['output']>;
  /** onHoldQuantity is aggregation field */
  onHoldQuantity?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<FinancialStockSummariesAggregationCountToDayFunc>;
  toHour?: Maybe<FinancialStockSummariesAggregationCountToHourFunc>;
  toMinute?: Maybe<FinancialStockSummariesAggregationCountToMinuteFunc>;
  toMonth?: Maybe<FinancialStockSummariesAggregationCountToMonthFunc>;
  toYear?: Maybe<FinancialStockSummariesAggregationCountToYearFunc>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Int']['output']>;
  /** variantID is aggregation field */
  variantID?: Maybe<Scalars['Int']['output']>;
};

export type FinancialStockSummariesAggregationCountToDayFunc = {
  __typename?: 'FinancialStockSummariesAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type FinancialStockSummariesAggregationCountToHourFunc = {
  __typename?: 'FinancialStockSummariesAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type FinancialStockSummariesAggregationCountToMinuteFunc = {
  __typename?: 'FinancialStockSummariesAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type FinancialStockSummariesAggregationCountToMonthFunc = {
  __typename?: 'FinancialStockSummariesAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type FinancialStockSummariesAggregationCountToYearFunc = {
  __typename?: 'FinancialStockSummariesAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type FinancialStockSummariesAggregationGroupByResult = {
  __typename?: 'FinancialStockSummariesAggregationGroupByResult';
  /** availableQuantity */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** averageCost */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** onHoldQuantity */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  toDay?: Maybe<FinancialStockSummariesAggregationGroupByToDayFunc>;
  toHour?: Maybe<FinancialStockSummariesAggregationGroupByToHourFunc>;
  toMinute?: Maybe<FinancialStockSummariesAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<FinancialStockSummariesAggregationGroupByToMonthFunc>;
  toYear?: Maybe<FinancialStockSummariesAggregationGroupByToYearFunc>;
  /** totalCost */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

export type FinancialStockSummariesAggregationGroupByToDayFunc = {
  __typename?: 'FinancialStockSummariesAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type FinancialStockSummariesAggregationGroupByToHourFunc = {
  __typename?: 'FinancialStockSummariesAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type FinancialStockSummariesAggregationGroupByToMinuteFunc = {
  __typename?: 'FinancialStockSummariesAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type FinancialStockSummariesAggregationGroupByToMonthFunc = {
  __typename?: 'FinancialStockSummariesAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type FinancialStockSummariesAggregationGroupByToYearFunc = {
  __typename?: 'FinancialStockSummariesAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type FinancialStockSummariesAggregationQuantityResult = {
  __typename?: 'FinancialStockSummariesAggregationQuantityResult';
  /** availableQuantity is aggregation field */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** averageCost is aggregation field */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /** inStockQuantity is aggregation field */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** onHoldQuantity is aggregation field */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Float']['output']>;
};

export type FinancialStockSummariesAggregationResult = {
  __typename?: 'FinancialStockSummariesAggregationResult';
  avg?: Maybe<FinancialStockSummariesAggregationAvgResult>;
  count?: Maybe<FinancialStockSummariesAggregationCountResult>;
  groupBy: FinancialStockSummariesAggregationGroupByResult;
  max?: Maybe<FinancialStockSummariesAggregationQuantityResult>;
  min?: Maybe<FinancialStockSummariesAggregationQuantityResult>;
  sum?: Maybe<FinancialStockSummariesAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

/** StockSummary model for the financial ledger */
export type FinancialStockSummary = {
  __typename?: 'FinancialStockSummary';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** availableQuantity */
  availableQuantity: Scalars['Float']['output'];
  /** averageCost */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** onHoldQuantity */
  onHoldQuantity: Scalars['Float']['output'];
  /** totalCost */
  totalCost: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID: Scalars['ID']['output'];
};

/** StockSummary model for the financial ledger(Connection) */
export type FinancialStockSummaryConnection = {
  __typename?: 'FinancialStockSummaryConnection';
  edges: Array<FinancialStockSummaryEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** StockSummary model for the financial ledger(CreateInput) */
export type FinancialStockSummaryCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** availableQuantity */
  availableQuantity: Scalars['Float']['input'];
  /** averageCost */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the StockSummary model for the financial ledger */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** onHoldQuantity */
  onHoldQuantity: Scalars['Float']['input'];
  /** totalCost */
  totalCost: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID: Scalars['ID']['input'];
};

/** financialStockSummary(Edge) */
export type FinancialStockSummaryEdge = {
  __typename?: 'FinancialStockSummaryEdge';
  cursor: Scalars['String']['output'];
  node: FinancialStockSummary;
};

export enum FinancialStockSummaryOrderFieldEnum {
  Active = 'active',
  AvailableQuantity = 'availableQuantity',
  AverageCost = 'averageCost',
  CreatedAt = 'createdAt',
  InStockQuantity = 'inStockQuantity',
  OnHoldQuantity = 'onHoldQuantity',
  TotalCost = 'totalCost',
  UpdatedAt = 'updatedAt'
}

export type FinancialStockSummaryOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: FinancialStockSummaryOrderFieldEnum;
};

/** StockSummary model for the financial ledger(Input) */
export type FinancialStockSummaryQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<FinancialStockSummaryQueryInput>>;
  availableQuantity?: InputMaybe<FloatFilter>;
  averageCost?: InputMaybe<FloatFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  inStockQuantity?: InputMaybe<FloatFilter>;
  not?: InputMaybe<Array<FinancialStockSummaryQueryInput>>;
  onHoldQuantity?: InputMaybe<FloatFilter>;
  or?: InputMaybe<Array<FinancialStockSummaryQueryInput>>;
  totalCost?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

/** StockSummary model for the financial ledger(UpdateInput) */
export type FinancialStockSummaryUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** availableQuantity */
  availableQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** averageCost */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** onHoldQuantity */
  onHoldQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** totalCost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type FloatFilter = {
  between?: InputMaybe<FloatFilterBetweenFilter>;
  eq?: InputMaybe<Scalars['Float']['input']>;
  gt?: InputMaybe<Scalars['Float']['input']>;
  gte?: InputMaybe<Scalars['Float']['input']>;
  in?: InputMaybe<Array<InputMaybe<Scalars['Float']['input']>>>;
  lt?: InputMaybe<Scalars['Float']['input']>;
  lte?: InputMaybe<Scalars['Float']['input']>;
  ne?: InputMaybe<Scalars['Float']['input']>;
  nin?: InputMaybe<Array<InputMaybe<Scalars['Float']['input']>>>;
};

export type FloatFilterBetweenFilter = {
  max?: InputMaybe<Scalars['Float']['input']>;
  min?: InputMaybe<Scalars['Float']['input']>;
};

export type IntegerBetweenFilter = {
  max?: InputMaybe<Scalars['Int']['input']>;
  min?: InputMaybe<Scalars['Int']['input']>;
};

export type IntegerFilter = {
  between?: InputMaybe<IntegerBetweenFilter>;
  eq?: InputMaybe<Scalars['Int']['input']>;
  gt?: InputMaybe<Scalars['Int']['input']>;
  gte?: InputMaybe<Scalars['Int']['input']>;
  in?: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
  lt?: InputMaybe<Scalars['Int']['input']>;
  lte?: InputMaybe<Scalars['Int']['input']>;
  ne?: InputMaybe<Scalars['Int']['input']>;
  nin?: InputMaybe<Array<InputMaybe<Scalars['Int']['input']>>>;
};

/** Product variant's inventory item model */
export type InventoryItem = {
  __typename?: 'InventoryItem';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Product variant */
  productVariant?: Maybe<ProductVariant>;
  /** Product variant ID */
  productVariantID?: Maybe<Scalars['ID']['output']>;
  /** Shopify product ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Product variant's inventory item model(Connection) */
export type InventoryItemConnection = {
  __typename?: 'InventoryItemConnection';
  edges: Array<InventoryItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Product variant's inventory item model(CreateInput) */
export type InventoryItemCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Product variant's inventory item model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Product variant ID */
  productVariantID?: InputMaybe<Scalars['ID']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** inventoryItem(Edge) */
export type InventoryItemEdge = {
  __typename?: 'InventoryItemEdge';
  cursor: Scalars['String']['output'];
  node: InventoryItem;
};

export enum InventoryItemOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  ShopifyId = 'shopifyID',
  UpdatedAt = 'updatedAt'
}

export type InventoryItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: InventoryItemOrderFieldEnum;
};

/** Product variant's inventory item model(Input) */
export type InventoryItemQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<InventoryItemQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<InventoryItemQueryInput>>;
  or?: InputMaybe<Array<InventoryItemQueryInput>>;
  productVariantID?: InputMaybe<UuidFilter>;
  shopifyID?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Product variant's inventory item model(UpdateInput) */
export type InventoryItemUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Product variant ID */
  productVariantID?: InputMaybe<Scalars['ID']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** Inventory Level of an inventory item */
export type InventoryLevel = {
  __typename?: 'InventoryLevel';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** Amount of the inventory item available */
  available?: Maybe<Scalars['Int']['output']>;
  /** Amount of the inventory item reserved */
  committed?: Maybe<Scalars['Int']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Amount of the inventory item damaged */
  damaged?: Maybe<Scalars['Int']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Amount of the inventory item incoming */
  incoming?: Maybe<Scalars['Int']['output']>;
  /** Inventory Item */
  inventoryItem?: Maybe<InventoryItem>;
  /** Inventory Item ID */
  inventoryItemID?: Maybe<Scalars['ID']['output']>;
  /** Inventory Location */
  location?: Maybe<Location>;
  /** Inventory Location ID */
  locationID?: Maybe<Scalars['ID']['output']>;
  /** Amount of the inventory item on hand */
  onHand?: Maybe<Scalars['Int']['output']>;
  /** Amount of the inventory item in quality control */
  qualityControl?: Maybe<Scalars['Int']['output']>;
  /** Amount of the inventory item reserved */
  reserved?: Maybe<Scalars['Int']['output']>;
  /** Amount of the inventory item safety stock */
  safetyStock?: Maybe<Scalars['Int']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Inventory Level of an inventory item(Connection) */
export type InventoryLevelConnection = {
  __typename?: 'InventoryLevelConnection';
  edges: Array<InventoryLevelEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Inventory Level of an inventory item(CreateInput) */
export type InventoryLevelCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Amount of the inventory item available */
  available?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item reserved */
  committed?: InputMaybe<Scalars['Int']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Amount of the inventory item damaged */
  damaged?: InputMaybe<Scalars['Int']['input']>;
  /** ID of the Inventory Level of an inventory item */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Amount of the inventory item incoming */
  incoming?: InputMaybe<Scalars['Int']['input']>;
  /** Inventory Item ID */
  inventoryItemID?: InputMaybe<Scalars['ID']['input']>;
  /** Inventory Location ID */
  locationID?: InputMaybe<Scalars['ID']['input']>;
  /** Amount of the inventory item on hand */
  onHand?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item in quality control */
  qualityControl?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item reserved */
  reserved?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item safety stock */
  safetyStock?: InputMaybe<Scalars['Int']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** inventoryLevel(Edge) */
export type InventoryLevelEdge = {
  __typename?: 'InventoryLevelEdge';
  cursor: Scalars['String']['output'];
  node: InventoryLevel;
};

export enum InventoryLevelOrderFieldEnum {
  Active = 'active',
  Available = 'available',
  Committed = 'committed',
  CreatedAt = 'createdAt',
  Damaged = 'damaged',
  Incoming = 'incoming',
  OnHand = 'onHand',
  QualityControl = 'qualityControl',
  Reserved = 'reserved',
  SafetyStock = 'safetyStock',
  UpdatedAt = 'updatedAt'
}

export type InventoryLevelOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: InventoryLevelOrderFieldEnum;
};

/** Inventory Level of an inventory item(Input) */
export type InventoryLevelQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<InventoryLevelQueryInput>>;
  available?: InputMaybe<IntegerFilter>;
  committed?: InputMaybe<IntegerFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  damaged?: InputMaybe<IntegerFilter>;
  id?: InputMaybe<UuidFilter>;
  incoming?: InputMaybe<IntegerFilter>;
  inventoryItemID?: InputMaybe<UuidFilter>;
  locationID?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<InventoryLevelQueryInput>>;
  onHand?: InputMaybe<IntegerFilter>;
  or?: InputMaybe<Array<InventoryLevelQueryInput>>;
  qualityControl?: InputMaybe<IntegerFilter>;
  reserved?: InputMaybe<IntegerFilter>;
  safetyStock?: InputMaybe<IntegerFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Inventory Level of an inventory item(UpdateInput) */
export type InventoryLevelUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Amount of the inventory item available */
  available?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item reserved */
  committed?: InputMaybe<Scalars['Int']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Amount of the inventory item damaged */
  damaged?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item incoming */
  incoming?: InputMaybe<Scalars['Int']['input']>;
  /** Inventory Item ID */
  inventoryItemID?: InputMaybe<Scalars['ID']['input']>;
  /** Inventory Location ID */
  locationID?: InputMaybe<Scalars['ID']['input']>;
  /** Amount of the inventory item on hand */
  onHand?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item in quality control */
  qualityControl?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item reserved */
  reserved?: InputMaybe<Scalars['Int']['input']>;
  /** Amount of the inventory item safety stock */
  safetyStock?: InputMaybe<Scalars['Int']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** Invoice model */
export type Invoice = {
  __typename?: 'Invoice';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Customer contact */
  customer?: Maybe<Contact>;
  /** Contact model. Contact and this model is n:1 */
  customerID?: Maybe<Scalars['ID']['output']>;
  /** date */
  date?: Maybe<Scalars['DateTime']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Invoice number */
  invoiceNumber?: Maybe<Scalars['String']['output']>;
  /** inventoryType */
  invoiceStatus?: Maybe<InvoiceInvoiceStatus>;
  /** Date when the invoice was pushed to QuickBooks */
  pushedToQBAt?: Maybe<Scalars['DateTime']['output']>;
  /** Quickbook invoice ID */
  quickbookInvoiceId?: Maybe<Scalars['String']['output']>;
  /** Shipment model. (Origin of the invoice) Shipment and this model is n:1. */
  shipment?: Maybe<Shipment>;
  /** Shipment ID (Origin of the invoice) */
  shipmentID?: Maybe<Scalars['ID']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Invoice model(Connection) */
export type InvoiceConnection = {
  __typename?: 'InvoiceConnection';
  edges: Array<InvoiceEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Invoice model(CreateInput) */
export type InvoiceCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Contact model. Contact and this model is n:1 */
  customerID?: InputMaybe<Scalars['ID']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Invoice model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Invoice number */
  invoiceNumber?: InputMaybe<Scalars['String']['input']>;
  /** inventoryType */
  invoiceStatus?: InputMaybe<InvoiceInvoiceStatus>;
  /** Date when the invoice was pushed to QuickBooks */
  pushedToQBAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Quickbook invoice ID */
  quickbookInvoiceId?: InputMaybe<Scalars['String']['input']>;
  /** Shipment ID (Origin of the invoice) */
  shipmentID?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** invoice(Edge) */
export type InvoiceEdge = {
  __typename?: 'InvoiceEdge';
  cursor: Scalars['String']['output'];
  node: Invoice;
};

export enum InvoiceInvoiceStatus {
  /** CANNOT BE EDITED. CLOSED State, meaning it has been closed */
  Closed = 'CLOSED',
  /** DRAFT State, meaning it can be updated */
  Draft = 'DRAFT',
  /** CANNOT BE EDITED. Pushed To QB State, meaning it has been pushed to QuickBooks */
  Pushedtoqb = 'PUSHEDTOQB'
}

export type InvoiceInvoiceStatusEnumFilter = {
  eq?: InputMaybe<InvoiceInvoiceStatus>;
  in?: InputMaybe<Array<InputMaybe<InvoiceInvoiceStatus>>>;
  ne?: InputMaybe<InvoiceInvoiceStatus>;
  nin?: InputMaybe<Array<InputMaybe<InvoiceInvoiceStatus>>>;
};

/** InvoiceLineItem model */
export type InvoiceLineItem = {
  __typename?: 'InvoiceLineItem';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Invoice model. Invoice and this model is n:1. */
  invoice?: Maybe<Invoice>;
  /** Invoice ID */
  invoiceID: Scalars['ID']['output'];
  /** quantity */
  quantity: Scalars['Float']['output'];
  /** taxable */
  taxable?: Maybe<Scalars['Boolean']['output']>;
  /** unit cost */
  unitPrice: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

/** InvoiceLineItem model(Connection) */
export type InvoiceLineItemConnection = {
  __typename?: 'InvoiceLineItemConnection';
  edges: Array<InvoiceLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** InvoiceLineItem model(CreateInput) */
export type InvoiceLineItemCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the InvoiceLineItem model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Invoice ID */
  invoiceID: Scalars['ID']['input'];
  /** quantity */
  quantity: Scalars['Float']['input'];
  /** taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** unit cost */
  unitPrice: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

/** invoiceLineItem(Edge) */
export type InvoiceLineItemEdge = {
  __typename?: 'InvoiceLineItemEdge';
  cursor: Scalars['String']['output'];
  node: InvoiceLineItem;
};

export enum InvoiceLineItemOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Quantity = 'quantity',
  Taxable = 'taxable',
  UnitPrice = 'unitPrice',
  UpdatedAt = 'updatedAt'
}

export type InvoiceLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: InvoiceLineItemOrderFieldEnum;
};

/** InvoiceLineItem model(Input) */
export type InvoiceLineItemQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<InvoiceLineItemQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  invoiceID?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<InvoiceLineItemQueryInput>>;
  or?: InputMaybe<Array<InvoiceLineItemQueryInput>>;
  quantity?: InputMaybe<FloatFilter>;
  taxable?: InputMaybe<BoolFilter>;
  unitPrice?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

/** InvoiceLineItem model(UpdateInput) */
export type InvoiceLineItemUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Invoice ID */
  invoiceID?: InputMaybe<Scalars['ID']['input']>;
  /** quantity */
  quantity?: InputMaybe<Scalars['Float']['input']>;
  /** taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** unit cost */
  unitPrice?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type InvoiceLineItemsAggregationAvgResult = {
  __typename?: 'InvoiceLineItemsAggregationAvgResult';
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Float']['output']>;
};

export type InvoiceLineItemsAggregationCountResult = {
  __typename?: 'InvoiceLineItemsAggregationCountResult';
  /** invoiceID is aggregation field */
  invoiceID?: Maybe<Scalars['Int']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<InvoiceLineItemsAggregationCountToDayFunc>;
  toHour?: Maybe<InvoiceLineItemsAggregationCountToHourFunc>;
  toMinute?: Maybe<InvoiceLineItemsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<InvoiceLineItemsAggregationCountToMonthFunc>;
  toYear?: Maybe<InvoiceLineItemsAggregationCountToYearFunc>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Int']['output']>;
  /** variantID is aggregation field */
  variantID?: Maybe<Scalars['Int']['output']>;
};

export type InvoiceLineItemsAggregationCountToDayFunc = {
  __typename?: 'InvoiceLineItemsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type InvoiceLineItemsAggregationCountToHourFunc = {
  __typename?: 'InvoiceLineItemsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type InvoiceLineItemsAggregationCountToMinuteFunc = {
  __typename?: 'InvoiceLineItemsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type InvoiceLineItemsAggregationCountToMonthFunc = {
  __typename?: 'InvoiceLineItemsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type InvoiceLineItemsAggregationCountToYearFunc = {
  __typename?: 'InvoiceLineItemsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type InvoiceLineItemsAggregationGroupByResult = {
  __typename?: 'InvoiceLineItemsAggregationGroupByResult';
  /** Invoice ID */
  invoiceID?: Maybe<Scalars['ID']['output']>;
  /** quantity */
  quantity?: Maybe<Scalars['Float']['output']>;
  toDay?: Maybe<InvoiceLineItemsAggregationGroupByToDayFunc>;
  toHour?: Maybe<InvoiceLineItemsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<InvoiceLineItemsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<InvoiceLineItemsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<InvoiceLineItemsAggregationGroupByToYearFunc>;
  /** unit cost */
  unitPrice?: Maybe<Scalars['Float']['output']>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

export type InvoiceLineItemsAggregationGroupByToDayFunc = {
  __typename?: 'InvoiceLineItemsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type InvoiceLineItemsAggregationGroupByToHourFunc = {
  __typename?: 'InvoiceLineItemsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type InvoiceLineItemsAggregationGroupByToMinuteFunc = {
  __typename?: 'InvoiceLineItemsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type InvoiceLineItemsAggregationGroupByToMonthFunc = {
  __typename?: 'InvoiceLineItemsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type InvoiceLineItemsAggregationGroupByToYearFunc = {
  __typename?: 'InvoiceLineItemsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type InvoiceLineItemsAggregationQuantityResult = {
  __typename?: 'InvoiceLineItemsAggregationQuantityResult';
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Float']['output']>;
};

export type InvoiceLineItemsAggregationResult = {
  __typename?: 'InvoiceLineItemsAggregationResult';
  avg?: Maybe<InvoiceLineItemsAggregationAvgResult>;
  count?: Maybe<InvoiceLineItemsAggregationCountResult>;
  groupBy: InvoiceLineItemsAggregationGroupByResult;
  max?: Maybe<InvoiceLineItemsAggregationQuantityResult>;
  min?: Maybe<InvoiceLineItemsAggregationQuantityResult>;
  sum?: Maybe<InvoiceLineItemsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum InvoiceOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Date = 'date',
  InvoiceNumber = 'invoiceNumber',
  InvoiceStatus = 'invoiceStatus',
  PushedToQbAt = 'pushedToQBAt',
  QuickbookInvoiceId = 'quickbookInvoiceId',
  UpdatedAt = 'updatedAt'
}

export type InvoiceOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: InvoiceOrderFieldEnum;
};

/** Invoice model(Input) */
export type InvoiceQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<InvoiceQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  customerID?: InputMaybe<UuidFilter>;
  date?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  invoiceNumber?: InputMaybe<StringFilter>;
  invoiceStatus?: InputMaybe<InvoiceInvoiceStatusEnumFilter>;
  not?: InputMaybe<Array<InvoiceQueryInput>>;
  or?: InputMaybe<Array<InvoiceQueryInput>>;
  pushedToQBAt?: InputMaybe<DatetimeFilter>;
  quickbookInvoiceId?: InputMaybe<StringFilter>;
  shipmentID?: InputMaybe<UuidFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Invoice model(UpdateInput) */
export type InvoiceUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Contact model. Contact and this model is n:1 */
  customerID?: InputMaybe<Scalars['ID']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** Invoice number */
  invoiceNumber?: InputMaybe<Scalars['String']['input']>;
  /** inventoryType */
  invoiceStatus?: InputMaybe<InvoiceInvoiceStatus>;
  /** Date when the invoice was pushed to QuickBooks */
  pushedToQBAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Quickbook invoice ID */
  quickbookInvoiceId?: InputMaybe<Scalars['String']['input']>;
  /** Shipment ID (Origin of the invoice) */
  shipmentID?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** Item description */
export type Item = {
  __typename?: 'Item';
  /** Link to the BOM */
  bom?: Maybe<Bom>;
  /** ID of the BOM that is currently being used for this item */
  bomId?: Maybe<Scalars['ID']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Detailed description of the item */
  description?: Maybe<Scalars['String']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Type of inventory */
  inventoryType: ItemInventoryType;
  /** Indicates if the item is active */
  isActive?: Maybe<Scalars['Boolean']['output']>;
  /** Indicates if this is the final product */
  isFinalProduct?: Maybe<Scalars['Boolean']['output']>;
  /** Name of the item */
  name: Scalars['String']['output'];
  /** quantity */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** Link to the Item */
  returnAsNewSkuItem?: Maybe<Item>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: Maybe<Scalars['ID']['output']>;
  /** Scrap action for item */
  scrapAction?: Maybe<ItemScrapAction>;
  /** Name of the SKU */
  sku: Scalars['String']['output'];
  /** Link to the Unit of Measure */
  uom?: Maybe<Uom>;
  /** Unique identifier of the unit of measure */
  uomId: Scalars['ID']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** wastedQuantity */
  wastedQuantity?: Maybe<Scalars['Int']['output']>;
  /** woAllocatedQuantity */
  woAllocatedQuantity?: Maybe<Scalars['Int']['output']>;
};

/** Item description(Connection) */
export type ItemConnection = {
  __typename?: 'ItemConnection';
  edges: Array<ItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Item description(CreateInput) */
export type ItemCreateInput = {
  /** ID of the BOM that is currently being used for this item */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Detailed description of the item */
  description?: InputMaybe<Scalars['String']['input']>;
  /** ID of the Item description */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Type of inventory */
  inventoryType: ItemInventoryType;
  /** Indicates if the item is active */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Indicates if this is the final product */
  isFinalProduct?: InputMaybe<Scalars['Boolean']['input']>;
  /** Name of the item */
  name: Scalars['String']['input'];
  /** quantity */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<ItemScrapAction>;
  /** Name of the SKU */
  sku: Scalars['String']['input'];
  /** Unique identifier of the unit of measure */
  uomId: Scalars['ID']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** wastedQuantity */
  wastedQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** woAllocatedQuantity */
  woAllocatedQuantity?: InputMaybe<Scalars['Int']['input']>;
};

/** item(Edge) */
export type ItemEdge = {
  __typename?: 'ItemEdge';
  cursor: Scalars['String']['output'];
  node: Item;
};

export enum ItemInventoryType {
  /** Item is counted as part of the inventory. */
  Inventory = 'INVENTORY',
  /** Item is not counted as part of the inventory. But is a product needed for the business. */
  NonInventory = 'NON_INVENTORY',
  /** Item is not counted as part of the inventory. And is a service. */
  Service = 'SERVICE'
}

export type ItemInventoryTypeEnumFilter = {
  eq?: InputMaybe<ItemInventoryType>;
  in?: InputMaybe<Array<InputMaybe<ItemInventoryType>>>;
  ne?: InputMaybe<ItemInventoryType>;
  nin?: InputMaybe<Array<InputMaybe<ItemInventoryType>>>;
};

export enum ItemOrderFieldEnum {
  CreatedAt = 'createdAt',
  Description = 'description',
  InventoryType = 'inventoryType',
  IsActive = 'isActive',
  IsFinalProduct = 'isFinalProduct',
  Name = 'name',
  Quantity = 'quantity',
  ScrapAction = 'scrapAction',
  Sku = 'sku',
  UpdatedAt = 'updatedAt',
  WastedQuantity = 'wastedQuantity',
  WoAllocatedQuantity = 'woAllocatedQuantity'
}

export type ItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ItemOrderFieldEnum;
};

/** Item description(Input) */
export type ItemQueryInput = {
  and?: InputMaybe<Array<ItemQueryInput>>;
  bomId?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  description?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  inventoryType?: InputMaybe<ItemInventoryTypeEnumFilter>;
  isActive?: InputMaybe<BoolFilter>;
  isFinalProduct?: InputMaybe<BoolFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<ItemQueryInput>>;
  or?: InputMaybe<Array<ItemQueryInput>>;
  quantity?: InputMaybe<IntegerFilter>;
  returnAsNewSkuItemId?: InputMaybe<UuidFilter>;
  scrapAction?: InputMaybe<ItemScrapActionEnumFilter>;
  sku?: InputMaybe<StringFilter>;
  uomId?: InputMaybe<UuidFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  wastedQuantity?: InputMaybe<IntegerFilter>;
  woAllocatedQuantity?: InputMaybe<IntegerFilter>;
};

export enum ItemScrapAction {
  /** Return */
  Return = 'Return',
  /** Return as new SKU */
  ReturnAsNewSku = 'Return_as_new_SKU',
  /** Waste */
  Waste = 'Waste'
}

export type ItemScrapActionEnumFilter = {
  eq?: InputMaybe<ItemScrapAction>;
  in?: InputMaybe<Array<InputMaybe<ItemScrapAction>>>;
  ne?: InputMaybe<ItemScrapAction>;
  nin?: InputMaybe<Array<InputMaybe<ItemScrapAction>>>;
};

/** Item description(UpdateInput) */
export type ItemUpdateInput = {
  /** ID of the BOM that is currently being used for this item */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Detailed description of the item */
  description?: InputMaybe<Scalars['String']['input']>;
  /** Type of inventory */
  inventoryType?: InputMaybe<ItemInventoryType>;
  /** Indicates if the item is active */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Indicates if this is the final product */
  isFinalProduct?: InputMaybe<Scalars['Boolean']['input']>;
  /** Name of the item */
  name?: InputMaybe<Scalars['String']['input']>;
  /** quantity */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<ItemScrapAction>;
  /** Name of the SKU */
  sku?: InputMaybe<Scalars['String']['input']>;
  /** Unique identifier of the unit of measure */
  uomId?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** wastedQuantity */
  wastedQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** woAllocatedQuantity */
  woAllocatedQuantity?: InputMaybe<Scalars['Int']['input']>;
};

/** Inventory location on Shopify */
export type Location = {
  __typename?: 'Location';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Name of the location */
  name?: Maybe<Scalars['String']['output']>;
  /** Shopify ID of the location */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Inventory location on Shopify(Connection) */
export type LocationConnection = {
  __typename?: 'LocationConnection';
  edges: Array<LocationEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Inventory location on Shopify(CreateInput) */
export type LocationCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Inventory location on Shopify */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the location */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Shopify ID of the location */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** location(Edge) */
export type LocationEdge = {
  __typename?: 'LocationEdge';
  cursor: Scalars['String']['output'];
  node: Location;
};

export enum LocationOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Name = 'name',
  ShopifyId = 'shopifyID',
  UpdatedAt = 'updatedAt'
}

export type LocationOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: LocationOrderFieldEnum;
};

/** Inventory location on Shopify(Input) */
export type LocationQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<LocationQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<LocationQueryInput>>;
  or?: InputMaybe<Array<LocationQueryInput>>;
  shopifyID?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Inventory location on Shopify(UpdateInput) */
export type LocationUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Name of the location */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Shopify ID of the location */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** MOBatch */
export type MoBatch = {
  __typename?: 'MOBatch';
  /** batchSize to be produced */
  batchSize: Scalars['Int']['output'];
  /** Link to the BOM */
  bom?: Maybe<Bom>;
  /** BOM cost for this order */
  bomCost?: Maybe<Scalars['String']['output']>;
  /** Unique identifier of the associated BOM */
  bomId?: Maybe<Scalars['ID']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Date of scheduling and time */
  endDateTime?: Maybe<Scalars['DateTime']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** isDeleted description */
  isDeleted?: Maybe<Scalars['Boolean']['output']>;
  /** Link to the Item */
  item?: Maybe<Item>;
  /** Unique identifier of the associated item */
  itemId?: Maybe<Scalars['ID']['output']>;
  /** Name of the Manufacturing Order */
  name?: Maybe<Scalars['String']['output']>;
  /** Quantity to be produced */
  quantity: Scalars['Int']['output'];
  /** Date of scheduling and time */
  startDateTime?: Maybe<Scalars['DateTime']['output']>;
  /** Status of components for manufacturing */
  status?: Maybe<MoBatchStatus>;
  /** Total cost of manufacturing */
  totalCost?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Work Order cost */
  woCost?: Maybe<Scalars['String']['output']>;
};

/** MOBatch(Connection) */
export type MoBatchConnection = {
  __typename?: 'MOBatchConnection';
  edges: Array<MoBatchEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** MOBatch(CreateInput) */
export type MoBatchCreateInput = {
  /** batchSize to be produced */
  batchSize: Scalars['Int']['input'];
  /** BOM cost for this order */
  bomCost?: InputMaybe<Scalars['String']['input']>;
  /** Unique identifier of the associated BOM */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Date of scheduling and time */
  endDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the MOBatch */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated item */
  itemId?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the Manufacturing Order */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Quantity to be produced */
  quantity: Scalars['Int']['input'];
  /** Date of scheduling and time */
  startDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** Status of components for manufacturing */
  status?: InputMaybe<MoBatchStatus>;
  /** Total cost of manufacturing */
  totalCost?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work Order cost */
  woCost?: InputMaybe<Scalars['String']['input']>;
};

/** mOBatch(Edge) */
export type MoBatchEdge = {
  __typename?: 'MOBatchEdge';
  cursor: Scalars['String']['output'];
  node: MoBatch;
};

export enum MoBatchOrderFieldEnum {
  BatchSize = 'batchSize',
  BomCost = 'bomCost',
  CreatedAt = 'createdAt',
  EndDateTime = 'endDateTime',
  IsDeleted = 'isDeleted',
  Name = 'name',
  Quantity = 'quantity',
  StartDateTime = 'startDateTime',
  Status = 'status',
  TotalCost = 'totalCost',
  UpdatedAt = 'updatedAt',
  WoCost = 'woCost'
}

export type MoBatchOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: MoBatchOrderFieldEnum;
};

/** MOBatch(Input) */
export type MoBatchQueryInput = {
  and?: InputMaybe<Array<MoBatchQueryInput>>;
  batchSize?: InputMaybe<IntegerFilter>;
  bomCost?: InputMaybe<StringFilter>;
  bomId?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  endDateTime?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  isDeleted?: InputMaybe<BoolFilter>;
  itemId?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<MoBatchQueryInput>>;
  or?: InputMaybe<Array<MoBatchQueryInput>>;
  quantity?: InputMaybe<IntegerFilter>;
  startDateTime?: InputMaybe<DatetimeFilter>;
  status?: InputMaybe<MoBatchStatusEnumFilter>;
  totalCost?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  woCost?: InputMaybe<StringFilter>;
};

export enum MoBatchStatus {
  /** Canceled */
  Canceled = 'Canceled',
  /** Completed */
  Completed = 'Completed',
  /** Draft */
  Draft = 'Draft',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Planned */
  Planned = 'Planned'
}

export type MoBatchStatusEnumFilter = {
  eq?: InputMaybe<MoBatchStatus>;
  in?: InputMaybe<Array<InputMaybe<MoBatchStatus>>>;
  ne?: InputMaybe<MoBatchStatus>;
  nin?: InputMaybe<Array<InputMaybe<MoBatchStatus>>>;
};

/** MOBatch(UpdateInput) */
export type MoBatchUpdateInput = {
  /** batchSize to be produced */
  batchSize?: InputMaybe<Scalars['Int']['input']>;
  /** BOM cost for this order */
  bomCost?: InputMaybe<Scalars['String']['input']>;
  /** Unique identifier of the associated BOM */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Date of scheduling and time */
  endDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated item */
  itemId?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the Manufacturing Order */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Quantity to be produced */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Date of scheduling and time */
  startDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** Status of components for manufacturing */
  status?: InputMaybe<MoBatchStatus>;
  /** Total cost of manufacturing */
  totalCost?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work Order cost */
  woCost?: InputMaybe<Scalars['String']['input']>;
};

/** MOLineItem description */
export type MoLineItem = {
  __typename?: 'MOLineItem';
  /** Link to the bomLineItem */
  bomLineItem?: Maybe<BomLineItem>;
  /** Unique identifier of the associated bomLineItem */
  bomLineItemId: Scalars['ID']['output'];
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** isDeleted description */
  isDeleted?: Maybe<Scalars['Boolean']['output']>;
  /** Link to the MO */
  itemMo?: Maybe<ManufacturingOrder>;
  /** Unique identifier of the associated MO if nested */
  itemMoId?: Maybe<Scalars['ID']['output']>;
  /** Link to the MO */
  mo?: Maybe<ManufacturingOrder>;
  /** Unique identifier of the associated MO */
  moId: Scalars['ID']['output'];
  /** The Quantity needed for the MO */
  requiredQuantity?: Maybe<Scalars['Int']['output']>;
  /** Total cost of the component based on input quantity, uom and unit cost */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** MOLineItem description(Connection) */
export type MoLineItemConnection = {
  __typename?: 'MOLineItemConnection';
  edges: Array<MoLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** MOLineItem description(CreateInput) */
export type MoLineItemCreateInput = {
  /** Unique identifier of the associated bomLineItem */
  bomLineItemId: Scalars['ID']['input'];
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the MOLineItem description */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated MO if nested */
  itemMoId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated MO */
  moId: Scalars['ID']['input'];
  /** The Quantity needed for the MO */
  requiredQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** Total cost of the component based on input quantity, uom and unit cost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** mOLineItem(Edge) */
export type MoLineItemEdge = {
  __typename?: 'MOLineItemEdge';
  cursor: Scalars['String']['output'];
  node: MoLineItem;
};

export enum MoLineItemOrderFieldEnum {
  CreatedAt = 'createdAt',
  IsDeleted = 'isDeleted',
  RequiredQuantity = 'requiredQuantity',
  TotalCost = 'totalCost',
  UpdatedAt = 'updatedAt'
}

export type MoLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: MoLineItemOrderFieldEnum;
};

/** MOLineItem description(Input) */
export type MoLineItemQueryInput = {
  and?: InputMaybe<Array<MoLineItemQueryInput>>;
  bomLineItemId?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  isDeleted?: InputMaybe<BoolFilter>;
  itemMoId?: InputMaybe<UuidFilter>;
  moId?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<MoLineItemQueryInput>>;
  or?: InputMaybe<Array<MoLineItemQueryInput>>;
  requiredQuantity?: InputMaybe<IntegerFilter>;
  totalCost?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** MOLineItem description(UpdateInput) */
export type MoLineItemUpdateInput = {
  /** Unique identifier of the associated bomLineItem */
  bomLineItemId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated MO if nested */
  itemMoId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated MO */
  moId?: InputMaybe<Scalars['ID']['input']>;
  /** The Quantity needed for the MO */
  requiredQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** Total cost of the component based on input quantity, uom and unit cost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type MoLineItemsAggregationAvgResult = {
  __typename?: 'MOLineItemsAggregationAvgResult';
  /** requiredQuantity is aggregation field */
  requiredQuantity?: Maybe<Scalars['Float']['output']>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Float']['output']>;
};

export type MoLineItemsAggregationCountResult = {
  __typename?: 'MOLineItemsAggregationCountResult';
  /** bomLineItemId is aggregation field */
  bomLineItemId?: Maybe<Scalars['Int']['output']>;
  /** itemMoId is aggregation field */
  itemMoId?: Maybe<Scalars['Int']['output']>;
  /** moId is aggregation field */
  moId?: Maybe<Scalars['Int']['output']>;
  /** requiredQuantity is aggregation field */
  requiredQuantity?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<MoLineItemsAggregationCountToDayFunc>;
  toHour?: Maybe<MoLineItemsAggregationCountToHourFunc>;
  toMinute?: Maybe<MoLineItemsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<MoLineItemsAggregationCountToMonthFunc>;
  toYear?: Maybe<MoLineItemsAggregationCountToYearFunc>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Int']['output']>;
};

export type MoLineItemsAggregationCountToDayFunc = {
  __typename?: 'MOLineItemsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type MoLineItemsAggregationCountToHourFunc = {
  __typename?: 'MOLineItemsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type MoLineItemsAggregationCountToMinuteFunc = {
  __typename?: 'MOLineItemsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type MoLineItemsAggregationCountToMonthFunc = {
  __typename?: 'MOLineItemsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type MoLineItemsAggregationCountToYearFunc = {
  __typename?: 'MOLineItemsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type MoLineItemsAggregationGroupByResult = {
  __typename?: 'MOLineItemsAggregationGroupByResult';
  /** Unique identifier of the associated bomLineItem */
  bomLineItemId?: Maybe<Scalars['ID']['output']>;
  /** Unique identifier of the associated MO if nested */
  itemMoId?: Maybe<Scalars['ID']['output']>;
  /** Unique identifier of the associated MO */
  moId?: Maybe<Scalars['ID']['output']>;
  /** The Quantity needed for the MO */
  requiredQuantity?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<MoLineItemsAggregationGroupByToDayFunc>;
  toHour?: Maybe<MoLineItemsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<MoLineItemsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<MoLineItemsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<MoLineItemsAggregationGroupByToYearFunc>;
  /** Total cost of the component based on input quantity, uom and unit cost */
  totalCost?: Maybe<Scalars['Float']['output']>;
};

export type MoLineItemsAggregationGroupByToDayFunc = {
  __typename?: 'MOLineItemsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type MoLineItemsAggregationGroupByToHourFunc = {
  __typename?: 'MOLineItemsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type MoLineItemsAggregationGroupByToMinuteFunc = {
  __typename?: 'MOLineItemsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type MoLineItemsAggregationGroupByToMonthFunc = {
  __typename?: 'MOLineItemsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type MoLineItemsAggregationGroupByToYearFunc = {
  __typename?: 'MOLineItemsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type MoLineItemsAggregationQuantityResult = {
  __typename?: 'MOLineItemsAggregationQuantityResult';
  /** requiredQuantity is aggregation field */
  requiredQuantity?: Maybe<Scalars['Int']['output']>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Float']['output']>;
};

export type MoLineItemsAggregationResult = {
  __typename?: 'MOLineItemsAggregationResult';
  avg?: Maybe<MoLineItemsAggregationAvgResult>;
  count?: Maybe<MoLineItemsAggregationCountResult>;
  groupBy: MoLineItemsAggregationGroupByResult;
  max?: Maybe<MoLineItemsAggregationQuantityResult>;
  min?: Maybe<MoLineItemsAggregationQuantityResult>;
  sum?: Maybe<MoLineItemsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

/** ManufacturingOrder */
export type ManufacturingOrder = {
  __typename?: 'ManufacturingOrder';
  /** Link to the BOM */
  bom?: Maybe<Bom>;
  /** BOM cost for this order */
  bomCost?: Maybe<Scalars['String']['output']>;
  /** Unique identifier of the associated BOM */
  bomId?: Maybe<Scalars['ID']['output']>;
  /** Status of components for manufacturing */
  componentsStatus?: Maybe<ManufacturingOrderComponentsStatus>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Date of scheduling and time */
  endDateTime?: Maybe<Scalars['DateTime']['output']>;
  /** Error message if any */
  errorMessage?: Maybe<Scalars['String']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** isDeleted description */
  isDeleted?: Maybe<Scalars['Boolean']['output']>;
  /** isPlanCreated description */
  isPlanCreated?: Maybe<Scalars['Boolean']['output']>;
  /** Link to the Item */
  item?: Maybe<Item>;
  /** Unique identifier of the associated item */
  itemId?: Maybe<Scalars['ID']['output']>;
  /** Link to the MOBatch */
  moBatch?: Maybe<MoBatch>;
  /** Unique identifier of the associated MOBatch */
  moBatchId?: Maybe<Scalars['ID']['output']>;
  /** Name of the Manufacturing Order */
  name?: Maybe<Scalars['String']['output']>;
  /** Parent Manufacturing Order ID */
  parentMoId?: Maybe<Scalars['String']['output']>;
  /** Quantity to be produced */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** Date of scheduling and time */
  startDateTime?: Maybe<Scalars['DateTime']['output']>;
  /** Current status of manufacturing order */
  status?: Maybe<ManufacturingOrderStatus>;
  /** Total cost of manufacturing */
  totalCost?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Work Order cost */
  woCost?: Maybe<Scalars['String']['output']>;
};

export enum ManufacturingOrderComponentsStatus {
  /** Blocked */
  Blocked = 'Blocked',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Pending */
  Pending = 'Pending',
  /** Ready */
  Ready = 'Ready'
}

export type ManufacturingOrderComponentsStatusEnumFilter = {
  eq?: InputMaybe<ManufacturingOrderComponentsStatus>;
  in?: InputMaybe<Array<InputMaybe<ManufacturingOrderComponentsStatus>>>;
  ne?: InputMaybe<ManufacturingOrderComponentsStatus>;
  nin?: InputMaybe<Array<InputMaybe<ManufacturingOrderComponentsStatus>>>;
};

/** ManufacturingOrder(Connection) */
export type ManufacturingOrderConnection = {
  __typename?: 'ManufacturingOrderConnection';
  edges: Array<ManufacturingOrderEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** ManufacturingOrder(CreateInput) */
export type ManufacturingOrderCreateInput = {
  /** BOM cost for this order */
  bomCost?: InputMaybe<Scalars['String']['input']>;
  /** Unique identifier of the associated BOM */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** Status of components for manufacturing */
  componentsStatus?: InputMaybe<ManufacturingOrderComponentsStatus>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Date of scheduling and time */
  endDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** Error message if any */
  errorMessage?: InputMaybe<Scalars['String']['input']>;
  /** ID of the ManufacturingOrder */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** isPlanCreated description */
  isPlanCreated?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated item */
  itemId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated MOBatch */
  moBatchId?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the Manufacturing Order */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Parent Manufacturing Order ID */
  parentMoId?: InputMaybe<Scalars['String']['input']>;
  /** Quantity to be produced */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Date of scheduling and time */
  startDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** Current status of manufacturing order */
  status?: InputMaybe<ManufacturingOrderStatus>;
  /** Total cost of manufacturing */
  totalCost?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work Order cost */
  woCost?: InputMaybe<Scalars['String']['input']>;
};

/** manufacturingOrder(Edge) */
export type ManufacturingOrderEdge = {
  __typename?: 'ManufacturingOrderEdge';
  cursor: Scalars['String']['output'];
  node: ManufacturingOrder;
};

export enum ManufacturingOrderOrderFieldEnum {
  BomCost = 'bomCost',
  ComponentsStatus = 'componentsStatus',
  CreatedAt = 'createdAt',
  EndDateTime = 'endDateTime',
  ErrorMessage = 'errorMessage',
  IsDeleted = 'isDeleted',
  IsPlanCreated = 'isPlanCreated',
  Name = 'name',
  ParentMoId = 'parentMoId',
  Quantity = 'quantity',
  StartDateTime = 'startDateTime',
  Status = 'status',
  TotalCost = 'totalCost',
  UpdatedAt = 'updatedAt',
  WoCost = 'woCost'
}

export type ManufacturingOrderOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ManufacturingOrderOrderFieldEnum;
};

/** ManufacturingOrder(Input) */
export type ManufacturingOrderQueryInput = {
  and?: InputMaybe<Array<ManufacturingOrderQueryInput>>;
  bomCost?: InputMaybe<StringFilter>;
  bomId?: InputMaybe<UuidFilter>;
  componentsStatus?: InputMaybe<ManufacturingOrderComponentsStatusEnumFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  endDateTime?: InputMaybe<DatetimeFilter>;
  errorMessage?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  isDeleted?: InputMaybe<BoolFilter>;
  isPlanCreated?: InputMaybe<BoolFilter>;
  itemId?: InputMaybe<UuidFilter>;
  moBatchId?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<ManufacturingOrderQueryInput>>;
  or?: InputMaybe<Array<ManufacturingOrderQueryInput>>;
  parentMoId?: InputMaybe<StringFilter>;
  quantity?: InputMaybe<IntegerFilter>;
  startDateTime?: InputMaybe<DatetimeFilter>;
  status?: InputMaybe<ManufacturingOrderStatusEnumFilter>;
  totalCost?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  woCost?: InputMaybe<StringFilter>;
};

export enum ManufacturingOrderStatus {
  /** Canceled */
  Canceled = 'Canceled',
  /** Completed */
  Completed = 'Completed',
  /** Draft */
  Draft = 'Draft',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Planned */
  Planned = 'Planned'
}

export type ManufacturingOrderStatusEnumFilter = {
  eq?: InputMaybe<ManufacturingOrderStatus>;
  in?: InputMaybe<Array<InputMaybe<ManufacturingOrderStatus>>>;
  ne?: InputMaybe<ManufacturingOrderStatus>;
  nin?: InputMaybe<Array<InputMaybe<ManufacturingOrderStatus>>>;
};

/** Status tracking of manufacturing order */
export type ManufacturingOrderTransition = {
  __typename?: 'ManufacturingOrderTransition';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** from status description */
  fromStatus?: Maybe<ManufacturingOrderTransitionFromStatus>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Link to the MO */
  mo?: Maybe<ManufacturingOrder>;
  /** Unique identifier of the associated MO */
  moId: Scalars['ID']['output'];
  /** Minutes in particular status */
  timeInStatus: Scalars['Int']['output'];
  /** to status description */
  toStatus?: Maybe<ManufacturingOrderTransitionToStatus>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Status tracking of manufacturing order(Connection) */
export type ManufacturingOrderTransitionConnection = {
  __typename?: 'ManufacturingOrderTransitionConnection';
  edges: Array<ManufacturingOrderTransitionEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Status tracking of manufacturing order(CreateInput) */
export type ManufacturingOrderTransitionCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** from status description */
  fromStatus?: InputMaybe<ManufacturingOrderTransitionFromStatus>;
  /** ID of the Status tracking of manufacturing order */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated MO */
  moId: Scalars['ID']['input'];
  /** Minutes in particular status */
  timeInStatus: Scalars['Int']['input'];
  /** to status description */
  toStatus?: InputMaybe<ManufacturingOrderTransitionToStatus>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** manufacturingOrderTransition(Edge) */
export type ManufacturingOrderTransitionEdge = {
  __typename?: 'ManufacturingOrderTransitionEdge';
  cursor: Scalars['String']['output'];
  node: ManufacturingOrderTransition;
};

export enum ManufacturingOrderTransitionFromStatus {
  /** Canceled */
  Canceled = 'Canceled',
  /** Completed */
  Completed = 'Completed',
  /** Draft */
  Draft = 'Draft',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Planned */
  Planned = 'Planned'
}

export type ManufacturingOrderTransitionFromStatusEnumFilter = {
  eq?: InputMaybe<ManufacturingOrderTransitionFromStatus>;
  in?: InputMaybe<Array<InputMaybe<ManufacturingOrderTransitionFromStatus>>>;
  ne?: InputMaybe<ManufacturingOrderTransitionFromStatus>;
  nin?: InputMaybe<Array<InputMaybe<ManufacturingOrderTransitionFromStatus>>>;
};

export enum ManufacturingOrderTransitionOrderFieldEnum {
  CreatedAt = 'createdAt',
  FromStatus = 'fromStatus',
  TimeInStatus = 'timeInStatus',
  ToStatus = 'toStatus',
  UpdatedAt = 'updatedAt'
}

export type ManufacturingOrderTransitionOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ManufacturingOrderTransitionOrderFieldEnum;
};

/** Status tracking of manufacturing order(Input) */
export type ManufacturingOrderTransitionQueryInput = {
  and?: InputMaybe<Array<ManufacturingOrderTransitionQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  fromStatus?: InputMaybe<ManufacturingOrderTransitionFromStatusEnumFilter>;
  id?: InputMaybe<UuidFilter>;
  moId?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<ManufacturingOrderTransitionQueryInput>>;
  or?: InputMaybe<Array<ManufacturingOrderTransitionQueryInput>>;
  timeInStatus?: InputMaybe<IntegerFilter>;
  toStatus?: InputMaybe<ManufacturingOrderTransitionToStatusEnumFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

export enum ManufacturingOrderTransitionToStatus {
  /** Canceled */
  Canceled = 'Canceled',
  /** Completed */
  Completed = 'Completed',
  /** Draft */
  Draft = 'Draft',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Planned */
  Planned = 'Planned'
}

export type ManufacturingOrderTransitionToStatusEnumFilter = {
  eq?: InputMaybe<ManufacturingOrderTransitionToStatus>;
  in?: InputMaybe<Array<InputMaybe<ManufacturingOrderTransitionToStatus>>>;
  ne?: InputMaybe<ManufacturingOrderTransitionToStatus>;
  nin?: InputMaybe<Array<InputMaybe<ManufacturingOrderTransitionToStatus>>>;
};

/** Status tracking of manufacturing order(UpdateInput) */
export type ManufacturingOrderTransitionUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** from status description */
  fromStatus?: InputMaybe<ManufacturingOrderTransitionFromStatus>;
  /** Unique identifier of the associated MO */
  moId?: InputMaybe<Scalars['ID']['input']>;
  /** Minutes in particular status */
  timeInStatus?: InputMaybe<Scalars['Int']['input']>;
  /** to status description */
  toStatus?: InputMaybe<ManufacturingOrderTransitionToStatus>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** ManufacturingOrder(UpdateInput) */
export type ManufacturingOrderUpdateInput = {
  /** BOM cost for this order */
  bomCost?: InputMaybe<Scalars['String']['input']>;
  /** Unique identifier of the associated BOM */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** Status of components for manufacturing */
  componentsStatus?: InputMaybe<ManufacturingOrderComponentsStatus>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Date of scheduling and time */
  endDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** Error message if any */
  errorMessage?: InputMaybe<Scalars['String']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** isPlanCreated description */
  isPlanCreated?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated item */
  itemId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated MOBatch */
  moBatchId?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the Manufacturing Order */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Parent Manufacturing Order ID */
  parentMoId?: InputMaybe<Scalars['String']['input']>;
  /** Quantity to be produced */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Date of scheduling and time */
  startDateTime?: InputMaybe<Scalars['DateTime']['input']>;
  /** Current status of manufacturing order */
  status?: InputMaybe<ManufacturingOrderStatus>;
  /** Total cost of manufacturing */
  totalCost?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work Order cost */
  woCost?: InputMaybe<Scalars['String']['input']>;
};

export type MoLineItemCompositeKey = {
  /** Unique identifier of the associated bomLineItem */
  bomLineItemId: Scalars['ID']['input'];
  /** Unique identifier of the associated MO */
  moId: Scalars['ID']['input'];
};

export type Mutation = {
  __typename?: 'Mutation';
  addBatchMo?: Maybe<AddBatchMoOutput>;
  allocateCost?: Maybe<Scalars['String']['output']>;
  allocateCostForOpenCostPools?: Maybe<Scalars['String']['output']>;
  allocateInventoryItem?: Maybe<AllocateInventoryItemOutput>;
  /** BOMLineItem description(BulkUpsert) */
  bulkUpsertBomLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** BOMLineItem description(BulkUpsertBy) */
  bulkUpsertBomLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Contact model(BulkUpsert) */
  bulkUpsertContacts?: Maybe<Scalars['Boolean']['output']>;
  /** Contact model(BulkUpsertBy) */
  bulkUpsertContactsBy?: Maybe<Scalars['Boolean']['output']>;
  /** CostPoolLineItem model(BulkUpsert) */
  bulkUpsertCostPoolLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** CostPoolLineItem model(BulkUpsertBy) */
  bulkUpsertCostPoolLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(BulkUpsert) */
  bulkUpsertDailySchedules?: Maybe<Scalars['Boolean']['output']>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(BulkUpsertBy) */
  bulkUpsertDailySchedulesBy?: Maybe<Scalars['Boolean']['output']>;
  /** Basic Employee details(BulkUpsert) */
  bulkUpsertEmployees?: Maybe<Scalars['Boolean']['output']>;
  /** Basic Employee details(BulkUpsertBy) */
  bulkUpsertEmployeesBy?: Maybe<Scalars['Boolean']['output']>;
  /** StockSummary model for the financial ledger(BulkUpsert) */
  bulkUpsertFinancialStockSummaries?: Maybe<Scalars['Boolean']['output']>;
  /** StockSummary model for the financial ledger(BulkUpsertBy) */
  bulkUpsertFinancialStockSummariesBy?: Maybe<Scalars['Boolean']['output']>;
  /** Product variant's inventory item model(BulkUpsert) */
  bulkUpsertInventoryItems?: Maybe<Scalars['Boolean']['output']>;
  /** Product variant's inventory item model(BulkUpsertBy) */
  bulkUpsertInventoryItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** InvoiceLineItem model(BulkUpsert) */
  bulkUpsertInvoiceLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** InvoiceLineItem model(BulkUpsertBy) */
  bulkUpsertInvoiceLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Item description(BulkUpsert) */
  bulkUpsertItems?: Maybe<Scalars['Boolean']['output']>;
  /** Item description(BulkUpsertBy) */
  bulkUpsertItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Inventory location on Shopify(BulkUpsert) */
  bulkUpsertLocations?: Maybe<Scalars['Boolean']['output']>;
  /** Inventory location on Shopify(BulkUpsertBy) */
  bulkUpsertLocationsBy?: Maybe<Scalars['Boolean']['output']>;
  /** MOLineItem description(BulkUpsert) */
  bulkUpsertMOLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** MOLineItem description(BulkUpsertBy) */
  bulkUpsertMOLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of manufacturing order(BulkUpsert) */
  bulkUpsertManufacturingOrderTransitions?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of manufacturing order(BulkUpsertBy) */
  bulkUpsertManufacturingOrderTransitionsBy?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of operation(BulkUpsert) */
  bulkUpsertOperationDependencies?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of operation(BulkUpsertBy) */
  bulkUpsertOperationDependenciesBy?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in an operation(BulkUpsert) */
  bulkUpsertOperationLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in an operation(BulkUpsertBy) */
  bulkUpsertOperationLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** A Specific operation that needs to be performed at a bom(BulkUpsert) */
  bulkUpsertOperations?: Maybe<Scalars['Boolean']['output']>;
  /** A Specific operation that needs to be performed at a bom(BulkUpsertBy) */
  bulkUpsertOperationsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Product Image(BulkUpsert) */
  bulkUpsertProductImages?: Maybe<Scalars['Boolean']['output']>;
  /** Product Image(BulkUpsertBy) */
  bulkUpsertProductImagesBy?: Maybe<Scalars['Boolean']['output']>;
  /** The variants of a product(BulkUpsert) */
  bulkUpsertProductVariants?: Maybe<Scalars['Boolean']['output']>;
  /** The variants of a product(BulkUpsertBy) */
  bulkUpsertProductVariantsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Product model(BulkUpsert) */
  bulkUpsertProducts?: Maybe<Scalars['Boolean']['output']>;
  /** Product model(BulkUpsertBy) */
  bulkUpsertProductsBy?: Maybe<Scalars['Boolean']['output']>;
  /** PurchaseOrderLineItem model(BulkUpsert) */
  bulkUpsertPurchaseOrderLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** PurchaseOrderLineItem model(BulkUpsertBy) */
  bulkUpsertPurchaseOrderLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** ReceiptLineItem model(BulkUpsert) */
  bulkUpsertReceiptLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** ReceiptLineItem model(BulkUpsertBy) */
  bulkUpsertReceiptLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrderLineItem model(BulkUpsert) */
  bulkUpsertSalesOrderLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrderLineItem model(BulkUpsertBy) */
  bulkUpsertSalesOrderLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrder model(BulkUpsert) */
  bulkUpsertSalesOrders?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrder model(BulkUpsertBy) */
  bulkUpsertSalesOrdersBy?: Maybe<Scalars['Boolean']['output']>;
  /** ShipmentLineItem model(BulkUpsert) */
  bulkUpsertShipmentLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** ShipmentLineItem model(BulkUpsertBy) */
  bulkUpsertShipmentLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** UOMConversion description(BulkUpsert) */
  bulkUpsertUomConversions?: Maybe<Scalars['Boolean']['output']>;
  /** UOMConversion description(BulkUpsertBy) */
  bulkUpsertUomConversionsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Unit of Measure(BulkUpsert) */
  bulkUpsertUoms?: Maybe<Scalars['Boolean']['output']>;
  /** Unit of Measure(BulkUpsertBy) */
  bulkUpsertUomsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Time tracking by employee(BulkUpsert) */
  bulkUpsertWOTimeTrackings?: Maybe<Scalars['Boolean']['output']>;
  /** Time tracking by employee(BulkUpsertBy) */
  bulkUpsertWOTimeTrackingsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Work Center are the physical locations where the production happens(BulkUpsert) */
  bulkUpsertWorkCenters?: Maybe<Scalars['Boolean']['output']>;
  /** Work Center are the physical locations where the production happens(BulkUpsertBy) */
  bulkUpsertWorkCentersBy?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of workOrder(BulkUpsert) */
  bulkUpsertWorkOrderDependencies?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of workOrder(BulkUpsertBy) */
  bulkUpsertWorkOrderDependenciesBy?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in a work order(BulkUpsert) */
  bulkUpsertWorkOrderLineItems?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in a work order(BulkUpsertBy) */
  bulkUpsertWorkOrderLineItemsBy?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of work order(BulkUpsert) */
  bulkUpsertWorkOrderTransitions?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of work order(BulkUpsertBy) */
  bulkUpsertWorkOrderTransitionsBy?: Maybe<Scalars['Boolean']['output']>;
  /** The actual work order which is created based on the Bom requirement(BulkUpsert) */
  bulkUpsertWorkOrders?: Maybe<Scalars['Boolean']['output']>;
  /** The actual work order which is created based on the Bom requirement(BulkUpsertBy) */
  bulkUpsertWorkOrdersBy?: Maybe<Scalars['Boolean']['output']>;
  /** Used to define the hours during which a work center will be available(BulkUpsert) */
  bulkUpsertWorkingHours?: Maybe<Scalars['Boolean']['output']>;
  /** Used to define the hours during which a work center will be available(BulkUpsertBy) */
  bulkUpsertWorkingHoursBy?: Maybe<Scalars['Boolean']['output']>;
  calculateStockEventAndUpdateStockSummary?: Maybe<Scalars['String']['output']>;
  cancelManufacturingOrder?: Maybe<CancelManufacturingOrderOutput>;
  cancelWorkOrder?: Maybe<CancelWorkOrderOutput>;
  /** BOM description(Change) */
  changeBom?: Maybe<Scalars['Boolean']['output']>;
  /** BOMLineItem description(Change) */
  changeBomLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Contact model(Change) */
  changeContact?: Maybe<Scalars['Boolean']['output']>;
  /** CostPool model(Change) */
  changeCostPool?: Maybe<Scalars['Boolean']['output']>;
  /** CostPoolLineItem model(Change) */
  changeCostPoolLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Change) */
  changeDailySchedule?: Maybe<Scalars['Boolean']['output']>;
  /** Basic Employee details(Change) */
  changeEmployee?: Maybe<Scalars['Boolean']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(Change) */
  changeFinancialStockEvent?: Maybe<Scalars['Boolean']['output']>;
  /** StockSummary model for the financial ledger(Change) */
  changeFinancialStockSummary?: Maybe<Scalars['Boolean']['output']>;
  /** Product variant's inventory item model(Change) */
  changeInventoryItem?: Maybe<Scalars['Boolean']['output']>;
  /** Inventory Level of an inventory item(Change) */
  changeInventoryLevel?: Maybe<Scalars['Boolean']['output']>;
  /** Invoice model(Change) */
  changeInvoice?: Maybe<Scalars['Boolean']['output']>;
  /** InvoiceLineItem model(Change) */
  changeInvoiceLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Item description(Change) */
  changeItem?: Maybe<Scalars['Boolean']['output']>;
  /** Inventory location on Shopify(Change) */
  changeLocation?: Maybe<Scalars['Boolean']['output']>;
  /** MOBatch(Change) */
  changeMOBatch?: Maybe<Scalars['Boolean']['output']>;
  /** MOLineItem description(Change) */
  changeMOLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** ManufacturingOrder(Change) */
  changeManufacturingOrder?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of manufacturing order(Change) */
  changeManufacturingOrderTransition?: Maybe<Scalars['Boolean']['output']>;
  /** A Specific operation that needs to be performed at a bom(Change) */
  changeOperation?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of operation(Change) */
  changeOperationDependency?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in an operation(Change) */
  changeOperationLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(Change) */
  changeOperationalStockEvent?: Maybe<Scalars['Boolean']['output']>;
  /** Product model(Change) */
  changeProduct?: Maybe<Scalars['Boolean']['output']>;
  /** Product Image(Change) */
  changeProductImage?: Maybe<Scalars['Boolean']['output']>;
  /** The variants of a product(Change) */
  changeProductVariant?: Maybe<Scalars['Boolean']['output']>;
  /** PurchaseOrder model(Change) */
  changePurchaseOrder?: Maybe<Scalars['Boolean']['output']>;
  /** PurchaseOrderLineItem model(Change) */
  changePurchaseOrderLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Receipt model(Change) */
  changeReceipt?: Maybe<Scalars['Boolean']['output']>;
  /** ReceiptLineItem model(Change) */
  changeReceiptLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** User Roles(Change) */
  changeRole?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrder model(Change) */
  changeSalesOrder?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrderLineItem model(Change) */
  changeSalesOrderLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Shipment model(Change) */
  changeShipment?: Maybe<Scalars['Boolean']['output']>;
  /** ShipmentLineItem model(Change) */
  changeShipmentLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** StockSummary model(Change) */
  changeStockSummary?: Maybe<Scalars['Boolean']['output']>;
  /** Unit of Measure(Change) */
  changeUom?: Maybe<Scalars['Boolean']['output']>;
  /** UOMConversion description(Change) */
  changeUomConversion?: Maybe<Scalars['Boolean']['output']>;
  /** User of the system(Change) */
  changeUser?: Maybe<Scalars['Boolean']['output']>;
  /** Time tracking by employee(Change) */
  changeWOTimeTracking?: Maybe<Scalars['Boolean']['output']>;
  /** Work Center are the physical locations where the production happens(Change) */
  changeWorkCenter?: Maybe<Scalars['Boolean']['output']>;
  /** The actual work order which is created based on the Bom requirement(Change) */
  changeWorkOrder?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of workOrder(Change) */
  changeWorkOrderDependency?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in a work order(Change) */
  changeWorkOrderLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of work order(Change) */
  changeWorkOrderTransition?: Maybe<Scalars['Boolean']['output']>;
  /** Used to define the hours during which a work center will be available(Change) */
  changeWorkingHour?: Maybe<Scalars['Boolean']['output']>;
  computeWorkOrderCostRealDuration?: Maybe<ComputeWorkOrderCostRealDurationOutput>;
  configureBomItemsWithOperation?: Maybe<ConfigureBomItemsWithOperationOutput>;
  consumeAllocatedInventoryItem?: Maybe<ConsumeAllocatedInventoryItemOutput>;
  consumeInventoryItem?: Maybe<ConsumeInventoryItemOutput>;
  copyStockEventsToFinancialLedger?: Maybe<Scalars['String']['output']>;
  /** BOM description(Create) */
  createBom?: Maybe<Bom>;
  /** BOMLineItem description(Create) */
  createBomLineItem?: Maybe<BomLineItem>;
  /** Contact model(Create) */
  createContact?: Maybe<Contact>;
  /** CostPool model(Create) */
  createCostPool?: Maybe<CostPool>;
  /** CostPoolLineItem model(Create) */
  createCostPoolLineItem?: Maybe<CostPoolLineItem>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Create) */
  createDailySchedule?: Maybe<DailySchedule>;
  /** Basic Employee details(Create) */
  createEmployee?: Maybe<Employee>;
  /** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(Create) */
  createFinancialStockEvent?: Maybe<FinancialStockEvent>;
  /** StockSummary model for the financial ledger(Create) */
  createFinancialStockSummary?: Maybe<FinancialStockSummary>;
  /** Product variant's inventory item model(Create) */
  createInventoryItem?: Maybe<InventoryItem>;
  /** Inventory Level of an inventory item(Create) */
  createInventoryLevel?: Maybe<InventoryLevel>;
  /** Invoice model(Create) */
  createInvoice?: Maybe<Invoice>;
  createInvoiceFromShipment?: Maybe<Scalars['String']['output']>;
  /** InvoiceLineItem model(Create) */
  createInvoiceLineItem?: Maybe<InvoiceLineItem>;
  /** Item description(Create) */
  createItem?: Maybe<Item>;
  /** Inventory location on Shopify(Create) */
  createLocation?: Maybe<Location>;
  /** MOBatch(Create) */
  createMOBatch?: Maybe<MoBatch>;
  /** MOLineItem description(Create) */
  createMOLineItem?: Maybe<MoLineItem>;
  /** ManufacturingOrder(Create) */
  createManufacturingOrder?: Maybe<ManufacturingOrder>;
  createManufacturingOrderAndWorkOrders?: Maybe<CreateManufacturingOrderOutput>;
  /** Status tracking of manufacturing order(Create) */
  createManufacturingOrderTransition?: Maybe<ManufacturingOrderTransition>;
  createNestedManufacturingOrder?: Maybe<CreateNestedManufacturingOrderOutput>;
  /** A Specific operation that needs to be performed at a bom(Create) */
  createOperation?: Maybe<Operation>;
  /** To know the dependency of operation(Create) */
  createOperationDependency?: Maybe<OperationDependency>;
  /** Represents a line item in an operation(Create) */
  createOperationLineItem?: Maybe<OperationLineItem>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(Create) */
  createOperationalStockEvent?: Maybe<OperationalStockEvent>;
  /** Product model(Create) */
  createProduct?: Maybe<Product>;
  /** Product Image(Create) */
  createProductImage?: Maybe<ProductImage>;
  /** The variants of a product(Create) */
  createProductVariant?: Maybe<ProductVariant>;
  /** PurchaseOrder model(Create) */
  createPurchaseOrder?: Maybe<PurchaseOrder>;
  /** PurchaseOrderLineItem model(Create) */
  createPurchaseOrderLineItem?: Maybe<PurchaseOrderLineItem>;
  /** Receipt model(Create) */
  createReceipt?: Maybe<Receipt>;
  createReceiptFromPurchaseOrder?: Maybe<Scalars['String']['output']>;
  /** ReceiptLineItem model(Create) */
  createReceiptLineItem?: Maybe<ReceiptLineItem>;
  /** User Roles(Create) */
  createRole?: Maybe<Role>;
  /** SalesOrder model(Create) */
  createSalesOrder?: Maybe<SalesOrder>;
  /** SalesOrderLineItem model(Create) */
  createSalesOrderLineItem?: Maybe<SalesOrderLineItem>;
  /** Shipment model(Create) */
  createShipment?: Maybe<Shipment>;
  createShipmentFromSalesOrder?: Maybe<CreateShipmentFromSalesOrderOutput>;
  /** ShipmentLineItem model(Create) */
  createShipmentLineItem?: Maybe<ShipmentLineItem>;
  createStockEventsFromReceiptLineItems?: Maybe<CreateStockEventsFromReceiptLineItemsOutput>;
  createStockEventsFromShipmentLineItems?: Maybe<Scalars['String']['output']>;
  /** StockSummary model(Create) */
  createStockSummary?: Maybe<StockSummary>;
  /** Unit of Measure(Create) */
  createUom?: Maybe<Uom>;
  /** UOMConversion description(Create) */
  createUomConversion?: Maybe<UomConversion>;
  /** User of the system(Create) */
  createUser?: Maybe<User>;
  /** Time tracking by employee(Create) */
  createWOTimeTracking?: Maybe<WoTimeTracking>;
  /** Work Center are the physical locations where the production happens(Create) */
  createWorkCenter?: Maybe<WorkCenter>;
  /** The actual work order which is created based on the Bom requirement(Create) */
  createWorkOrder?: Maybe<WorkOrder>;
  /** To know the dependency of workOrder(Create) */
  createWorkOrderDependency?: Maybe<WorkOrderDependency>;
  /** Represents a line item in a work order(Create) */
  createWorkOrderLineItem?: Maybe<WorkOrderLineItem>;
  /** Status tracking of work order(Create) */
  createWorkOrderTransition?: Maybe<WorkOrderTransition>;
  /** Used to define the hours during which a work center will be available(Create) */
  createWorkingHour?: Maybe<WorkingHour>;
  /** BOM description(Delete) */
  deleteBom?: Maybe<Scalars['Boolean']['output']>;
  /** BOMLineItem description(Delete) */
  deleteBomLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Contact model(Delete) */
  deleteContact?: Maybe<Scalars['Boolean']['output']>;
  /** CostPool model(Delete) */
  deleteCostPool?: Maybe<Scalars['Boolean']['output']>;
  /** CostPoolLineItem model(Delete) */
  deleteCostPoolLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Delete) */
  deleteDailySchedule?: Maybe<Scalars['Boolean']['output']>;
  /** Basic Employee details(Delete) */
  deleteEmployee?: Maybe<Scalars['Boolean']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(Delete) */
  deleteFinancialStockEvent?: Maybe<Scalars['Boolean']['output']>;
  /** StockSummary model for the financial ledger(Delete) */
  deleteFinancialStockSummary?: Maybe<Scalars['Boolean']['output']>;
  /** Product variant's inventory item model(Delete) */
  deleteInventoryItem?: Maybe<Scalars['Boolean']['output']>;
  /** Inventory Level of an inventory item(Delete) */
  deleteInventoryLevel?: Maybe<Scalars['Boolean']['output']>;
  /** Invoice model(Delete) */
  deleteInvoice?: Maybe<Scalars['Boolean']['output']>;
  /** InvoiceLineItem model(Delete) */
  deleteInvoiceLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Item description(Delete) */
  deleteItem?: Maybe<Scalars['Boolean']['output']>;
  /** Inventory location on Shopify(Delete) */
  deleteLocation?: Maybe<Scalars['Boolean']['output']>;
  /** MOBatch(Delete) */
  deleteMOBatch?: Maybe<Scalars['Boolean']['output']>;
  /** MOLineItem description(Delete) */
  deleteMOLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** ManufacturingOrder(Delete) */
  deleteManufacturingOrder?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of manufacturing order(Delete) */
  deleteManufacturingOrderTransition?: Maybe<Scalars['Boolean']['output']>;
  /** A Specific operation that needs to be performed at a bom(Delete) */
  deleteOperation?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of operation(Delete) */
  deleteOperationDependency?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in an operation(Delete) */
  deleteOperationLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(Delete) */
  deleteOperationalStockEvent?: Maybe<Scalars['Boolean']['output']>;
  /** Product model(Delete) */
  deleteProduct?: Maybe<Scalars['Boolean']['output']>;
  /** Product Image(Delete) */
  deleteProductImage?: Maybe<Scalars['Boolean']['output']>;
  /** The variants of a product(Delete) */
  deleteProductVariant?: Maybe<Scalars['Boolean']['output']>;
  /** PurchaseOrder model(Delete) */
  deletePurchaseOrder?: Maybe<Scalars['Boolean']['output']>;
  /** PurchaseOrderLineItem model(Delete) */
  deletePurchaseOrderLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Receipt model(Delete) */
  deleteReceipt?: Maybe<Scalars['Boolean']['output']>;
  /** ReceiptLineItem model(Delete) */
  deleteReceiptLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** User Roles(Delete) */
  deleteRole?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrder model(Delete) */
  deleteSalesOrder?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrderLineItem model(Delete) */
  deleteSalesOrderLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Shipment model(Delete) */
  deleteShipment?: Maybe<Scalars['Boolean']['output']>;
  /** ShipmentLineItem model(Delete) */
  deleteShipmentLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** StockSummary model(Delete) */
  deleteStockSummary?: Maybe<Scalars['Boolean']['output']>;
  /** Unit of Measure(Delete) */
  deleteUom?: Maybe<Scalars['Boolean']['output']>;
  /** UOMConversion description(Delete) */
  deleteUomConversion?: Maybe<Scalars['Boolean']['output']>;
  /** User of the system(Delete) */
  deleteUser?: Maybe<Scalars['Boolean']['output']>;
  /** Time tracking by employee(Delete) */
  deleteWOTimeTracking?: Maybe<Scalars['Boolean']['output']>;
  /** Work Center are the physical locations where the production happens(Delete) */
  deleteWorkCenter?: Maybe<Scalars['Boolean']['output']>;
  /** The actual work order which is created based on the Bom requirement(Delete) */
  deleteWorkOrder?: Maybe<Scalars['Boolean']['output']>;
  /** To know the dependency of workOrder(Delete) */
  deleteWorkOrderDependency?: Maybe<Scalars['Boolean']['output']>;
  /** Represents a line item in a work order(Delete) */
  deleteWorkOrderLineItem?: Maybe<Scalars['Boolean']['output']>;
  /** Status tracking of work order(Delete) */
  deleteWorkOrderTransition?: Maybe<Scalars['Boolean']['output']>;
  /** Used to define the hours during which a work center will be available(Delete) */
  deleteWorkingHour?: Maybe<Scalars['Boolean']['output']>;
  manufacturingOrderStatusTransitionRecord?: Maybe<ManufacturingOrderStatusTransitionRecordOutput>;
  moveWoToFinish?: Maybe<MoveWoToFinishOutput>;
  moveWoToInProgress?: Maybe<MoveWoToInProgressOutput>;
  moveWoToReady?: Maybe<MoveWoToReadyOutput>;
  moveWoToWaitingForComponents?: Maybe<MoveWoToWaitingForComponentsOutput>;
  planBatchManufacturingOrder?: Maybe<PlanBatchManufacturingOrderOutput>;
  planManufacturingOrder?: Maybe<PlanManufacturingOrderOutput>;
  recalculateStockEventAndSummary?: Maybe<Scalars['String']['output']>;
  removeAllocatedInventoryItem?: Maybe<RemoveAllocatedInventoryItemOutput>;
  removeBatchManufacturingOrder?: Maybe<RemoveBatchManufacturingOrderOutput>;
  removeManufacturingOrder?: Maybe<RemoveManufacturingOrderOutput>;
  scrapConsumedInventoryItem?: Maybe<ScrapConsumedInventoryItemOutput>;
  setWorkOrderStartAndEndDate?: Maybe<SetWorkOrderStartAndEndDateOutput>;
  unPlanBatchManufacturingOrder?: Maybe<UnPlanBatchManufacturingOrderOutput>;
  unPlanManufacturingOrder?: Maybe<UnPlanManufacturingOrderOutput>;
  /** BOM description(Update) */
  updateBom?: Maybe<Bom>;
  /** BOMLineItem description(Update) */
  updateBomLineItem?: Maybe<BomLineItem>;
  /** Contact model(Update) */
  updateContact?: Maybe<Contact>;
  /** CostPool model(Update) */
  updateCostPool?: Maybe<CostPool>;
  /** CostPoolLineItem model(Update) */
  updateCostPoolLineItem?: Maybe<CostPoolLineItem>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Update) */
  updateDailySchedule?: Maybe<DailySchedule>;
  /** Basic Employee details(Update) */
  updateEmployee?: Maybe<Employee>;
  /** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(Update) */
  updateFinancialStockEvent?: Maybe<FinancialStockEvent>;
  /** StockSummary model for the financial ledger(Update) */
  updateFinancialStockSummary?: Maybe<FinancialStockSummary>;
  /** Product variant's inventory item model(Update) */
  updateInventoryItem?: Maybe<InventoryItem>;
  /** Inventory Level of an inventory item(Update) */
  updateInventoryLevel?: Maybe<InventoryLevel>;
  /** Invoice model(Update) */
  updateInvoice?: Maybe<Invoice>;
  /** InvoiceLineItem model(Update) */
  updateInvoiceLineItem?: Maybe<InvoiceLineItem>;
  /** Item description(Update) */
  updateItem?: Maybe<Item>;
  /** Inventory location on Shopify(Update) */
  updateLocation?: Maybe<Location>;
  /** MOBatch(Update) */
  updateMOBatch?: Maybe<MoBatch>;
  /** MOLineItem description(Update) */
  updateMOLineItem?: Maybe<MoLineItem>;
  /** ManufacturingOrder(Update) */
  updateManufacturingOrder?: Maybe<ManufacturingOrder>;
  updateManufacturingOrderBatchStatus?: Maybe<UpdateManufacturingOrderBatchStatusOutput>;
  updateManufacturingOrderStatus?: Maybe<UpdateManufacturingOrderStatusOutput>;
  /** Status tracking of manufacturing order(Update) */
  updateManufacturingOrderTransition?: Maybe<ManufacturingOrderTransition>;
  /** A Specific operation that needs to be performed at a bom(Update) */
  updateOperation?: Maybe<Operation>;
  /** To know the dependency of operation(Update) */
  updateOperationDependency?: Maybe<OperationDependency>;
  /** Represents a line item in an operation(Update) */
  updateOperationLineItem?: Maybe<OperationLineItem>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(Update) */
  updateOperationalStockEvent?: Maybe<OperationalStockEvent>;
  /** Product model(Update) */
  updateProduct?: Maybe<Product>;
  /** Product Image(Update) */
  updateProductImage?: Maybe<ProductImage>;
  /** The variants of a product(Update) */
  updateProductVariant?: Maybe<ProductVariant>;
  /** PurchaseOrder model(Update) */
  updatePurchaseOrder?: Maybe<PurchaseOrder>;
  /** PurchaseOrderLineItem model(Update) */
  updatePurchaseOrderLineItem?: Maybe<PurchaseOrderLineItem>;
  /** Receipt model(Update) */
  updateReceipt?: Maybe<Receipt>;
  /** ReceiptLineItem model(Update) */
  updateReceiptLineItem?: Maybe<ReceiptLineItem>;
  /** User Roles(Update) */
  updateRole?: Maybe<Role>;
  /** SalesOrder model(Update) */
  updateSalesOrder?: Maybe<SalesOrder>;
  /** SalesOrderLineItem model(Update) */
  updateSalesOrderLineItem?: Maybe<SalesOrderLineItem>;
  /** Shipment model(Update) */
  updateShipment?: Maybe<Shipment>;
  /** ShipmentLineItem model(Update) */
  updateShipmentLineItem?: Maybe<ShipmentLineItem>;
  /** StockSummary model(Update) */
  updateStockSummary?: Maybe<StockSummary>;
  /** Unit of Measure(Update) */
  updateUom?: Maybe<Uom>;
  /** UOMConversion description(Update) */
  updateUomConversion?: Maybe<UomConversion>;
  /** User of the system(Update) */
  updateUser?: Maybe<User>;
  /** Time tracking by employee(Update) */
  updateWOTimeTracking?: Maybe<WoTimeTracking>;
  /** Work Center are the physical locations where the production happens(Update) */
  updateWorkCenter?: Maybe<WorkCenter>;
  /** The actual work order which is created based on the Bom requirement(Update) */
  updateWorkOrder?: Maybe<WorkOrder>;
  /** To know the dependency of workOrder(Update) */
  updateWorkOrderDependency?: Maybe<WorkOrderDependency>;
  /** Represents a line item in a work order(Update) */
  updateWorkOrderLineItem?: Maybe<WorkOrderLineItem>;
  /** Status tracking of work order(Update) */
  updateWorkOrderTransition?: Maybe<WorkOrderTransition>;
  /** Used to define the hours during which a work center will be available(Update) */
  updateWorkingHour?: Maybe<WorkingHour>;
  validateBomItemWithOperations?: Maybe<ValidateBomItemWithOperationsOutput>;
  workOrderStatusTransitionRecord?: Maybe<WorkOrderStatusTransitionRecordOutput>;
};


export type MutationAddBatchMoArgs = {
  input: AddBatchMoInput;
};


export type MutationAllocateCostArgs = {
  input: AllocateCostInput;
};


export type MutationAllocateInventoryItemArgs = {
  input: AllocateInventoryItemInput;
};


export type MutationBulkUpsertBomLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<BomLineItemCreateInput>>>;
};


export type MutationBulkUpsertBomLineItemsByArgs = {
  field: BulkUpsertBomLineItemByFieldEnum;
  input: Array<BomLineItemCreateInput>;
};


export type MutationBulkUpsertContactsArgs = {
  input?: InputMaybe<Array<InputMaybe<ContactCreateInput>>>;
};


export type MutationBulkUpsertContactsByArgs = {
  field: BulkUpsertContactByFieldEnum;
  input: Array<ContactCreateInput>;
};


export type MutationBulkUpsertCostPoolLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<CostPoolLineItemCreateInput>>>;
};


export type MutationBulkUpsertCostPoolLineItemsByArgs = {
  field: BulkUpsertCostPoolLineItemByFieldEnum;
  input: Array<CostPoolLineItemCreateInput>;
};


export type MutationBulkUpsertDailySchedulesArgs = {
  input?: InputMaybe<Array<InputMaybe<DailyScheduleCreateInput>>>;
};


export type MutationBulkUpsertDailySchedulesByArgs = {
  field: BulkUpsertDailyScheduleByFieldEnum;
  input: Array<DailyScheduleCreateInput>;
};


export type MutationBulkUpsertEmployeesArgs = {
  input?: InputMaybe<Array<InputMaybe<EmployeeCreateInput>>>;
};


export type MutationBulkUpsertEmployeesByArgs = {
  field: BulkUpsertEmployeeByFieldEnum;
  input: Array<EmployeeCreateInput>;
};


export type MutationBulkUpsertFinancialStockSummariesArgs = {
  input?: InputMaybe<Array<InputMaybe<FinancialStockSummaryCreateInput>>>;
};


export type MutationBulkUpsertFinancialStockSummariesByArgs = {
  field: BulkUpsertFinancialStockSummaryByFieldEnum;
  input: Array<FinancialStockSummaryCreateInput>;
};


export type MutationBulkUpsertInventoryItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<InventoryItemCreateInput>>>;
};


export type MutationBulkUpsertInventoryItemsByArgs = {
  field: BulkUpsertInventoryItemByFieldEnum;
  input: Array<InventoryItemCreateInput>;
};


export type MutationBulkUpsertInvoiceLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<InvoiceLineItemCreateInput>>>;
};


export type MutationBulkUpsertInvoiceLineItemsByArgs = {
  field: BulkUpsertInvoiceLineItemByFieldEnum;
  input: Array<InvoiceLineItemCreateInput>;
};


export type MutationBulkUpsertItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<ItemCreateInput>>>;
};


export type MutationBulkUpsertItemsByArgs = {
  field: BulkUpsertItemByFieldEnum;
  input: Array<ItemCreateInput>;
};


export type MutationBulkUpsertLocationsArgs = {
  input?: InputMaybe<Array<InputMaybe<LocationCreateInput>>>;
};


export type MutationBulkUpsertLocationsByArgs = {
  field: BulkUpsertLocationByFieldEnum;
  input: Array<LocationCreateInput>;
};


export type MutationBulkUpsertMoLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<MoLineItemCreateInput>>>;
};


export type MutationBulkUpsertMoLineItemsByArgs = {
  field: BulkUpsertMoLineItemByFieldEnum;
  input: Array<MoLineItemCreateInput>;
};


export type MutationBulkUpsertManufacturingOrderTransitionsArgs = {
  input?: InputMaybe<Array<InputMaybe<ManufacturingOrderTransitionCreateInput>>>;
};


export type MutationBulkUpsertManufacturingOrderTransitionsByArgs = {
  field: BulkUpsertManufacturingOrderTransitionByFieldEnum;
  input: Array<ManufacturingOrderTransitionCreateInput>;
};


export type MutationBulkUpsertOperationDependenciesArgs = {
  input?: InputMaybe<Array<InputMaybe<OperationDependencyCreateInput>>>;
};


export type MutationBulkUpsertOperationDependenciesByArgs = {
  field: BulkUpsertOperationDependencyByFieldEnum;
  input: Array<OperationDependencyCreateInput>;
};


export type MutationBulkUpsertOperationLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<OperationLineItemCreateInput>>>;
};


export type MutationBulkUpsertOperationLineItemsByArgs = {
  field: BulkUpsertOperationLineItemByFieldEnum;
  input: Array<OperationLineItemCreateInput>;
};


export type MutationBulkUpsertOperationsArgs = {
  input?: InputMaybe<Array<InputMaybe<OperationCreateInput>>>;
};


export type MutationBulkUpsertOperationsByArgs = {
  field: BulkUpsertOperationByFieldEnum;
  input: Array<OperationCreateInput>;
};


export type MutationBulkUpsertProductImagesArgs = {
  input?: InputMaybe<Array<InputMaybe<ProductImageCreateInput>>>;
};


export type MutationBulkUpsertProductImagesByArgs = {
  field: BulkUpsertProductImageByFieldEnum;
  input: Array<ProductImageCreateInput>;
};


export type MutationBulkUpsertProductVariantsArgs = {
  input?: InputMaybe<Array<InputMaybe<ProductVariantCreateInput>>>;
};


export type MutationBulkUpsertProductVariantsByArgs = {
  field: BulkUpsertProductVariantByFieldEnum;
  input: Array<ProductVariantCreateInput>;
};


export type MutationBulkUpsertProductsArgs = {
  input?: InputMaybe<Array<InputMaybe<ProductCreateInput>>>;
};


export type MutationBulkUpsertProductsByArgs = {
  field: BulkUpsertProductByFieldEnum;
  input: Array<ProductCreateInput>;
};


export type MutationBulkUpsertPurchaseOrderLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<PurchaseOrderLineItemCreateInput>>>;
};


export type MutationBulkUpsertPurchaseOrderLineItemsByArgs = {
  field: BulkUpsertPurchaseOrderLineItemByFieldEnum;
  input: Array<PurchaseOrderLineItemCreateInput>;
};


export type MutationBulkUpsertReceiptLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<ReceiptLineItemCreateInput>>>;
};


export type MutationBulkUpsertReceiptLineItemsByArgs = {
  field: BulkUpsertReceiptLineItemByFieldEnum;
  input: Array<ReceiptLineItemCreateInput>;
};


export type MutationBulkUpsertSalesOrderLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<SalesOrderLineItemCreateInput>>>;
};


export type MutationBulkUpsertSalesOrderLineItemsByArgs = {
  field: BulkUpsertSalesOrderLineItemByFieldEnum;
  input: Array<SalesOrderLineItemCreateInput>;
};


export type MutationBulkUpsertSalesOrdersArgs = {
  input?: InputMaybe<Array<InputMaybe<SalesOrderCreateInput>>>;
};


export type MutationBulkUpsertSalesOrdersByArgs = {
  field: BulkUpsertSalesOrderByFieldEnum;
  input: Array<SalesOrderCreateInput>;
};


export type MutationBulkUpsertShipmentLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<ShipmentLineItemCreateInput>>>;
};


export type MutationBulkUpsertShipmentLineItemsByArgs = {
  field: BulkUpsertShipmentLineItemByFieldEnum;
  input: Array<ShipmentLineItemCreateInput>;
};


export type MutationBulkUpsertUomConversionsArgs = {
  input?: InputMaybe<Array<InputMaybe<UomConversionCreateInput>>>;
};


export type MutationBulkUpsertUomConversionsByArgs = {
  field: BulkUpsertUomConversionByFieldEnum;
  input: Array<UomConversionCreateInput>;
};


export type MutationBulkUpsertUomsArgs = {
  input?: InputMaybe<Array<InputMaybe<UomCreateInput>>>;
};


export type MutationBulkUpsertUomsByArgs = {
  field: BulkUpsertUomByFieldEnum;
  input: Array<UomCreateInput>;
};


export type MutationBulkUpsertWoTimeTrackingsArgs = {
  input?: InputMaybe<Array<InputMaybe<WoTimeTrackingCreateInput>>>;
};


export type MutationBulkUpsertWoTimeTrackingsByArgs = {
  field: BulkUpsertWoTimeTrackingByFieldEnum;
  input: Array<WoTimeTrackingCreateInput>;
};


export type MutationBulkUpsertWorkCentersArgs = {
  input?: InputMaybe<Array<InputMaybe<WorkCenterCreateInput>>>;
};


export type MutationBulkUpsertWorkCentersByArgs = {
  field: BulkUpsertWorkCenterByFieldEnum;
  input: Array<WorkCenterCreateInput>;
};


export type MutationBulkUpsertWorkOrderDependenciesArgs = {
  input?: InputMaybe<Array<InputMaybe<WorkOrderDependencyCreateInput>>>;
};


export type MutationBulkUpsertWorkOrderDependenciesByArgs = {
  field: BulkUpsertWorkOrderDependencyByFieldEnum;
  input: Array<WorkOrderDependencyCreateInput>;
};


export type MutationBulkUpsertWorkOrderLineItemsArgs = {
  input?: InputMaybe<Array<InputMaybe<WorkOrderLineItemCreateInput>>>;
};


export type MutationBulkUpsertWorkOrderLineItemsByArgs = {
  field: BulkUpsertWorkOrderLineItemByFieldEnum;
  input: Array<WorkOrderLineItemCreateInput>;
};


export type MutationBulkUpsertWorkOrderTransitionsArgs = {
  input?: InputMaybe<Array<InputMaybe<WorkOrderTransitionCreateInput>>>;
};


export type MutationBulkUpsertWorkOrderTransitionsByArgs = {
  field: BulkUpsertWorkOrderTransitionByFieldEnum;
  input: Array<WorkOrderTransitionCreateInput>;
};


export type MutationBulkUpsertWorkOrdersArgs = {
  input?: InputMaybe<Array<InputMaybe<WorkOrderCreateInput>>>;
};


export type MutationBulkUpsertWorkOrdersByArgs = {
  field: BulkUpsertWorkOrderByFieldEnum;
  input: Array<WorkOrderCreateInput>;
};


export type MutationBulkUpsertWorkingHoursArgs = {
  input?: InputMaybe<Array<InputMaybe<WorkingHourCreateInput>>>;
};


export type MutationBulkUpsertWorkingHoursByArgs = {
  field: BulkUpsertWorkingHourByFieldEnum;
  input: Array<WorkingHourCreateInput>;
};


export type MutationCalculateStockEventAndUpdateStockSummaryArgs = {
  input: CalculateStockEventAndUpdateStockSummaryInput;
};


export type MutationCancelManufacturingOrderArgs = {
  input: CancelManufacturingOrderInput;
};


export type MutationCancelWorkOrderArgs = {
  input: CancelWorkOrderInput;
};


export type MutationChangeBomArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeBomLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeContactArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeCostPoolArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeCostPoolLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeDailyScheduleArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeEmployeeArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeFinancialStockEventArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeFinancialStockSummaryArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeInventoryItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeInventoryLevelArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeInvoiceArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeInvoiceLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeLocationArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeMoBatchArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeMoLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeManufacturingOrderArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeManufacturingOrderTransitionArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeOperationArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeOperationDependencyArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeOperationLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeOperationalStockEventArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeProductArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeProductImageArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeProductVariantArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangePurchaseOrderArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangePurchaseOrderLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeReceiptArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeReceiptLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeRoleArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeSalesOrderArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeSalesOrderLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeShipmentArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeShipmentLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeStockSummaryArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeUomArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeUomConversionArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeUserArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeWoTimeTrackingArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeWorkCenterArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeWorkOrderArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeWorkOrderDependencyArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeWorkOrderLineItemArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeWorkOrderTransitionArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationChangeWorkingHourArgs = {
  delete?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  id: Scalars['ID']['input'];
  read?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
  update?: InputMaybe<Array<InputMaybe<PermissionItemInput>>>;
};


export type MutationComputeWorkOrderCostRealDurationArgs = {
  input: ComputeWorkOrderCostRealDurationInput;
};


export type MutationConfigureBomItemsWithOperationArgs = {
  input: ConfigureBomItemsWithOperationInput;
};


export type MutationConsumeAllocatedInventoryItemArgs = {
  input: ConsumeAllocatedInventoryItemInput;
};


export type MutationConsumeInventoryItemArgs = {
  input: ConsumeInventoryItemInput;
};


export type MutationCreateBomArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<BomCreateInput>;
};


export type MutationCreateBomLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<BomLineItemCreateInput>;
};


export type MutationCreateContactArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ContactCreateInput>;
};


export type MutationCreateCostPoolArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<CostPoolCreateInput>;
};


export type MutationCreateCostPoolLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<CostPoolLineItemCreateInput>;
};


export type MutationCreateDailyScheduleArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<DailyScheduleCreateInput>;
};


export type MutationCreateEmployeeArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<EmployeeCreateInput>;
};


export type MutationCreateFinancialStockEventArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<FinancialStockEventCreateInput>;
};


export type MutationCreateFinancialStockSummaryArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<FinancialStockSummaryCreateInput>;
};


export type MutationCreateInventoryItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<InventoryItemCreateInput>;
};


export type MutationCreateInventoryLevelArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<InventoryLevelCreateInput>;
};


export type MutationCreateInvoiceArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<InvoiceCreateInput>;
};


export type MutationCreateInvoiceFromShipmentArgs = {
  input: CreateInvoiceFromShipmentInput;
};


export type MutationCreateInvoiceLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<InvoiceLineItemCreateInput>;
};


export type MutationCreateItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ItemCreateInput>;
};


export type MutationCreateLocationArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<LocationCreateInput>;
};


export type MutationCreateMoBatchArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<MoBatchCreateInput>;
};


export type MutationCreateMoLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<MoLineItemCreateInput>;
};


export type MutationCreateManufacturingOrderArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ManufacturingOrderCreateInput>;
};


export type MutationCreateManufacturingOrderAndWorkOrdersArgs = {
  input: CreateManufacturingInput;
};


export type MutationCreateManufacturingOrderTransitionArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ManufacturingOrderTransitionCreateInput>;
};


export type MutationCreateNestedManufacturingOrderArgs = {
  input: CreateNestedManufacturingOrderInput;
};


export type MutationCreateOperationArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<OperationCreateInput>;
};


export type MutationCreateOperationDependencyArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<OperationDependencyCreateInput>;
};


export type MutationCreateOperationLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<OperationLineItemCreateInput>;
};


export type MutationCreateOperationalStockEventArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<OperationalStockEventCreateInput>;
};


export type MutationCreateProductArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ProductCreateInput>;
};


export type MutationCreateProductImageArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ProductImageCreateInput>;
};


export type MutationCreateProductVariantArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ProductVariantCreateInput>;
};


export type MutationCreatePurchaseOrderArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<PurchaseOrderCreateInput>;
};


export type MutationCreatePurchaseOrderLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<PurchaseOrderLineItemCreateInput>;
};


export type MutationCreateReceiptArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ReceiptCreateInput>;
};


export type MutationCreateReceiptFromPurchaseOrderArgs = {
  input: CreateReceiptFromPurchaseOrderInput;
};


export type MutationCreateReceiptLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ReceiptLineItemCreateInput>;
};


export type MutationCreateRoleArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<RoleCreateInput>;
};


export type MutationCreateSalesOrderArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<SalesOrderCreateInput>;
};


export type MutationCreateSalesOrderLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<SalesOrderLineItemCreateInput>;
};


export type MutationCreateShipmentArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ShipmentCreateInput>;
};


export type MutationCreateShipmentFromSalesOrderArgs = {
  input: CreateShipmentFromSalesOrderInput;
};


export type MutationCreateShipmentLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<ShipmentLineItemCreateInput>;
};


export type MutationCreateStockEventsFromReceiptLineItemsArgs = {
  input: CreateStockEventsFromReceiptLineItemsInput;
};


export type MutationCreateStockEventsFromShipmentLineItemsArgs = {
  input: CreateStockEventsFromShipmentLineItemsInput;
};


export type MutationCreateStockSummaryArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<StockSummaryCreateInput>;
};


export type MutationCreateUomArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<UomCreateInput>;
};


export type MutationCreateUomConversionArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<UomConversionCreateInput>;
};


export type MutationCreateUserArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<UserCreateInput>;
};


export type MutationCreateWoTimeTrackingArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<WoTimeTrackingCreateInput>;
};


export type MutationCreateWorkCenterArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<WorkCenterCreateInput>;
};


export type MutationCreateWorkOrderArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<WorkOrderCreateInput>;
};


export type MutationCreateWorkOrderDependencyArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<WorkOrderDependencyCreateInput>;
};


export type MutationCreateWorkOrderLineItemArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<WorkOrderLineItemCreateInput>;
};


export type MutationCreateWorkOrderTransitionArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<WorkOrderTransitionCreateInput>;
};


export type MutationCreateWorkingHourArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  input?: InputMaybe<WorkingHourCreateInput>;
};


export type MutationDeleteBomArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteBomLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteContactArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteCostPoolArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteCostPoolLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteDailyScheduleArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteEmployeeArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteFinancialStockEventArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteFinancialStockSummaryArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteInventoryItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteInventoryLevelArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteInvoiceArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteInvoiceLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteLocationArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteMoBatchArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteMoLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteManufacturingOrderArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteManufacturingOrderTransitionArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteOperationArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteOperationDependencyArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteOperationLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteOperationalStockEventArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteProductArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteProductImageArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteProductVariantArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeletePurchaseOrderArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeletePurchaseOrderLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteReceiptArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteReceiptLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteRoleArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteSalesOrderArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteSalesOrderLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteShipmentArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteShipmentLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteStockSummaryArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteUomArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteUomConversionArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteUserArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteWoTimeTrackingArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteWorkCenterArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteWorkOrderArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteWorkOrderDependencyArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteWorkOrderLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteWorkOrderTransitionArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteWorkingHourArgs = {
  id: Scalars['ID']['input'];
};


export type MutationManufacturingOrderStatusTransitionRecordArgs = {
  input: ManufacturingOrderStatusTransitionRecordInput;
};


export type MutationMoveWoToFinishArgs = {
  input: MoveWoToFinishInput;
};


export type MutationMoveWoToInProgressArgs = {
  input: MoveWoToInProgressInput;
};


export type MutationMoveWoToReadyArgs = {
  input: MoveWoToReadyInput;
};


export type MutationMoveWoToWaitingForComponentsArgs = {
  input: MoveWoToWaitingForComponentsInput;
};


export type MutationPlanBatchManufacturingOrderArgs = {
  input: PlanBatchManufacturingOrderInput;
};


export type MutationPlanManufacturingOrderArgs = {
  input: PlanManufacturingOrderInput;
};


export type MutationRemoveAllocatedInventoryItemArgs = {
  input: RemoveAllocatedInventoryItemInput;
};


export type MutationRemoveBatchManufacturingOrderArgs = {
  input: RemoveBatchManufacturingOrderInput;
};


export type MutationRemoveManufacturingOrderArgs = {
  input: RemoveManufacturingOrderInput;
};


export type MutationScrapConsumedInventoryItemArgs = {
  input: ScrapConsumedInventoryItemInput;
};


export type MutationSetWorkOrderStartAndEndDateArgs = {
  input: SetWorkOrderStartAndEndDateInput;
};


export type MutationUnPlanBatchManufacturingOrderArgs = {
  input: UnplanBatchManufacturingOrderInput;
};


export type MutationUnPlanManufacturingOrderArgs = {
  input: UnPlanManufacturingOrderInput;
};


export type MutationUpdateBomArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<BomUpdateInput>;
};


export type MutationUpdateBomLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<BomLineItemUpdateInput>;
};


export type MutationUpdateContactArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ContactUpdateInput>;
};


export type MutationUpdateCostPoolArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<CostPoolUpdateInput>;
};


export type MutationUpdateCostPoolLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<CostPoolLineItemUpdateInput>;
};


export type MutationUpdateDailyScheduleArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<DailyScheduleUpdateInput>;
};


export type MutationUpdateEmployeeArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<EmployeeUpdateInput>;
};


export type MutationUpdateFinancialStockEventArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<FinancialStockEventUpdateInput>;
};


export type MutationUpdateFinancialStockSummaryArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<FinancialStockSummaryUpdateInput>;
};


export type MutationUpdateInventoryItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<InventoryItemUpdateInput>;
};


export type MutationUpdateInventoryLevelArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<InventoryLevelUpdateInput>;
};


export type MutationUpdateInvoiceArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<InvoiceUpdateInput>;
};


export type MutationUpdateInvoiceLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<InvoiceLineItemUpdateInput>;
};


export type MutationUpdateItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ItemUpdateInput>;
};


export type MutationUpdateLocationArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<LocationUpdateInput>;
};


export type MutationUpdateMoBatchArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<MoBatchUpdateInput>;
};


export type MutationUpdateMoLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<MoLineItemUpdateInput>;
};


export type MutationUpdateManufacturingOrderArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ManufacturingOrderUpdateInput>;
};


export type MutationUpdateManufacturingOrderBatchStatusArgs = {
  input: UpdateManufacturingOrderBatchStatusInput;
};


export type MutationUpdateManufacturingOrderStatusArgs = {
  input: UpdateManufacturingOrderStatusInput;
};


export type MutationUpdateManufacturingOrderTransitionArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ManufacturingOrderTransitionUpdateInput>;
};


export type MutationUpdateOperationArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<OperationUpdateInput>;
};


export type MutationUpdateOperationDependencyArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<OperationDependencyUpdateInput>;
};


export type MutationUpdateOperationLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<OperationLineItemUpdateInput>;
};


export type MutationUpdateOperationalStockEventArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<OperationalStockEventUpdateInput>;
};


export type MutationUpdateProductArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ProductUpdateInput>;
};


export type MutationUpdateProductImageArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ProductImageUpdateInput>;
};


export type MutationUpdateProductVariantArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ProductVariantUpdateInput>;
};


export type MutationUpdatePurchaseOrderArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<PurchaseOrderUpdateInput>;
};


export type MutationUpdatePurchaseOrderLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<PurchaseOrderLineItemUpdateInput>;
};


export type MutationUpdateReceiptArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ReceiptUpdateInput>;
};


export type MutationUpdateReceiptLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ReceiptLineItemUpdateInput>;
};


export type MutationUpdateRoleArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<RoleUpdateInput>;
};


export type MutationUpdateSalesOrderArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<SalesOrderUpdateInput>;
};


export type MutationUpdateSalesOrderLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<SalesOrderLineItemUpdateInput>;
};


export type MutationUpdateShipmentArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ShipmentUpdateInput>;
};


export type MutationUpdateShipmentLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<ShipmentLineItemUpdateInput>;
};


export type MutationUpdateStockSummaryArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<StockSummaryUpdateInput>;
};


export type MutationUpdateUomArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<UomUpdateInput>;
};


export type MutationUpdateUomConversionArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<UomConversionUpdateInput>;
};


export type MutationUpdateUserArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<UserUpdateInput>;
};


export type MutationUpdateWoTimeTrackingArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<WoTimeTrackingUpdateInput>;
};


export type MutationUpdateWorkCenterArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<WorkCenterUpdateInput>;
};


export type MutationUpdateWorkOrderArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<WorkOrderUpdateInput>;
};


export type MutationUpdateWorkOrderDependencyArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<WorkOrderDependencyUpdateInput>;
};


export type MutationUpdateWorkOrderLineItemArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<WorkOrderLineItemUpdateInput>;
};


export type MutationUpdateWorkOrderTransitionArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<WorkOrderTransitionUpdateInput>;
};


export type MutationUpdateWorkingHourArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<WorkingHourUpdateInput>;
};


export type MutationValidateBomItemWithOperationsArgs = {
  input: ValidateBomItemWithOperationsInput;
};


export type MutationWorkOrderStatusTransitionRecordArgs = {
  input: WorkOrderStatusTransitionRecordInput;
};

/** A Specific operation that needs to be performed at a bom */
export type Operation = {
  __typename?: 'Operation';
  /** Link to the BOM */
  bom?: Maybe<Bom>;
  /** associated bomId */
  bomId: Scalars['ID']['output'];
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** The task that needs to be done as part of the operation */
  description?: Maybe<Scalars['String']['output']>;
  /** The link to the document that is to be referred. */
  documentUrl?: Maybe<Scalars['String']['output']>;
  /** Duration in minutes for the operation */
  duration: Scalars['Int']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /** Is the operation active? */
  isActive?: Maybe<Scalars['Boolean']['output']>;
  /** Operation Name */
  name: Scalars['String']['output'];
  /** sequence order description */
  order?: Maybe<Scalars['Int']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Link to the WorkCenter at which the operation is to be performed */
  workCenter?: Maybe<WorkCenter>;
  /** ID of the WorkCenter at which the operation is to be performed */
  workCenterId: Scalars['ID']['output'];
};

/** A Specific operation that needs to be performed at a bom(Connection) */
export type OperationConnection = {
  __typename?: 'OperationConnection';
  edges: Array<OperationEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** A Specific operation that needs to be performed at a bom(CreateInput) */
export type OperationCreateInput = {
  /** associated bomId */
  bomId: Scalars['ID']['input'];
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** The task that needs to be done as part of the operation */
  description?: InputMaybe<Scalars['String']['input']>;
  /** The link to the document that is to be referred. */
  documentUrl?: InputMaybe<Scalars['String']['input']>;
  /** Duration in minutes for the operation */
  duration: Scalars['Int']['input'];
  /** ID of the A Specific operation that needs to be performed at a bom */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Is the operation active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Operation Name */
  name: Scalars['String']['input'];
  /** sequence order description */
  order?: InputMaybe<Scalars['Int']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the WorkCenter at which the operation is to be performed */
  workCenterId: Scalars['ID']['input'];
};

export type OperationDependenciesCompositeKey = {
  /** Depends On OperationId description */
  dependsOnOperationId: Scalars['ID']['input'];
  /** operationId description */
  operationId: Scalars['ID']['input'];
};

/** To know the dependency of operation */
export type OperationDependency = {
  __typename?: 'OperationDependency';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Depends On OperationId description */
  dependsOnOperation?: Maybe<Operation>;
  /** Depends On OperationId description */
  dependsOnOperationId: Scalars['ID']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /** Link to the Operation */
  operation?: Maybe<Operation>;
  /** operationId description */
  operationId: Scalars['ID']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** To know the dependency of operation(Connection) */
export type OperationDependencyConnection = {
  __typename?: 'OperationDependencyConnection';
  edges: Array<OperationDependencyEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** To know the dependency of operation(CreateInput) */
export type OperationDependencyCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Depends On OperationId description */
  dependsOnOperationId: Scalars['ID']['input'];
  /** ID of the To know the dependency of operation */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** operationId description */
  operationId: Scalars['ID']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** operationDependency(Edge) */
export type OperationDependencyEdge = {
  __typename?: 'OperationDependencyEdge';
  cursor: Scalars['String']['output'];
  node: OperationDependency;
};

export enum OperationDependencyOrderFieldEnum {
  CreatedAt = 'createdAt',
  UpdatedAt = 'updatedAt'
}

export type OperationDependencyOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: OperationDependencyOrderFieldEnum;
};

/** To know the dependency of operation(Input) */
export type OperationDependencyQueryInput = {
  and?: InputMaybe<Array<OperationDependencyQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  dependsOnOperationId?: InputMaybe<UuidFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<OperationDependencyQueryInput>>;
  operationId?: InputMaybe<UuidFilter>;
  or?: InputMaybe<Array<OperationDependencyQueryInput>>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** To know the dependency of operation(UpdateInput) */
export type OperationDependencyUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Depends On OperationId description */
  dependsOnOperationId?: InputMaybe<Scalars['ID']['input']>;
  /** operationId description */
  operationId?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** operation(Edge) */
export type OperationEdge = {
  __typename?: 'OperationEdge';
  cursor: Scalars['String']['output'];
  node: Operation;
};

/** Represents a line item in an operation */
export type OperationLineItem = {
  __typename?: 'OperationLineItem';
  /** Link to the BOM */
  bom?: Maybe<Bom>;
  /** Unique identifier of the associated BOM */
  bomId: Scalars['ID']['output'];
  /** Link to the Item */
  bomLineItem?: Maybe<BomLineItem>;
  /** Unique identifier of the associated Item */
  bomLineItemId: Scalars['ID']['output'];
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Link to the Operation */
  operation?: Maybe<Operation>;
  /** Unique identifier of the associated Operation */
  operationId: Scalars['ID']['output'];
  /** Quantity */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** Link to the Item to return as new SKU */
  returnAsNewSkuItem?: Maybe<Item>;
  /** Unique identifier of the associated Item for returning as new SKU */
  returnAsNewSkuItemId?: Maybe<Scalars['ID']['output']>;
  /** Scrap action for item */
  scrapAction?: Maybe<OperationLineItemScrapAction>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Represents a line item in an operation(Connection) */
export type OperationLineItemConnection = {
  __typename?: 'OperationLineItemConnection';
  edges: Array<OperationLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Represents a line item in an operation(CreateInput) */
export type OperationLineItemCreateInput = {
  /** Unique identifier of the associated BOM */
  bomId: Scalars['ID']['input'];
  /** Unique identifier of the associated Item */
  bomLineItemId: Scalars['ID']['input'];
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Represents a line item in an operation */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated Operation */
  operationId: Scalars['ID']['input'];
  /** Quantity */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated Item for returning as new SKU */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<OperationLineItemScrapAction>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** operationLineItem(Edge) */
export type OperationLineItemEdge = {
  __typename?: 'OperationLineItemEdge';
  cursor: Scalars['String']['output'];
  node: OperationLineItem;
};

export enum OperationLineItemOrderFieldEnum {
  CreatedAt = 'createdAt',
  Quantity = 'quantity',
  ScrapAction = 'scrapAction',
  UpdatedAt = 'updatedAt'
}

export type OperationLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: OperationLineItemOrderFieldEnum;
};

/** Represents a line item in an operation(Input) */
export type OperationLineItemQueryInput = {
  and?: InputMaybe<Array<OperationLineItemQueryInput>>;
  bomId?: InputMaybe<UuidFilter>;
  bomLineItemId?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<OperationLineItemQueryInput>>;
  operationId?: InputMaybe<UuidFilter>;
  or?: InputMaybe<Array<OperationLineItemQueryInput>>;
  quantity?: InputMaybe<IntegerFilter>;
  returnAsNewSkuItemId?: InputMaybe<UuidFilter>;
  scrapAction?: InputMaybe<OperationLineItemScrapActionEnumFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

export enum OperationLineItemScrapAction {
  /** Return */
  Return = 'Return',
  /** Return as new SKU */
  ReturnAsNewSku = 'Return_as_new_SKU',
  /** Waste */
  Waste = 'Waste'
}

export type OperationLineItemScrapActionEnumFilter = {
  eq?: InputMaybe<OperationLineItemScrapAction>;
  in?: InputMaybe<Array<InputMaybe<OperationLineItemScrapAction>>>;
  ne?: InputMaybe<OperationLineItemScrapAction>;
  nin?: InputMaybe<Array<InputMaybe<OperationLineItemScrapAction>>>;
};

/** Represents a line item in an operation(UpdateInput) */
export type OperationLineItemUpdateInput = {
  /** Unique identifier of the associated BOM */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated Item */
  bomLineItemId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Unique identifier of the associated Operation */
  operationId?: InputMaybe<Scalars['ID']['input']>;
  /** Quantity */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated Item for returning as new SKU */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<OperationLineItemScrapAction>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export enum OperationOrderFieldEnum {
  CreatedAt = 'createdAt',
  Description = 'description',
  DocumentUrl = 'documentUrl',
  Duration = 'duration',
  IsActive = 'isActive',
  Name = 'name',
  Order = 'order',
  UpdatedAt = 'updatedAt'
}

export type OperationOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: OperationOrderFieldEnum;
};

/** A Specific operation that needs to be performed at a bom(Input) */
export type OperationQueryInput = {
  and?: InputMaybe<Array<OperationQueryInput>>;
  bomId?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  description?: InputMaybe<StringFilter>;
  documentUrl?: InputMaybe<StringFilter>;
  duration?: InputMaybe<IntegerFilter>;
  id?: InputMaybe<UuidFilter>;
  isActive?: InputMaybe<BoolFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<OperationQueryInput>>;
  or?: InputMaybe<Array<OperationQueryInput>>;
  order?: InputMaybe<IntegerFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  workCenterId?: InputMaybe<UuidFilter>;
};

/** A Specific operation that needs to be performed at a bom(UpdateInput) */
export type OperationUpdateInput = {
  /** associated bomId */
  bomId?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** The task that needs to be done as part of the operation */
  description?: InputMaybe<Scalars['String']['input']>;
  /** The link to the document that is to be referred. */
  documentUrl?: InputMaybe<Scalars['String']['input']>;
  /** Duration in minutes for the operation */
  duration?: InputMaybe<Scalars['Int']['input']>;
  /** Is the operation active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Operation Name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** sequence order description */
  order?: InputMaybe<Scalars['Int']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the WorkCenter at which the operation is to be performed */
  workCenterId?: InputMaybe<Scalars['ID']['input']>;
};

/** OperationalStockEvent model. Holds the stock event data that can change. */
export type OperationalStockEvent = {
  __typename?: 'OperationalStockEvent';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. Available for sale quantity. */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. If the stock event is copied to the financial ledger. */
  copiedToFinancialLedger?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** incrementalQuantity */
  incrementalQuantity: Scalars['Float']['output'];
  /** isOnHold */
  isOnHold: Scalars['Boolean']['output'];
  /** DO NOT UPDATE FROM THE FRONT END. Quantity of the product that is on hold. */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  /** ReceiptLineItem model. ReceiptLineItem and this model is 1:1. One stock event is only related o either one receipt or shipment */
  receiptLineItem?: Maybe<ReceiptLineItem>;
  /** ReceiptLineItem where the StockEvent come from */
  receiptLineItemID?: Maybe<Scalars['ID']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. Sequence of the stock event. */
  sequence?: Maybe<Scalars['Int']['output']>;
  /** ShipmentLineItem model. ShipmentLineItem and this model is 1:1. One stock event is only related o either one receipt or shipment. */
  shipmentLineItem?: Maybe<ShipmentLineItem>;
  /** Shipment where the StockEvents come from */
  shipmentLineItemID?: Maybe<Scalars['ID']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Total cost of the product at the time of the event */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /** transactionTotalCost */
  transactionTotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost */
  unitCost: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID: Scalars['ID']['output'];
};

/** OperationalStockEvent model. Holds the stock event data that can change.(Connection) */
export type OperationalStockEventConnection = {
  __typename?: 'OperationalStockEventConnection';
  edges: Array<OperationalStockEventEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** OperationalStockEvent model. Holds the stock event data that can change.(CreateInput) */
export type OperationalStockEventCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. Available for sale quantity. */
  availableQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. If the stock event is copied to the financial ledger. */
  copiedToFinancialLedger?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the OperationalStockEvent model. Holds the stock event data that can change. */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** incrementalQuantity */
  incrementalQuantity: Scalars['Float']['input'];
  /** isOnHold */
  isOnHold: Scalars['Boolean']['input'];
  /** DO NOT UPDATE FROM THE FRONT END. Quantity of the product that is on hold. */
  onHoldQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** ReceiptLineItem where the StockEvent come from */
  receiptLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. Sequence of the stock event. */
  sequence?: InputMaybe<Scalars['Int']['input']>;
  /** Shipment where the StockEvents come from */
  shipmentLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Total cost of the product at the time of the event */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** transactionTotalCost */
  transactionTotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCost */
  unitCost: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID: Scalars['ID']['input'];
};

/** operationalStockEvent(Edge) */
export type OperationalStockEventEdge = {
  __typename?: 'OperationalStockEventEdge';
  cursor: Scalars['String']['output'];
  node: OperationalStockEvent;
};

export enum OperationalStockEventOrderFieldEnum {
  Active = 'active',
  AvailableQuantity = 'availableQuantity',
  AverageCost = 'averageCost',
  CopiedToFinancialLedger = 'copiedToFinancialLedger',
  CreatedAt = 'createdAt',
  InStockQuantity = 'inStockQuantity',
  IncrementalQuantity = 'incrementalQuantity',
  IsOnHold = 'isOnHold',
  OnHoldQuantity = 'onHoldQuantity',
  Sequence = 'sequence',
  TotalCost = 'totalCost',
  TransactionTotalCost = 'transactionTotalCost',
  UnitCost = 'unitCost',
  UpdatedAt = 'updatedAt'
}

export type OperationalStockEventOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: OperationalStockEventOrderFieldEnum;
};

/** OperationalStockEvent model. Holds the stock event data that can change.(Input) */
export type OperationalStockEventQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<OperationalStockEventQueryInput>>;
  availableQuantity?: InputMaybe<FloatFilter>;
  averageCost?: InputMaybe<FloatFilter>;
  copiedToFinancialLedger?: InputMaybe<BoolFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  inStockQuantity?: InputMaybe<FloatFilter>;
  incrementalQuantity?: InputMaybe<FloatFilter>;
  isOnHold?: InputMaybe<BoolFilter>;
  not?: InputMaybe<Array<OperationalStockEventQueryInput>>;
  onHoldQuantity?: InputMaybe<FloatFilter>;
  or?: InputMaybe<Array<OperationalStockEventQueryInput>>;
  receiptLineItemID?: InputMaybe<UuidFilter>;
  sequence?: InputMaybe<IntegerFilter>;
  shipmentLineItemID?: InputMaybe<UuidFilter>;
  totalCost?: InputMaybe<FloatFilter>;
  transactionTotalCost?: InputMaybe<FloatFilter>;
  unitCost?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

/** OperationalStockEvent model. Holds the stock event data that can change.(UpdateInput) */
export type OperationalStockEventUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. Available for sale quantity. */
  availableQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. If the stock event is copied to the financial ledger. */
  copiedToFinancialLedger?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** incrementalQuantity */
  incrementalQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** isOnHold */
  isOnHold?: InputMaybe<Scalars['Boolean']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. Quantity of the product that is on hold. */
  onHoldQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** ReceiptLineItem where the StockEvent come from */
  receiptLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. Sequence of the stock event. */
  sequence?: InputMaybe<Scalars['Int']['input']>;
  /** Shipment where the StockEvents come from */
  shipmentLineItemID?: InputMaybe<Scalars['ID']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Total cost of the product at the time of the event */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** transactionTotalCost */
  transactionTotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCost */
  unitCost?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type OperationalStockEventsAggregationAvgResult = {
  __typename?: 'OperationalStockEventsAggregationAvgResult';
  /** availableQuantity is aggregation field */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** averageCost is aggregation field */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /** inStockQuantity is aggregation field */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** incrementalQuantity is aggregation field */
  incrementalQuantity?: Maybe<Scalars['Float']['output']>;
  /** onHoldQuantity is aggregation field */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  /** sequence is aggregation field */
  sequence?: Maybe<Scalars['Float']['output']>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /** transactionTotalCost is aggregation field */
  transactionTotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Float']['output']>;
};

export type OperationalStockEventsAggregationCountResult = {
  __typename?: 'OperationalStockEventsAggregationCountResult';
  /** availableQuantity is aggregation field */
  availableQuantity?: Maybe<Scalars['Int']['output']>;
  /** averageCost is aggregation field */
  averageCost?: Maybe<Scalars['Int']['output']>;
  /** inStockQuantity is aggregation field */
  inStockQuantity?: Maybe<Scalars['Int']['output']>;
  /** incrementalQuantity is aggregation field */
  incrementalQuantity?: Maybe<Scalars['Int']['output']>;
  /** onHoldQuantity is aggregation field */
  onHoldQuantity?: Maybe<Scalars['Int']['output']>;
  /** receiptLineItemID is aggregation field */
  receiptLineItemID?: Maybe<Scalars['Int']['output']>;
  /** sequence is aggregation field */
  sequence?: Maybe<Scalars['Int']['output']>;
  /** shipmentLineItemID is aggregation field */
  shipmentLineItemID?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<OperationalStockEventsAggregationCountToDayFunc>;
  toHour?: Maybe<OperationalStockEventsAggregationCountToHourFunc>;
  toMinute?: Maybe<OperationalStockEventsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<OperationalStockEventsAggregationCountToMonthFunc>;
  toYear?: Maybe<OperationalStockEventsAggregationCountToYearFunc>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Int']['output']>;
  /** transactionTotalCost is aggregation field */
  transactionTotalCost?: Maybe<Scalars['Int']['output']>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Int']['output']>;
  /** variantID is aggregation field */
  variantID?: Maybe<Scalars['Int']['output']>;
};

export type OperationalStockEventsAggregationCountToDayFunc = {
  __typename?: 'OperationalStockEventsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationalStockEventsAggregationCountToHourFunc = {
  __typename?: 'OperationalStockEventsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationalStockEventsAggregationCountToMinuteFunc = {
  __typename?: 'OperationalStockEventsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationalStockEventsAggregationCountToMonthFunc = {
  __typename?: 'OperationalStockEventsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationalStockEventsAggregationCountToYearFunc = {
  __typename?: 'OperationalStockEventsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationalStockEventsAggregationGroupByResult = {
  __typename?: 'OperationalStockEventsAggregationGroupByResult';
  /** DO NOT UPDATE FROM THE FRONT END. Available for sale quantity. */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** incrementalQuantity */
  incrementalQuantity?: Maybe<Scalars['Float']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. Quantity of the product that is on hold. */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  /** ReceiptLineItem where the StockEvent come from */
  receiptLineItemID?: Maybe<Scalars['ID']['output']>;
  /** DO NOT UPDATE FROM THE FRONT END. Sequence of the stock event. */
  sequence?: Maybe<Scalars['Int']['output']>;
  /** Shipment where the StockEvents come from */
  shipmentLineItemID?: Maybe<Scalars['ID']['output']>;
  toDay?: Maybe<OperationalStockEventsAggregationGroupByToDayFunc>;
  toHour?: Maybe<OperationalStockEventsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<OperationalStockEventsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<OperationalStockEventsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<OperationalStockEventsAggregationGroupByToYearFunc>;
  /** DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Total cost of the product at the time of the event */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /** transactionTotalCost */
  transactionTotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost */
  unitCost?: Maybe<Scalars['Float']['output']>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

export type OperationalStockEventsAggregationGroupByToDayFunc = {
  __typename?: 'OperationalStockEventsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationalStockEventsAggregationGroupByToHourFunc = {
  __typename?: 'OperationalStockEventsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationalStockEventsAggregationGroupByToMinuteFunc = {
  __typename?: 'OperationalStockEventsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationalStockEventsAggregationGroupByToMonthFunc = {
  __typename?: 'OperationalStockEventsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationalStockEventsAggregationGroupByToYearFunc = {
  __typename?: 'OperationalStockEventsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationalStockEventsAggregationQuantityResult = {
  __typename?: 'OperationalStockEventsAggregationQuantityResult';
  /** availableQuantity is aggregation field */
  availableQuantity?: Maybe<Scalars['Float']['output']>;
  /** averageCost is aggregation field */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /** inStockQuantity is aggregation field */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** incrementalQuantity is aggregation field */
  incrementalQuantity?: Maybe<Scalars['Float']['output']>;
  /** onHoldQuantity is aggregation field */
  onHoldQuantity?: Maybe<Scalars['Float']['output']>;
  /** sequence is aggregation field */
  sequence?: Maybe<Scalars['Int']['output']>;
  /** totalCost is aggregation field */
  totalCost?: Maybe<Scalars['Float']['output']>;
  /** transactionTotalCost is aggregation field */
  transactionTotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Float']['output']>;
};

export type OperationalStockEventsAggregationResult = {
  __typename?: 'OperationalStockEventsAggregationResult';
  avg?: Maybe<OperationalStockEventsAggregationAvgResult>;
  count?: Maybe<OperationalStockEventsAggregationCountResult>;
  groupBy: OperationalStockEventsAggregationGroupByResult;
  max?: Maybe<OperationalStockEventsAggregationQuantityResult>;
  min?: Maybe<OperationalStockEventsAggregationQuantityResult>;
  sum?: Maybe<OperationalStockEventsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationAvgResult = {
  __typename?: 'OperationsAggregationAvgResult';
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Float']['output']>;
  /** order is aggregation field */
  order?: Maybe<Scalars['Float']['output']>;
};

export type OperationsAggregationCountResult = {
  __typename?: 'OperationsAggregationCountResult';
  /** bomId is aggregation field */
  bomId?: Maybe<Scalars['Int']['output']>;
  /** description is aggregation field */
  description?: Maybe<Scalars['Int']['output']>;
  /** documentUrl is aggregation field */
  documentUrl?: Maybe<Scalars['Int']['output']>;
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Int']['output']>;
  /** name is aggregation field */
  name?: Maybe<Scalars['Int']['output']>;
  /** order is aggregation field */
  order?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<OperationsAggregationCountToDayFunc>;
  toHour?: Maybe<OperationsAggregationCountToHourFunc>;
  toMinute?: Maybe<OperationsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<OperationsAggregationCountToMonthFunc>;
  toYear?: Maybe<OperationsAggregationCountToYearFunc>;
  /** workCenterId is aggregation field */
  workCenterId?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationCountToDayFunc = {
  __typename?: 'OperationsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationCountToHourFunc = {
  __typename?: 'OperationsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationCountToMinuteFunc = {
  __typename?: 'OperationsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationCountToMonthFunc = {
  __typename?: 'OperationsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationCountToYearFunc = {
  __typename?: 'OperationsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationGroupByResult = {
  __typename?: 'OperationsAggregationGroupByResult';
  /** associated bomId */
  bomId?: Maybe<Scalars['ID']['output']>;
  /** The task that needs to be done as part of the operation */
  description?: Maybe<Scalars['String']['output']>;
  /** The link to the document that is to be referred. */
  documentUrl?: Maybe<Scalars['String']['output']>;
  /** Duration in minutes for the operation */
  duration?: Maybe<Scalars['Int']['output']>;
  /** Operation Name */
  name?: Maybe<Scalars['String']['output']>;
  /** sequence order description */
  order?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<OperationsAggregationGroupByToDayFunc>;
  toHour?: Maybe<OperationsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<OperationsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<OperationsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<OperationsAggregationGroupByToYearFunc>;
  /** ID of the WorkCenter at which the operation is to be performed */
  workCenterId?: Maybe<Scalars['ID']['output']>;
};

export type OperationsAggregationGroupByToDayFunc = {
  __typename?: 'OperationsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationsAggregationGroupByToHourFunc = {
  __typename?: 'OperationsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationsAggregationGroupByToMinuteFunc = {
  __typename?: 'OperationsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationsAggregationGroupByToMonthFunc = {
  __typename?: 'OperationsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationsAggregationGroupByToYearFunc = {
  __typename?: 'OperationsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type OperationsAggregationQuantityResult = {
  __typename?: 'OperationsAggregationQuantityResult';
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Int']['output']>;
  /** order is aggregation field */
  order?: Maybe<Scalars['Int']['output']>;
};

export type OperationsAggregationResult = {
  __typename?: 'OperationsAggregationResult';
  avg?: Maybe<OperationsAggregationAvgResult>;
  count?: Maybe<OperationsAggregationCountResult>;
  groupBy: OperationsAggregationGroupByResult;
  max?: Maybe<OperationsAggregationQuantityResult>;
  min?: Maybe<OperationsAggregationQuantityResult>;
  sum?: Maybe<OperationsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum OrderDirectionEnum {
  Asc = 'Asc',
  Desc = 'Desc'
}

/** Information about pagination in a connection */
export type PageInfo = {
  __typename?: 'PageInfo';
  endCursor?: Maybe<Scalars['String']['output']>;
  hasNextPage: Scalars['Boolean']['output'];
  hasPreviousPage: Scalars['Boolean']['output'];
  startCursor?: Maybe<Scalars['String']['output']>;
};

export type Permission = {
  __typename?: 'Permission';
  id?: Maybe<Scalars['ID']['output']>;
  ids?: Maybe<Array<Scalars['ID']['output']>>;
  permit?: Maybe<PermitEnum>;
};

export type PermissionItem = {
  __typename?: 'PermissionItem';
  delete?: Maybe<Array<Maybe<Permission>>>;
  read?: Maybe<Array<Maybe<Permission>>>;
  update?: Maybe<Array<Maybe<Permission>>>;
};

export type PermissionItemInput = {
  id?: InputMaybe<Scalars['ID']['input']>;
  ids?: InputMaybe<Array<Scalars['ID']['input']>>;
  permit?: InputMaybe<PermitEnum>;
};

export enum PermitEnum {
  Allow = 'allow',
  Deny = 'deny'
}

export type PlanManufacturingOrderInput = {
  manufacturingOrderId: Scalars['ID']['input'];
  scheduleDateTime: Scalars['String']['input'];
};

export type PlanManufacturingOrderOutput = {
  __typename?: 'PlanManufacturingOrderOutput';
  endDateTime?: Maybe<Scalars['DateTime']['output']>;
  startDateTime?: Maybe<Scalars['DateTime']['output']>;
  success?: Maybe<Scalars['Boolean']['output']>;
};

/** Product model */
export type Product = {
  __typename?: 'Product';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Product description */
  description?: Maybe<Scalars['String']['output']>;
  /** Featured image of the product */
  featuredImage?: Maybe<ProductImage>;
  /** Featured image ID */
  featuredImageID?: Maybe<Scalars['ID']['output']>;
  /** Product handle */
  handle?: Maybe<Scalars['String']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Shopify product ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /** Product title */
  title?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Product model(Connection) */
export type ProductConnection = {
  __typename?: 'ProductConnection';
  edges: Array<ProductEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Product model(CreateInput) */
export type ProductCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Product description */
  description?: InputMaybe<Scalars['String']['input']>;
  /** Featured image ID */
  featuredImageID?: InputMaybe<Scalars['ID']['input']>;
  /** Product handle */
  handle?: InputMaybe<Scalars['String']['input']>;
  /** ID of the Product model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** Product title */
  title?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** product(Edge) */
export type ProductEdge = {
  __typename?: 'ProductEdge';
  cursor: Scalars['String']['output'];
  node: Product;
};

/** Product Image */
export type ProductImage = {
  __typename?: 'ProductImage';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** Alt text */
  altText?: Maybe<Scalars['String']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Shopify image ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Image URL */
  url?: Maybe<Scalars['String']['output']>;
};

/** Product Image(Connection) */
export type ProductImageConnection = {
  __typename?: 'ProductImageConnection';
  edges: Array<ProductImageEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Product Image(CreateInput) */
export type ProductImageCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Alt text */
  altText?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Product Image */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Shopify image ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Image URL */
  url?: InputMaybe<Scalars['String']['input']>;
};

/** productImage(Edge) */
export type ProductImageEdge = {
  __typename?: 'ProductImageEdge';
  cursor: Scalars['String']['output'];
  node: ProductImage;
};

export enum ProductImageOrderFieldEnum {
  Active = 'active',
  AltText = 'altText',
  CreatedAt = 'createdAt',
  ShopifyId = 'shopifyID',
  UpdatedAt = 'updatedAt',
  Url = 'url'
}

export type ProductImageOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ProductImageOrderFieldEnum;
};

/** Product Image(Input) */
export type ProductImageQueryInput = {
  active?: InputMaybe<BoolFilter>;
  altText?: InputMaybe<StringFilter>;
  and?: InputMaybe<Array<ProductImageQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<ProductImageQueryInput>>;
  or?: InputMaybe<Array<ProductImageQueryInput>>;
  shopifyID?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  url?: InputMaybe<StringFilter>;
};

/** Product Image(UpdateInput) */
export type ProductImageUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Alt text */
  altText?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Shopify image ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Image URL */
  url?: InputMaybe<Scalars['String']['input']>;
};

export enum ProductOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Description = 'description',
  Handle = 'handle',
  ShopifyId = 'shopifyID',
  Title = 'title',
  UpdatedAt = 'updatedAt'
}

export type ProductOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ProductOrderFieldEnum;
};

/** Product model(Input) */
export type ProductQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<ProductQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  description?: InputMaybe<StringFilter>;
  featuredImageID?: InputMaybe<UuidFilter>;
  handle?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<ProductQueryInput>>;
  or?: InputMaybe<Array<ProductQueryInput>>;
  shopifyID?: InputMaybe<StringFilter>;
  title?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Product model(UpdateInput) */
export type ProductUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Product description */
  description?: InputMaybe<Scalars['String']['input']>;
  /** Featured image ID */
  featuredImageID?: InputMaybe<Scalars['ID']['input']>;
  /** Product handle */
  handle?: InputMaybe<Scalars['String']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** Product title */
  title?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** The variants of a product */
export type ProductVariant = {
  __typename?: 'ProductVariant';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** Is the product available for sale */
  availableForSale?: Maybe<Scalars['Boolean']['output']>;
  /** The barcode of the product */
  barcode?: Maybe<Scalars['String']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** The display name of the product */
  displayName?: Maybe<Scalars['String']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** The image of the product variant */
  image?: Maybe<ProductImage>;
  /** The image of the product variant */
  imageID?: Maybe<Scalars['ID']['output']>;
  /** The inventory item of the product */
  inventoryItem?: Maybe<InventoryItem>;
  /** The inventory item ID of the product deprecated */
  inventoryItemID?: Maybe<Scalars['ID']['output']>;
  /** The inventory quantity of the product */
  inventoryQuantity?: Maybe<Scalars['Int']['output']>;
  /** inventoryType */
  inventoryType?: Maybe<ProductVariantInventoryType>;
  /** The price of the product */
  price?: Maybe<Scalars['Float']['output']>;
  /** The product of the product variant */
  product?: Maybe<Product>;
  /** The product ID of the product variant */
  productID?: Maybe<Scalars['ID']['output']>;
  /** The quickbook item ID of the product */
  quickbookItemId?: Maybe<Scalars['String']['output']>;
  /** The quickbook item name of the product */
  quickbookItemName?: Maybe<Scalars['String']['output']>;
  /** The quickbook sync token of the product */
  quickbookSyncToken?: Maybe<Scalars['String']['output']>;
  /** Shopify product ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /** The sku(Stock Keeping Unit) of the product */
  sku?: Maybe<Scalars['String']['output']>;
  /** Is the product taxable */
  taxable?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** The variants of a product(Connection) */
export type ProductVariantConnection = {
  __typename?: 'ProductVariantConnection';
  edges: Array<ProductVariantEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** The variants of a product(CreateInput) */
export type ProductVariantCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Is the product available for sale */
  availableForSale?: InputMaybe<Scalars['Boolean']['input']>;
  /** The barcode of the product */
  barcode?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** The display name of the product */
  displayName?: InputMaybe<Scalars['String']['input']>;
  /** ID of the The variants of a product */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** The image of the product variant */
  imageID?: InputMaybe<Scalars['ID']['input']>;
  /** The inventory item ID of the product deprecated */
  inventoryItemID?: InputMaybe<Scalars['ID']['input']>;
  /** The inventory quantity of the product */
  inventoryQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** inventoryType */
  inventoryType?: InputMaybe<ProductVariantInventoryType>;
  /** The price of the product */
  price?: InputMaybe<Scalars['Float']['input']>;
  /** The product ID of the product variant */
  productID?: InputMaybe<Scalars['ID']['input']>;
  /** The quickbook item ID of the product */
  quickbookItemId?: InputMaybe<Scalars['String']['input']>;
  /** The quickbook item name of the product */
  quickbookItemName?: InputMaybe<Scalars['String']['input']>;
  /** The quickbook sync token of the product */
  quickbookSyncToken?: InputMaybe<Scalars['String']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** The sku(Stock Keeping Unit) of the product */
  sku?: InputMaybe<Scalars['String']['input']>;
  /** Is the product taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** productVariant(Edge) */
export type ProductVariantEdge = {
  __typename?: 'ProductVariantEdge';
  cursor: Scalars['String']['output'];
  node: ProductVariant;
};

export enum ProductVariantInventoryType {
  /** INVENTORY item */
  Inventory = 'INVENTORY',
  /** NONINVENTORY item */
  Noninventory = 'NONINVENTORY'
}

export type ProductVariantInventoryTypeEnumFilter = {
  eq?: InputMaybe<ProductVariantInventoryType>;
  in?: InputMaybe<Array<InputMaybe<ProductVariantInventoryType>>>;
  ne?: InputMaybe<ProductVariantInventoryType>;
  nin?: InputMaybe<Array<InputMaybe<ProductVariantInventoryType>>>;
};

export enum ProductVariantOrderFieldEnum {
  Active = 'active',
  AvailableForSale = 'availableForSale',
  Barcode = 'barcode',
  CreatedAt = 'createdAt',
  DisplayName = 'displayName',
  InventoryQuantity = 'inventoryQuantity',
  InventoryType = 'inventoryType',
  Price = 'price',
  QuickbookItemId = 'quickbookItemId',
  QuickbookItemName = 'quickbookItemName',
  QuickbookSyncToken = 'quickbookSyncToken',
  ShopifyId = 'shopifyID',
  Sku = 'sku',
  Taxable = 'taxable',
  UpdatedAt = 'updatedAt'
}

export type ProductVariantOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ProductVariantOrderFieldEnum;
};

/** The variants of a product(Input) */
export type ProductVariantQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<ProductVariantQueryInput>>;
  availableForSale?: InputMaybe<BoolFilter>;
  barcode?: InputMaybe<StringFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  displayName?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  imageID?: InputMaybe<UuidFilter>;
  inventoryItemID?: InputMaybe<UuidFilter>;
  inventoryQuantity?: InputMaybe<IntegerFilter>;
  inventoryType?: InputMaybe<ProductVariantInventoryTypeEnumFilter>;
  not?: InputMaybe<Array<ProductVariantQueryInput>>;
  or?: InputMaybe<Array<ProductVariantQueryInput>>;
  price?: InputMaybe<FloatFilter>;
  productID?: InputMaybe<UuidFilter>;
  quickbookItemId?: InputMaybe<StringFilter>;
  quickbookItemName?: InputMaybe<StringFilter>;
  quickbookSyncToken?: InputMaybe<StringFilter>;
  shopifyID?: InputMaybe<StringFilter>;
  sku?: InputMaybe<StringFilter>;
  taxable?: InputMaybe<BoolFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** The variants of a product(UpdateInput) */
export type ProductVariantUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Is the product available for sale */
  availableForSale?: InputMaybe<Scalars['Boolean']['input']>;
  /** The barcode of the product */
  barcode?: InputMaybe<Scalars['String']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** The display name of the product */
  displayName?: InputMaybe<Scalars['String']['input']>;
  /** The image of the product variant */
  imageID?: InputMaybe<Scalars['ID']['input']>;
  /** The inventory item ID of the product deprecated */
  inventoryItemID?: InputMaybe<Scalars['ID']['input']>;
  /** The inventory quantity of the product */
  inventoryQuantity?: InputMaybe<Scalars['Int']['input']>;
  /** inventoryType */
  inventoryType?: InputMaybe<ProductVariantInventoryType>;
  /** The price of the product */
  price?: InputMaybe<Scalars['Float']['input']>;
  /** The product ID of the product variant */
  productID?: InputMaybe<Scalars['ID']['input']>;
  /** The quickbook item ID of the product */
  quickbookItemId?: InputMaybe<Scalars['String']['input']>;
  /** The quickbook item name of the product */
  quickbookItemName?: InputMaybe<Scalars['String']['input']>;
  /** The quickbook sync token of the product */
  quickbookSyncToken?: InputMaybe<Scalars['String']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** The sku(Stock Keeping Unit) of the product */
  sku?: InputMaybe<Scalars['String']['input']>;
  /** Is the product taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** PurchaseOrder model */
export type PurchaseOrder = {
  __typename?: 'PurchaseOrder';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** approvedBy */
  approvedBy?: Maybe<Scalars['String']['output']>;
  /** Contact model. Contact and this model is n:1. */
  billTo?: Maybe<Contact>;
  /** billTo ID */
  billToID?: Maybe<Scalars['ID']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** date */
  date?: Maybe<Scalars['DateTime']['output']>;
  /** documentNumber */
  documentNumber: Scalars['String']['output'];
  /** dueDate */
  dueDate?: Maybe<Scalars['DateTime']['output']>;
  /** exFactoryDate */
  exFactoryDate?: Maybe<Scalars['DateTime']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** notes */
  notes?: Maybe<Scalars['String']['output']>;
  /** pulledBy */
  pulledBy?: Maybe<Scalars['String']['output']>;
  /** receivedBy */
  receivedBy?: Maybe<Scalars['String']['output']>;
  /** Contact model. Contact and this model is n:1. */
  shipTo?: Maybe<Contact>;
  /** shipTo ID */
  shipToID?: Maybe<Scalars['ID']['output']>;
  /** shipVia */
  shipVia?: Maybe<Scalars['String']['output']>;
  /** shippingContactName */
  shippingContactName?: Maybe<Scalars['String']['output']>;
  /** shippingContactPhone */
  shippingContactPhone?: Maybe<Scalars['String']['output']>;
  /** shippingInstructions */
  shippingInstructions?: Maybe<Scalars['String']['output']>;
  /** Contact model. Contact and this model is n:1. */
  supplier?: Maybe<Contact>;
  /** supplier ID */
  supplierID: Scalars['ID']['output'];
  /** terms */
  terms?: Maybe<Scalars['String']['output']>;
  /** trackingNumber */
  trackingNumber?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** PurchaseOrder model(Connection) */
export type PurchaseOrderConnection = {
  __typename?: 'PurchaseOrderConnection';
  edges: Array<PurchaseOrderEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** PurchaseOrder model(CreateInput) */
export type PurchaseOrderCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** approvedBy */
  approvedBy?: InputMaybe<Scalars['String']['input']>;
  /** billTo ID */
  billToID?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** documentNumber */
  documentNumber: Scalars['String']['input'];
  /** dueDate */
  dueDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** exFactoryDate */
  exFactoryDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the PurchaseOrder model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** notes */
  notes?: InputMaybe<Scalars['String']['input']>;
  /** pulledBy */
  pulledBy?: InputMaybe<Scalars['String']['input']>;
  /** receivedBy */
  receivedBy?: InputMaybe<Scalars['String']['input']>;
  /** shipTo ID */
  shipToID?: InputMaybe<Scalars['ID']['input']>;
  /** shipVia */
  shipVia?: InputMaybe<Scalars['String']['input']>;
  /** shippingContactName */
  shippingContactName?: InputMaybe<Scalars['String']['input']>;
  /** shippingContactPhone */
  shippingContactPhone?: InputMaybe<Scalars['String']['input']>;
  /** shippingInstructions */
  shippingInstructions?: InputMaybe<Scalars['String']['input']>;
  /** supplier ID */
  supplierID: Scalars['ID']['input'];
  /** terms */
  terms?: InputMaybe<Scalars['String']['input']>;
  /** trackingNumber */
  trackingNumber?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** purchaseOrder(Edge) */
export type PurchaseOrderEdge = {
  __typename?: 'PurchaseOrderEdge';
  cursor: Scalars['String']['output'];
  node: PurchaseOrder;
};

/** PurchaseOrderLineItem model */
export type PurchaseOrderLineItem = {
  __typename?: 'PurchaseOrderLineItem';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** PurchaseOrder model. PurchaseOrder and this model is n:1. */
  purchaseOrder?: Maybe<PurchaseOrder>;
  /** purchaseOrder ID */
  purchaseOrderID: Scalars['ID']['output'];
  /** quantity */
  quantity: Scalars['Float']['output'];
  /** subtotalCost */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost */
  unitCost: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID: Scalars['ID']['output'];
};

/** PurchaseOrderLineItem model(Connection) */
export type PurchaseOrderLineItemConnection = {
  __typename?: 'PurchaseOrderLineItemConnection';
  edges: Array<PurchaseOrderLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** PurchaseOrderLineItem model(CreateInput) */
export type PurchaseOrderLineItemCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the PurchaseOrderLineItem model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** purchaseOrder ID */
  purchaseOrderID: Scalars['ID']['input'];
  /** quantity */
  quantity: Scalars['Float']['input'];
  /** subtotalCost */
  subtotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCost */
  unitCost: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID: Scalars['ID']['input'];
};

/** purchaseOrderLineItem(Edge) */
export type PurchaseOrderLineItemEdge = {
  __typename?: 'PurchaseOrderLineItemEdge';
  cursor: Scalars['String']['output'];
  node: PurchaseOrderLineItem;
};

export enum PurchaseOrderLineItemOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Quantity = 'quantity',
  SubtotalCost = 'subtotalCost',
  UnitCost = 'unitCost',
  UpdatedAt = 'updatedAt'
}

export type PurchaseOrderLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: PurchaseOrderLineItemOrderFieldEnum;
};

/** PurchaseOrderLineItem model(Input) */
export type PurchaseOrderLineItemQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<PurchaseOrderLineItemQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<PurchaseOrderLineItemQueryInput>>;
  or?: InputMaybe<Array<PurchaseOrderLineItemQueryInput>>;
  purchaseOrderID?: InputMaybe<UuidFilter>;
  quantity?: InputMaybe<FloatFilter>;
  subtotalCost?: InputMaybe<FloatFilter>;
  unitCost?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

/** PurchaseOrderLineItem model(UpdateInput) */
export type PurchaseOrderLineItemUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** purchaseOrder ID */
  purchaseOrderID?: InputMaybe<Scalars['ID']['input']>;
  /** quantity */
  quantity?: InputMaybe<Scalars['Float']['input']>;
  /** subtotalCost */
  subtotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCost */
  unitCost?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type PurchaseOrderLineItemsAggregationAvgResult = {
  __typename?: 'PurchaseOrderLineItemsAggregationAvgResult';
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** subtotalCost is aggregation field */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Float']['output']>;
};

export type PurchaseOrderLineItemsAggregationCountResult = {
  __typename?: 'PurchaseOrderLineItemsAggregationCountResult';
  /** purchaseOrderID is aggregation field */
  purchaseOrderID?: Maybe<Scalars['Int']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** subtotalCost is aggregation field */
  subtotalCost?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<PurchaseOrderLineItemsAggregationCountToDayFunc>;
  toHour?: Maybe<PurchaseOrderLineItemsAggregationCountToHourFunc>;
  toMinute?: Maybe<PurchaseOrderLineItemsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<PurchaseOrderLineItemsAggregationCountToMonthFunc>;
  toYear?: Maybe<PurchaseOrderLineItemsAggregationCountToYearFunc>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Int']['output']>;
  /** variantID is aggregation field */
  variantID?: Maybe<Scalars['Int']['output']>;
};

export type PurchaseOrderLineItemsAggregationCountToDayFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type PurchaseOrderLineItemsAggregationCountToHourFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type PurchaseOrderLineItemsAggregationCountToMinuteFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type PurchaseOrderLineItemsAggregationCountToMonthFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type PurchaseOrderLineItemsAggregationCountToYearFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type PurchaseOrderLineItemsAggregationGroupByResult = {
  __typename?: 'PurchaseOrderLineItemsAggregationGroupByResult';
  /** purchaseOrder ID */
  purchaseOrderID?: Maybe<Scalars['ID']['output']>;
  /** quantity */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** subtotalCost */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  toDay?: Maybe<PurchaseOrderLineItemsAggregationGroupByToDayFunc>;
  toHour?: Maybe<PurchaseOrderLineItemsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<PurchaseOrderLineItemsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<PurchaseOrderLineItemsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<PurchaseOrderLineItemsAggregationGroupByToYearFunc>;
  /** unitCost */
  unitCost?: Maybe<Scalars['Float']['output']>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

export type PurchaseOrderLineItemsAggregationGroupByToDayFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type PurchaseOrderLineItemsAggregationGroupByToHourFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type PurchaseOrderLineItemsAggregationGroupByToMinuteFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type PurchaseOrderLineItemsAggregationGroupByToMonthFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type PurchaseOrderLineItemsAggregationGroupByToYearFunc = {
  __typename?: 'PurchaseOrderLineItemsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type PurchaseOrderLineItemsAggregationQuantityResult = {
  __typename?: 'PurchaseOrderLineItemsAggregationQuantityResult';
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** subtotalCost is aggregation field */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Float']['output']>;
};

export type PurchaseOrderLineItemsAggregationResult = {
  __typename?: 'PurchaseOrderLineItemsAggregationResult';
  avg?: Maybe<PurchaseOrderLineItemsAggregationAvgResult>;
  count?: Maybe<PurchaseOrderLineItemsAggregationCountResult>;
  groupBy: PurchaseOrderLineItemsAggregationGroupByResult;
  max?: Maybe<PurchaseOrderLineItemsAggregationQuantityResult>;
  min?: Maybe<PurchaseOrderLineItemsAggregationQuantityResult>;
  sum?: Maybe<PurchaseOrderLineItemsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum PurchaseOrderOrderFieldEnum {
  Active = 'active',
  ApprovedBy = 'approvedBy',
  CreatedAt = 'createdAt',
  Date = 'date',
  DocumentNumber = 'documentNumber',
  DueDate = 'dueDate',
  ExFactoryDate = 'exFactoryDate',
  Notes = 'notes',
  PulledBy = 'pulledBy',
  ReceivedBy = 'receivedBy',
  ShipVia = 'shipVia',
  ShippingContactName = 'shippingContactName',
  ShippingContactPhone = 'shippingContactPhone',
  ShippingInstructions = 'shippingInstructions',
  Terms = 'terms',
  TrackingNumber = 'trackingNumber',
  UpdatedAt = 'updatedAt'
}

export type PurchaseOrderOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: PurchaseOrderOrderFieldEnum;
};

/** PurchaseOrder model(Input) */
export type PurchaseOrderQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<PurchaseOrderQueryInput>>;
  approvedBy?: InputMaybe<StringFilter>;
  billToID?: InputMaybe<UuidFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  date?: InputMaybe<DatetimeFilter>;
  documentNumber?: InputMaybe<StringFilter>;
  dueDate?: InputMaybe<DatetimeFilter>;
  exFactoryDate?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<PurchaseOrderQueryInput>>;
  notes?: InputMaybe<StringFilter>;
  or?: InputMaybe<Array<PurchaseOrderQueryInput>>;
  pulledBy?: InputMaybe<StringFilter>;
  receivedBy?: InputMaybe<StringFilter>;
  shipToID?: InputMaybe<UuidFilter>;
  shipVia?: InputMaybe<StringFilter>;
  shippingContactName?: InputMaybe<StringFilter>;
  shippingContactPhone?: InputMaybe<StringFilter>;
  shippingInstructions?: InputMaybe<StringFilter>;
  supplierID?: InputMaybe<UuidFilter>;
  terms?: InputMaybe<StringFilter>;
  trackingNumber?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** PurchaseOrder model(UpdateInput) */
export type PurchaseOrderUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** approvedBy */
  approvedBy?: InputMaybe<Scalars['String']['input']>;
  /** billTo ID */
  billToID?: InputMaybe<Scalars['ID']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** documentNumber */
  documentNumber?: InputMaybe<Scalars['String']['input']>;
  /** dueDate */
  dueDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** exFactoryDate */
  exFactoryDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** notes */
  notes?: InputMaybe<Scalars['String']['input']>;
  /** pulledBy */
  pulledBy?: InputMaybe<Scalars['String']['input']>;
  /** receivedBy */
  receivedBy?: InputMaybe<Scalars['String']['input']>;
  /** shipTo ID */
  shipToID?: InputMaybe<Scalars['ID']['input']>;
  /** shipVia */
  shipVia?: InputMaybe<Scalars['String']['input']>;
  /** shippingContactName */
  shippingContactName?: InputMaybe<Scalars['String']['input']>;
  /** shippingContactPhone */
  shippingContactPhone?: InputMaybe<Scalars['String']['input']>;
  /** shippingInstructions */
  shippingInstructions?: InputMaybe<Scalars['String']['input']>;
  /** supplier ID */
  supplierID?: InputMaybe<Scalars['ID']['input']>;
  /** terms */
  terms?: InputMaybe<Scalars['String']['input']>;
  /** trackingNumber */
  trackingNumber?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type Query = {
  __typename?: 'Query';
  /** CostPoolLineItem model(Aggregation) */
  aggregateCostPoolLineItems?: Maybe<Array<Maybe<CostPoolLineItemsAggregationResult>>>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Aggregation) */
  aggregateDailySchedules?: Maybe<Array<Maybe<DailySchedulesAggregationResult>>>;
  /** Basic Employee details(Aggregation) */
  aggregateEmployees?: Maybe<Array<Maybe<EmployeesAggregationResult>>>;
  /** StockSummary model for the financial ledger(Aggregation) */
  aggregateFinancialStockSummaries?: Maybe<Array<Maybe<FinancialStockSummariesAggregationResult>>>;
  /** InvoiceLineItem model(Aggregation) */
  aggregateInvoiceLineItems?: Maybe<Array<Maybe<InvoiceLineItemsAggregationResult>>>;
  /** MOLineItem description(Aggregation) */
  aggregateMOLineItems?: Maybe<Array<Maybe<MoLineItemsAggregationResult>>>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(Aggregation) */
  aggregateOperationalStockEvents?: Maybe<Array<Maybe<OperationalStockEventsAggregationResult>>>;
  /** A Specific operation that needs to be performed at a bom(Aggregation) */
  aggregateOperations?: Maybe<Array<Maybe<OperationsAggregationResult>>>;
  /** PurchaseOrderLineItem model(Aggregation) */
  aggregatePurchaseOrderLineItems?: Maybe<Array<Maybe<PurchaseOrderLineItemsAggregationResult>>>;
  /** ReceiptLineItem model(Aggregation) */
  aggregateReceiptLineItems?: Maybe<Array<Maybe<ReceiptLineItemsAggregationResult>>>;
  /** SalesOrderLineItem model(Aggregation) */
  aggregateSalesOrderLineItems?: Maybe<Array<Maybe<SalesOrderLineItemsAggregationResult>>>;
  /** SalesOrder model(Aggregation) */
  aggregateSalesOrders?: Maybe<Array<Maybe<SalesOrdersAggregationResult>>>;
  /** ShipmentLineItem model(Aggregation) */
  aggregateShipmentLineItems?: Maybe<Array<Maybe<ShipmentLineItemsAggregationResult>>>;
  /** Time tracking by employee(Aggregation) */
  aggregateWOTimeTrackings?: Maybe<Array<Maybe<WoTimeTrackingsAggregationResult>>>;
  /** Work Center are the physical locations where the production happens(Aggregation) */
  aggregateWorkCenters?: Maybe<Array<Maybe<WorkCentersAggregationResult>>>;
  /** The actual work order which is created based on the Bom requirement(Aggregation) */
  aggregateWorkOrders?: Maybe<Array<Maybe<WorkOrdersAggregationResult>>>;
  /** BOM description(GetOne) */
  bom?: Maybe<Bom>;
  /** BOM description(GetOneBy) */
  bomBy?: Maybe<Bom>;
  /** BOMLineItem description(GetOne) */
  bomLineItem?: Maybe<BomLineItem>;
  /** BOMLineItem description(GetOneBy) */
  bomLineItemBy?: Maybe<BomLineItem>;
  /** BOMLineItem description(Permission) */
  bomLineItemPermission?: Maybe<PermissionItem>;
  /** BOMLineItem description(GetList) */
  bomLineItems: BomLineItemConnection;
  /** BOM description(Permission) */
  bomPermission?: Maybe<PermissionItem>;
  /** BOM description(GetList) */
  boms: BomConnection;
  computeBatchMoCost?: Maybe<ComputeBatchMoCostOutput>;
  computeManufacturingOrderCost?: Maybe<ComputeManufacturingOrderCostOutput>;
  computeWorkOrderCost?: Maybe<ComputeWorkOrderCostOutput>;
  /** Contact model(GetOne) */
  contact?: Maybe<Contact>;
  /** Contact model(Permission) */
  contactPermission?: Maybe<PermissionItem>;
  /** Contact model(GetList) */
  contacts: ContactConnection;
  convertQuantity?: Maybe<ConvertQuantityOutput>;
  /** CostPool model(GetOne) */
  costPool?: Maybe<CostPool>;
  /** CostPoolLineItem model(GetOne) */
  costPoolLineItem?: Maybe<CostPoolLineItem>;
  /** CostPoolLineItem model(Permission) */
  costPoolLineItemPermission?: Maybe<PermissionItem>;
  /** CostPoolLineItem model(GetList) */
  costPoolLineItems: CostPoolLineItemConnection;
  /** CostPool model(Permission) */
  costPoolPermission?: Maybe<PermissionItem>;
  /** CostPool model(GetList) */
  costPools: CostPoolConnection;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(GetOne) */
  dailySchedule?: Maybe<DailySchedule>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(GetOneBy) */
  dailyScheduleBy?: Maybe<DailySchedule>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(Permission) */
  dailySchedulePermission?: Maybe<PermissionItem>;
  /** Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours.(GetList) */
  dailySchedules: DailyScheduleConnection;
  /** Basic Employee details(GetOne) */
  employee?: Maybe<Employee>;
  /** Basic Employee details(Permission) */
  employeePermission?: Maybe<PermissionItem>;
  /** Basic Employee details(GetList) */
  employees: EmployeeConnection;
  /** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(GetOne) */
  financialStockEvent?: Maybe<FinancialStockEvent>;
  /** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(Permission) */
  financialStockEventPermission?: Maybe<PermissionItem>;
  /** DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore.(GetList) */
  financialStockEvents: FinancialStockEventConnection;
  /** StockSummary model for the financial ledger(GetList) */
  financialStockSummaries: FinancialStockSummaryConnection;
  /** StockSummary model for the financial ledger(GetOne) */
  financialStockSummary?: Maybe<FinancialStockSummary>;
  /** StockSummary model for the financial ledger(Permission) */
  financialStockSummaryPermission?: Maybe<PermissionItem>;
  /** Product variant's inventory item model(GetOne) */
  inventoryItem?: Maybe<InventoryItem>;
  /** Product variant's inventory item model(Permission) */
  inventoryItemPermission?: Maybe<PermissionItem>;
  /** Product variant's inventory item model(GetList) */
  inventoryItems: InventoryItemConnection;
  /** Inventory Level of an inventory item(GetOne) */
  inventoryLevel?: Maybe<InventoryLevel>;
  /** Inventory Level of an inventory item(Permission) */
  inventoryLevelPermission?: Maybe<PermissionItem>;
  /** Inventory Level of an inventory item(GetList) */
  inventoryLevels: InventoryLevelConnection;
  /** Invoice model(GetOne) */
  invoice?: Maybe<Invoice>;
  /** InvoiceLineItem model(GetOne) */
  invoiceLineItem?: Maybe<InvoiceLineItem>;
  /** InvoiceLineItem model(Permission) */
  invoiceLineItemPermission?: Maybe<PermissionItem>;
  /** InvoiceLineItem model(GetList) */
  invoiceLineItems: InvoiceLineItemConnection;
  /** Invoice model(Permission) */
  invoicePermission?: Maybe<PermissionItem>;
  /** Invoice model(GetList) */
  invoices: InvoiceConnection;
  /** Item description(GetOne) */
  item?: Maybe<Item>;
  /** Item description(Permission) */
  itemPermission?: Maybe<PermissionItem>;
  /** Item description(GetList) */
  items: ItemConnection;
  /** Inventory location on Shopify(GetOne) */
  location?: Maybe<Location>;
  /** Inventory location on Shopify(Permission) */
  locationPermission?: Maybe<PermissionItem>;
  /** Inventory location on Shopify(GetList) */
  locations: LocationConnection;
  /** MOBatch(GetOne) */
  mOBatch?: Maybe<MoBatch>;
  /** MOBatch(Permission) */
  mOBatchPermission?: Maybe<PermissionItem>;
  /** MOBatch(GetList) */
  mOBatches: MoBatchConnection;
  /** MOLineItem description(GetOne) */
  mOLineItem?: Maybe<MoLineItem>;
  /** MOLineItem description(GetOneBy) */
  mOLineItemBy?: Maybe<MoLineItem>;
  /** MOLineItem description(Permission) */
  mOLineItemPermission?: Maybe<PermissionItem>;
  /** MOLineItem description(GetList) */
  mOLineItems: MoLineItemConnection;
  /** ManufacturingOrder(GetOne) */
  manufacturingOrder?: Maybe<ManufacturingOrder>;
  /** ManufacturingOrder(Permission) */
  manufacturingOrderPermission?: Maybe<PermissionItem>;
  /** Status tracking of manufacturing order(GetOne) */
  manufacturingOrderTransition?: Maybe<ManufacturingOrderTransition>;
  /** Status tracking of manufacturing order(Permission) */
  manufacturingOrderTransitionPermission?: Maybe<PermissionItem>;
  /** Status tracking of manufacturing order(GetList) */
  manufacturingOrderTransitions: ManufacturingOrderTransitionConnection;
  /** ManufacturingOrder(GetList) */
  manufacturingOrders: ManufacturingOrderConnection;
  /** A Specific operation that needs to be performed at a bom(GetOne) */
  operation?: Maybe<Operation>;
  /** To know the dependency of operation(GetList) */
  operationDependencies: OperationDependencyConnection;
  /** To know the dependency of operation(GetOne) */
  operationDependency?: Maybe<OperationDependency>;
  /** To know the dependency of operation(GetOneBy) */
  operationDependencyBy?: Maybe<OperationDependency>;
  /** To know the dependency of operation(Permission) */
  operationDependencyPermission?: Maybe<PermissionItem>;
  /** Represents a line item in an operation(GetOne) */
  operationLineItem?: Maybe<OperationLineItem>;
  /** Represents a line item in an operation(Permission) */
  operationLineItemPermission?: Maybe<PermissionItem>;
  /** Represents a line item in an operation(GetList) */
  operationLineItems: OperationLineItemConnection;
  /** A Specific operation that needs to be performed at a bom(Permission) */
  operationPermission?: Maybe<PermissionItem>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(GetOne) */
  operationalStockEvent?: Maybe<OperationalStockEvent>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(Permission) */
  operationalStockEventPermission?: Maybe<PermissionItem>;
  /** OperationalStockEvent model. Holds the stock event data that can change.(GetList) */
  operationalStockEvents: OperationalStockEventConnection;
  /** A Specific operation that needs to be performed at a bom(GetList) */
  operations: OperationConnection;
  previewManufacturing?: Maybe<PreviewManufacturingOutput>;
  previewMoBatch?: Maybe<MoBatchPreviewOutput>;
  /** Product model(GetOne) */
  product?: Maybe<Product>;
  /** Product Image(GetOne) */
  productImage?: Maybe<ProductImage>;
  /** Product Image(Permission) */
  productImagePermission?: Maybe<PermissionItem>;
  /** Product Image(GetList) */
  productImages: ProductImageConnection;
  /** Product model(Permission) */
  productPermission?: Maybe<PermissionItem>;
  /** The variants of a product(GetOne) */
  productVariant?: Maybe<ProductVariant>;
  /** The variants of a product(Permission) */
  productVariantPermission?: Maybe<PermissionItem>;
  /** The variants of a product(GetList) */
  productVariants: ProductVariantConnection;
  /** Product model(GetList) */
  products: ProductConnection;
  /** PurchaseOrder model(GetOne) */
  purchaseOrder?: Maybe<PurchaseOrder>;
  /** PurchaseOrderLineItem model(GetOne) */
  purchaseOrderLineItem?: Maybe<PurchaseOrderLineItem>;
  /** PurchaseOrderLineItem model(Permission) */
  purchaseOrderLineItemPermission?: Maybe<PermissionItem>;
  /** PurchaseOrderLineItem model(GetList) */
  purchaseOrderLineItems: PurchaseOrderLineItemConnection;
  /** PurchaseOrder model(Permission) */
  purchaseOrderPermission?: Maybe<PermissionItem>;
  /** PurchaseOrder model(GetList) */
  purchaseOrders: PurchaseOrderConnection;
  /** Receipt model(GetOne) */
  receipt?: Maybe<Receipt>;
  /** ReceiptLineItem model(GetOne) */
  receiptLineItem?: Maybe<ReceiptLineItem>;
  /** ReceiptLineItem model(Permission) */
  receiptLineItemPermission?: Maybe<PermissionItem>;
  /** ReceiptLineItem model(GetList) */
  receiptLineItems: ReceiptLineItemConnection;
  /** Receipt model(Permission) */
  receiptPermission?: Maybe<PermissionItem>;
  /** Receipt model(GetList) */
  receipts: ReceiptConnection;
  /** User Roles(GetOne) */
  role?: Maybe<Role>;
  /** User Roles(Permission) */
  rolePermission?: Maybe<PermissionItem>;
  /** User Roles(GetList) */
  roles: RoleConnection;
  /** SalesOrder model(GetOne) */
  salesOrder?: Maybe<SalesOrder>;
  /** SalesOrderLineItem model(GetOne) */
  salesOrderLineItem?: Maybe<SalesOrderLineItem>;
  /** SalesOrderLineItem model(Permission) */
  salesOrderLineItemPermission?: Maybe<PermissionItem>;
  /** SalesOrderLineItem model(GetList) */
  salesOrderLineItems: SalesOrderLineItemConnection;
  /** SalesOrder model(Permission) */
  salesOrderPermission?: Maybe<PermissionItem>;
  /** SalesOrder model(GetList) */
  salesOrders: SalesOrderConnection;
  /** Shipment model(GetOne) */
  shipment?: Maybe<Shipment>;
  /** ShipmentLineItem model(GetOne) */
  shipmentLineItem?: Maybe<ShipmentLineItem>;
  /** ShipmentLineItem model(Permission) */
  shipmentLineItemPermission?: Maybe<PermissionItem>;
  /** ShipmentLineItem model(GetList) */
  shipmentLineItems: ShipmentLineItemConnection;
  /** Shipment model(Permission) */
  shipmentPermission?: Maybe<PermissionItem>;
  /** Shipment model(GetList) */
  shipments: ShipmentConnection;
  simulateInputRequirementByOutputQuantity?: Maybe<ListPickingResult>;
  simulateOutputByIngredients?: Maybe<ListOutputResult>;
  simulateWorkOperation?: Maybe<SimulateWorkOperationOutput>;
  /** StockSummary model(GetList) */
  stockSummaries: StockSummaryConnection;
  /** StockSummary model(GetOne) */
  stockSummary?: Maybe<StockSummary>;
  /** StockSummary model(Permission) */
  stockSummaryPermission?: Maybe<PermissionItem>;
  /** Unit of Measure(GetOne) */
  uom?: Maybe<Uom>;
  /** Unit of Measure(GetOneBy) */
  uomBy?: Maybe<Uom>;
  /** UOMConversion description(GetOne) */
  uomConversion?: Maybe<UomConversion>;
  /** UOMConversion description(GetOneBy) */
  uomConversionBy?: Maybe<UomConversion>;
  /** UOMConversion description(Permission) */
  uomConversionPermission?: Maybe<PermissionItem>;
  /** UOMConversion description(GetList) */
  uomConversions: UomConversionConnection;
  /** Unit of Measure(Permission) */
  uomPermission?: Maybe<PermissionItem>;
  /** Unit of Measure(GetList) */
  uoms: UomConnection;
  /** User of the system(GetOne) */
  user?: Maybe<User>;
  /** User of the system(GetOneBy) */
  userBy?: Maybe<User>;
  /** User of the system(Permission) */
  userPermission?: Maybe<PermissionItem>;
  /** User of the system(GetList) */
  users: UserConnection;
  /** Time tracking by employee(GetOne) */
  wOTimeTracking?: Maybe<WoTimeTracking>;
  /** Time tracking by employee(Permission) */
  wOTimeTrackingPermission?: Maybe<PermissionItem>;
  /** Time tracking by employee(GetList) */
  wOTimeTrackings: WoTimeTrackingConnection;
  /** Work Center are the physical locations where the production happens(GetOne) */
  workCenter?: Maybe<WorkCenter>;
  /** Work Center are the physical locations where the production happens(Permission) */
  workCenterPermission?: Maybe<PermissionItem>;
  /** Work Center are the physical locations where the production happens(GetList) */
  workCenters: WorkCenterConnection;
  /** The actual work order which is created based on the Bom requirement(GetOne) */
  workOrder?: Maybe<WorkOrder>;
  /** To know the dependency of workOrder(GetList) */
  workOrderDependencies: WorkOrderDependencyConnection;
  /** To know the dependency of workOrder(GetOne) */
  workOrderDependency?: Maybe<WorkOrderDependency>;
  /** To know the dependency of workOrder(GetOneBy) */
  workOrderDependencyBy?: Maybe<WorkOrderDependency>;
  /** To know the dependency of workOrder(Permission) */
  workOrderDependencyPermission?: Maybe<PermissionItem>;
  /** Represents a line item in a work order(GetOne) */
  workOrderLineItem?: Maybe<WorkOrderLineItem>;
  /** Represents a line item in a work order(Permission) */
  workOrderLineItemPermission?: Maybe<PermissionItem>;
  /** Represents a line item in a work order(GetList) */
  workOrderLineItems: WorkOrderLineItemConnection;
  /** The actual work order which is created based on the Bom requirement(Permission) */
  workOrderPermission?: Maybe<PermissionItem>;
  /** Status tracking of work order(GetOne) */
  workOrderTransition?: Maybe<WorkOrderTransition>;
  /** Status tracking of work order(Permission) */
  workOrderTransitionPermission?: Maybe<PermissionItem>;
  /** Status tracking of work order(GetList) */
  workOrderTransitions: WorkOrderTransitionConnection;
  /** The actual work order which is created based on the Bom requirement(GetList) */
  workOrders: WorkOrderConnection;
  /** Used to define the hours during which a work center will be available(GetOne) */
  workingHour?: Maybe<WorkingHour>;
  /** Used to define the hours during which a work center will be available(Permission) */
  workingHourPermission?: Maybe<PermissionItem>;
  /** Used to define the hours during which a work center will be available(GetList) */
  workingHours: WorkingHourConnection;
};


export type QueryAggregateCostPoolLineItemsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<CostPoolLineItemQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateDailySchedulesArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<DailyScheduleQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateEmployeesArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<EmployeeQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateFinancialStockSummariesArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<FinancialStockSummaryQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateInvoiceLineItemsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<InvoiceLineItemQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateMoLineItemsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<MoLineItemQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateOperationalStockEventsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<OperationalStockEventQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateOperationsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<OperationQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregatePurchaseOrderLineItemsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<PurchaseOrderLineItemQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateReceiptLineItemsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<ReceiptLineItemQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateSalesOrderLineItemsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<SalesOrderLineItemQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateSalesOrdersArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<SalesOrderQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateShipmentLineItemsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<ShipmentLineItemQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateWoTimeTrackingsArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<WoTimeTrackingQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateWorkCentersArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<WorkCenterQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryAggregateWorkOrdersArgs = {
  from?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<WorkOrderQueryInput>;
  size?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryBomArgs = {
  id: Scalars['ID']['input'];
};


export type QueryBomByArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};


export type QueryBomLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryBomLineItemByArgs = {
  bomItemCompositeKey?: InputMaybe<BomItemCompositeKey>;
  id?: InputMaybe<Scalars['ID']['input']>;
};


export type QueryBomLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryBomLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<BomLineItemOrderInput>>>;
  query?: InputMaybe<BomLineItemQueryInput>;
};


export type QueryBomPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryBomsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<BomOrderInput>>>;
  query?: InputMaybe<BomQueryInput>;
};


export type QueryComputeBatchMoCostArgs = {
  input: ComputeBatchMoCostInput;
};


export type QueryComputeManufacturingOrderCostArgs = {
  input: ComputeManufacturingOrderCostInput;
};


export type QueryComputeWorkOrderCostArgs = {
  input: ComputeWorkOrderCostInput;
};


export type QueryContactArgs = {
  id: Scalars['ID']['input'];
};


export type QueryContactPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryContactsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ContactOrderInput>>>;
  query?: InputMaybe<ContactQueryInput>;
};


export type QueryConvertQuantityArgs = {
  input: ConvertQuantityInput;
};


export type QueryCostPoolArgs = {
  id: Scalars['ID']['input'];
};


export type QueryCostPoolLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryCostPoolLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryCostPoolLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<CostPoolLineItemOrderInput>>>;
  query?: InputMaybe<CostPoolLineItemQueryInput>;
};


export type QueryCostPoolPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryCostPoolsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<CostPoolOrderInput>>>;
  query?: InputMaybe<CostPoolQueryInput>;
};


export type QueryDailyScheduleArgs = {
  id: Scalars['ID']['input'];
};


export type QueryDailyScheduleByArgs = {
  dailyScheduleUniquenessCompositeKey?: InputMaybe<DailyScheduleUniquenessCompositeKey>;
  id?: InputMaybe<Scalars['ID']['input']>;
};


export type QueryDailySchedulePermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryDailySchedulesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<DailyScheduleOrderInput>>>;
  query?: InputMaybe<DailyScheduleQueryInput>;
};


export type QueryEmployeeArgs = {
  id: Scalars['ID']['input'];
};


export type QueryEmployeePermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryEmployeesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<EmployeeOrderInput>>>;
  query?: InputMaybe<EmployeeQueryInput>;
};


export type QueryFinancialStockEventArgs = {
  id: Scalars['ID']['input'];
};


export type QueryFinancialStockEventPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryFinancialStockEventsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<FinancialStockEventOrderInput>>>;
  query?: InputMaybe<FinancialStockEventQueryInput>;
};


export type QueryFinancialStockSummariesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<FinancialStockSummaryOrderInput>>>;
  query?: InputMaybe<FinancialStockSummaryQueryInput>;
};


export type QueryFinancialStockSummaryArgs = {
  id: Scalars['ID']['input'];
};


export type QueryFinancialStockSummaryPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInventoryItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInventoryItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInventoryItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<InventoryItemOrderInput>>>;
  query?: InputMaybe<InventoryItemQueryInput>;
};


export type QueryInventoryLevelArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInventoryLevelPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInventoryLevelsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<InventoryLevelOrderInput>>>;
  query?: InputMaybe<InventoryLevelQueryInput>;
};


export type QueryInvoiceArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInvoiceLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInvoiceLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInvoiceLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<InvoiceLineItemOrderInput>>>;
  query?: InputMaybe<InvoiceLineItemQueryInput>;
};


export type QueryInvoicePermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryInvoicesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<InvoiceOrderInput>>>;
  query?: InputMaybe<InvoiceQueryInput>;
};


export type QueryItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ItemOrderInput>>>;
  query?: InputMaybe<ItemQueryInput>;
};


export type QueryLocationArgs = {
  id: Scalars['ID']['input'];
};


export type QueryLocationPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryLocationsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<LocationOrderInput>>>;
  query?: InputMaybe<LocationQueryInput>;
};


export type QueryMoBatchArgs = {
  id: Scalars['ID']['input'];
};


export type QueryMoBatchPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryMoBatchesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<MoBatchOrderInput>>>;
  query?: InputMaybe<MoBatchQueryInput>;
};


export type QueryMoLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryMoLineItemByArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  moLineItemCompositeKey?: InputMaybe<MoLineItemCompositeKey>;
};


export type QueryMoLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryMoLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<MoLineItemOrderInput>>>;
  query?: InputMaybe<MoLineItemQueryInput>;
};


export type QueryManufacturingOrderArgs = {
  id: Scalars['ID']['input'];
};


export type QueryManufacturingOrderPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryManufacturingOrderTransitionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryManufacturingOrderTransitionPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryManufacturingOrderTransitionsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ManufacturingOrderTransitionOrderInput>>>;
  query?: InputMaybe<ManufacturingOrderTransitionQueryInput>;
};


export type QueryManufacturingOrdersArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ManufacturingOrderOrderInput>>>;
  query?: InputMaybe<ManufacturingOrderQueryInput>;
};


export type QueryOperationArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationDependenciesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<OperationDependencyOrderInput>>>;
  query?: InputMaybe<OperationDependencyQueryInput>;
};


export type QueryOperationDependencyArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationDependencyByArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  operationDependenciesCompositeKey?: InputMaybe<OperationDependenciesCompositeKey>;
};


export type QueryOperationDependencyPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<OperationLineItemOrderInput>>>;
  query?: InputMaybe<OperationLineItemQueryInput>;
};


export type QueryOperationPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationalStockEventArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationalStockEventPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryOperationalStockEventsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<OperationalStockEventOrderInput>>>;
  query?: InputMaybe<OperationalStockEventQueryInput>;
};


export type QueryOperationsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<OperationOrderInput>>>;
  query?: InputMaybe<OperationQueryInput>;
};


export type QueryPreviewManufacturingArgs = {
  input: PreviewManufacturingInput;
};


export type QueryPreviewMoBatchArgs = {
  batchSize: Scalars['Int']['input'];
  bomId: Scalars['ID']['input'];
  name: Scalars['String']['input'];
  totalQuantity: Scalars['Int']['input'];
};


export type QueryProductArgs = {
  id: Scalars['ID']['input'];
};


export type QueryProductImageArgs = {
  id: Scalars['ID']['input'];
};


export type QueryProductImagePermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryProductImagesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ProductImageOrderInput>>>;
  query?: InputMaybe<ProductImageQueryInput>;
};


export type QueryProductPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryProductVariantArgs = {
  id: Scalars['ID']['input'];
};


export type QueryProductVariantPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryProductVariantsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ProductVariantOrderInput>>>;
  query?: InputMaybe<ProductVariantQueryInput>;
};


export type QueryProductsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ProductOrderInput>>>;
  query?: InputMaybe<ProductQueryInput>;
};


export type QueryPurchaseOrderArgs = {
  id: Scalars['ID']['input'];
};


export type QueryPurchaseOrderLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryPurchaseOrderLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryPurchaseOrderLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<PurchaseOrderLineItemOrderInput>>>;
  query?: InputMaybe<PurchaseOrderLineItemQueryInput>;
};


export type QueryPurchaseOrderPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryPurchaseOrdersArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<PurchaseOrderOrderInput>>>;
  query?: InputMaybe<PurchaseOrderQueryInput>;
};


export type QueryReceiptArgs = {
  id: Scalars['ID']['input'];
};


export type QueryReceiptLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryReceiptLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryReceiptLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ReceiptLineItemOrderInput>>>;
  query?: InputMaybe<ReceiptLineItemQueryInput>;
};


export type QueryReceiptPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryReceiptsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ReceiptOrderInput>>>;
  query?: InputMaybe<ReceiptQueryInput>;
};


export type QueryRoleArgs = {
  id: Scalars['ID']['input'];
};


export type QueryRolePermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryRolesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<RoleOrderInput>>>;
  query?: InputMaybe<RoleQueryInput>;
};


export type QuerySalesOrderArgs = {
  id: Scalars['ID']['input'];
};


export type QuerySalesOrderLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QuerySalesOrderLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QuerySalesOrderLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<SalesOrderLineItemOrderInput>>>;
  query?: InputMaybe<SalesOrderLineItemQueryInput>;
};


export type QuerySalesOrderPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QuerySalesOrdersArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<SalesOrderOrderInput>>>;
  query?: InputMaybe<SalesOrderQueryInput>;
};


export type QueryShipmentArgs = {
  id: Scalars['ID']['input'];
};


export type QueryShipmentLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryShipmentLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryShipmentLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ShipmentLineItemOrderInput>>>;
  query?: InputMaybe<ShipmentLineItemQueryInput>;
};


export type QueryShipmentPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryShipmentsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<ShipmentOrderInput>>>;
  query?: InputMaybe<ShipmentQueryInput>;
};


export type QuerySimulateInputRequirementByOutputQuantityArgs = {
  input: SimulateInputRequirementByOutputQuantityInput;
};


export type QuerySimulateOutputByIngredientsArgs = {
  input: SimulateOutputByIngredientsInput;
};


export type QuerySimulateWorkOperationArgs = {
  input: SimulateWorkOperationInput;
};


export type QueryStockSummariesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<StockSummaryOrderInput>>>;
  query?: InputMaybe<StockSummaryQueryInput>;
};


export type QueryStockSummaryArgs = {
  id: Scalars['ID']['input'];
};


export type QueryStockSummaryPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryUomArgs = {
  id: Scalars['ID']['input'];
};


export type QueryUomByArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};


export type QueryUomConversionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryUomConversionByArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  uomConversionCompositeKey?: InputMaybe<UomConversionCompositeKey>;
};


export type QueryUomConversionPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryUomConversionsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<UomConversionOrderInput>>>;
  query?: InputMaybe<UomConversionQueryInput>;
};


export type QueryUomPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryUomsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<UomOrderInput>>>;
  query?: InputMaybe<UomQueryInput>;
};


export type QueryUserArgs = {
  id: Scalars['ID']['input'];
};


export type QueryUserByArgs = {
  email?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['ID']['input']>;
};


export type QueryUserPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryUsersArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<UserOrderInput>>>;
  query?: InputMaybe<UserQueryInput>;
};


export type QueryWoTimeTrackingArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWoTimeTrackingPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWoTimeTrackingsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<WoTimeTrackingOrderInput>>>;
  query?: InputMaybe<WoTimeTrackingQueryInput>;
};


export type QueryWorkCenterArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkCenterPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkCentersArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<WorkCenterOrderInput>>>;
  query?: InputMaybe<WorkCenterQueryInput>;
};


export type QueryWorkOrderArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderDependenciesArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<WorkOrderDependencyOrderInput>>>;
  query?: InputMaybe<WorkOrderDependencyQueryInput>;
};


export type QueryWorkOrderDependencyArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderDependencyByArgs = {
  id?: InputMaybe<Scalars['ID']['input']>;
  workOrderDependenciesCompositeKey?: InputMaybe<WorkOrderDependenciesCompositeKey>;
};


export type QueryWorkOrderDependencyPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderLineItemArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderLineItemPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderLineItemsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<WorkOrderLineItemOrderInput>>>;
  query?: InputMaybe<WorkOrderLineItemQueryInput>;
};


export type QueryWorkOrderPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderTransitionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderTransitionPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkOrderTransitionsArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<WorkOrderTransitionOrderInput>>>;
  query?: InputMaybe<WorkOrderTransitionQueryInput>;
};


export type QueryWorkOrdersArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<WorkOrderOrderInput>>>;
  query?: InputMaybe<WorkOrderQueryInput>;
};


export type QueryWorkingHourArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkingHourPermissionArgs = {
  id: Scalars['ID']['input'];
};


export type QueryWorkingHoursArgs = {
  after?: InputMaybe<Scalars['String']['input']>;
  before?: InputMaybe<Scalars['String']['input']>;
  first?: InputMaybe<Scalars['Int']['input']>;
  last?: InputMaybe<Scalars['Int']['input']>;
  order?: InputMaybe<Array<InputMaybe<WorkingHourOrderInput>>>;
  query?: InputMaybe<WorkingHourQueryInput>;
};

/** Receipt model */
export type Receipt = {
  __typename?: 'Receipt';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** date */
  date?: Maybe<Scalars['DateTime']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** PurchaseOrder model. PurchaseOrder and this model is n:1. */
  purchaseOrder?: Maybe<PurchaseOrder>;
  /** purchaseOrder ID */
  purchaseOrderID?: Maybe<Scalars['ID']['output']>;
  /** Receipt number */
  receiptNumber?: Maybe<Scalars['String']['output']>;
  /** inventoryType */
  receiptStatus?: Maybe<ReceiptReceiptStatus>;
  /** Supplier model. Supplier and this model is n:1. */
  supplier?: Maybe<Contact>;
  /** Supplier ID */
  supplierID?: Maybe<Scalars['ID']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Receipt model(Connection) */
export type ReceiptConnection = {
  __typename?: 'ReceiptConnection';
  edges: Array<ReceiptEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Receipt model(CreateInput) */
export type ReceiptCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Receipt model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** purchaseOrder ID */
  purchaseOrderID?: InputMaybe<Scalars['ID']['input']>;
  /** Receipt number */
  receiptNumber?: InputMaybe<Scalars['String']['input']>;
  /** inventoryType */
  receiptStatus?: InputMaybe<ReceiptReceiptStatus>;
  /** Supplier ID */
  supplierID?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** receipt(Edge) */
export type ReceiptEdge = {
  __typename?: 'ReceiptEdge';
  cursor: Scalars['String']['output'];
  node: Receipt;
};

/** ReceiptLineItem model */
export type ReceiptLineItem = {
  __typename?: 'ReceiptLineItem';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** CostPool model. CostPool and this model is n:n. */
  costPools?: Maybe<Array<ReceiptLineItemCostPools>>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** cubicMeters */
  cubicMeters?: Maybe<Scalars['Float']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** quantity */
  quantity: Scalars['Float']['output'];
  /** Receipt model. Receipt and this model is n:1. */
  receipt?: Maybe<Receipt>;
  /** receipt ID */
  receiptID: Scalars['ID']['output'];
  /** inventoryType */
  receiptStatus?: Maybe<ReceiptLineItemReceiptStatus>;
  /** shipped at */
  receivedAt?: Maybe<Scalars['DateTime']['output']>;
  /** subtotalCost */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  /** subtotalUnitCost */
  subtotalUnitCost: Scalars['Float']['output'];
  /** totalCostPoolAllocation */
  totalCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
  /** totalUnitCost */
  totalUnitCost?: Maybe<Scalars['Float']['output']>;
  /** unitCostPoolAllocation */
  unitCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID: Scalars['ID']['output'];
};

/** ReceiptLineItem model(Connection) */
export type ReceiptLineItemConnection = {
  __typename?: 'ReceiptLineItemConnection';
  edges: Array<ReceiptLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** CostPool model. CostPool and this model is n:n. */
export type ReceiptLineItemCostPools = {
  __typename?: 'ReceiptLineItemCostPools';
  /** CostPool model. CostPool and this model is n:n. */
  costPool?: Maybe<CostPool>;
  /** CostPool ID */
  costPoolID?: Maybe<Scalars['ID']['output']>;
};

export type ReceiptLineItemCostPoolsInput = {
  /** CostPool ID */
  costPoolID?: InputMaybe<Scalars['ID']['input']>;
};

/** ReceiptLineItem model(CreateInput) */
export type ReceiptLineItemCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  costPools?: InputMaybe<Array<ReceiptLineItemCostPoolsInput>>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** cubicMeters */
  cubicMeters?: InputMaybe<Scalars['Float']['input']>;
  /** ID of the ReceiptLineItem model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** quantity */
  quantity: Scalars['Float']['input'];
  /** receipt ID */
  receiptID: Scalars['ID']['input'];
  /** inventoryType */
  receiptStatus?: InputMaybe<ReceiptLineItemReceiptStatus>;
  /** shipped at */
  receivedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** subtotalCost */
  subtotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** subtotalUnitCost */
  subtotalUnitCost: Scalars['Float']['input'];
  /** totalCostPoolAllocation */
  totalCostPoolAllocation?: InputMaybe<Scalars['Float']['input']>;
  /** totalUnitCost */
  totalUnitCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCostPoolAllocation */
  unitCostPoolAllocation?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID: Scalars['ID']['input'];
};

/** receiptLineItem(Edge) */
export type ReceiptLineItemEdge = {
  __typename?: 'ReceiptLineItemEdge';
  cursor: Scalars['String']['output'];
  node: ReceiptLineItem;
};

export enum ReceiptLineItemOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  CubicMeters = 'cubicMeters',
  Quantity = 'quantity',
  ReceiptStatus = 'receiptStatus',
  ReceivedAt = 'receivedAt',
  SubtotalCost = 'subtotalCost',
  SubtotalUnitCost = 'subtotalUnitCost',
  TotalCostPoolAllocation = 'totalCostPoolAllocation',
  TotalUnitCost = 'totalUnitCost',
  UnitCostPoolAllocation = 'unitCostPoolAllocation',
  UpdatedAt = 'updatedAt'
}

export type ReceiptLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ReceiptLineItemOrderFieldEnum;
};

/** ReceiptLineItem model(Input) */
export type ReceiptLineItemQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<ReceiptLineItemQueryInput>>;
  costPools?: InputMaybe<CostPoolsQueryInput>;
  createdAt?: InputMaybe<DatetimeFilter>;
  cubicMeters?: InputMaybe<FloatFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<ReceiptLineItemQueryInput>>;
  or?: InputMaybe<Array<ReceiptLineItemQueryInput>>;
  quantity?: InputMaybe<FloatFilter>;
  receiptID?: InputMaybe<UuidFilter>;
  receiptStatus?: InputMaybe<ReceiptLineItemReceiptStatusEnumFilter>;
  receivedAt?: InputMaybe<DatetimeFilter>;
  subtotalCost?: InputMaybe<FloatFilter>;
  subtotalUnitCost?: InputMaybe<FloatFilter>;
  totalCostPoolAllocation?: InputMaybe<FloatFilter>;
  totalUnitCost?: InputMaybe<FloatFilter>;
  unitCostPoolAllocation?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

export enum ReceiptLineItemReceiptStatus {
  /** DRAFT State, meaning it can be updated */
  Draft = 'DRAFT',
  /** CANNOT BE EDITED. RECEIVED State, items were received */
  Received = 'RECEIVED'
}

export type ReceiptLineItemReceiptStatusEnumFilter = {
  eq?: InputMaybe<ReceiptLineItemReceiptStatus>;
  in?: InputMaybe<Array<InputMaybe<ReceiptLineItemReceiptStatus>>>;
  ne?: InputMaybe<ReceiptLineItemReceiptStatus>;
  nin?: InputMaybe<Array<InputMaybe<ReceiptLineItemReceiptStatus>>>;
};

/** ReceiptLineItem model(UpdateInput) */
export type ReceiptLineItemUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  costPools?: InputMaybe<Array<ReceiptLineItemCostPoolsInput>>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** cubicMeters */
  cubicMeters?: InputMaybe<Scalars['Float']['input']>;
  /** quantity */
  quantity?: InputMaybe<Scalars['Float']['input']>;
  /** receipt ID */
  receiptID?: InputMaybe<Scalars['ID']['input']>;
  /** inventoryType */
  receiptStatus?: InputMaybe<ReceiptLineItemReceiptStatus>;
  /** shipped at */
  receivedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** subtotalCost */
  subtotalCost?: InputMaybe<Scalars['Float']['input']>;
  /** subtotalUnitCost */
  subtotalUnitCost?: InputMaybe<Scalars['Float']['input']>;
  /** totalCostPoolAllocation */
  totalCostPoolAllocation?: InputMaybe<Scalars['Float']['input']>;
  /** totalUnitCost */
  totalUnitCost?: InputMaybe<Scalars['Float']['input']>;
  /** unitCostPoolAllocation */
  unitCostPoolAllocation?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type ReceiptLineItemsAggregationAvgResult = {
  __typename?: 'ReceiptLineItemsAggregationAvgResult';
  /** cubicMeters is aggregation field */
  cubicMeters?: Maybe<Scalars['Float']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** subtotalCost is aggregation field */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  /** subtotalUnitCost is aggregation field */
  subtotalUnitCost?: Maybe<Scalars['Float']['output']>;
  /** totalCostPoolAllocation is aggregation field */
  totalCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
  /** totalUnitCost is aggregation field */
  totalUnitCost?: Maybe<Scalars['Float']['output']>;
  /** unitCostPoolAllocation is aggregation field */
  unitCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
};

export type ReceiptLineItemsAggregationCountResult = {
  __typename?: 'ReceiptLineItemsAggregationCountResult';
  /** cubicMeters is aggregation field */
  cubicMeters?: Maybe<Scalars['Int']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** receiptID is aggregation field */
  receiptID?: Maybe<Scalars['Int']['output']>;
  /** receiptStatus is aggregation field */
  receiptStatus?: Maybe<Scalars['Int']['output']>;
  /** subtotalCost is aggregation field */
  subtotalCost?: Maybe<Scalars['Int']['output']>;
  /** subtotalUnitCost is aggregation field */
  subtotalUnitCost?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<ReceiptLineItemsAggregationCountToDayFunc>;
  toHour?: Maybe<ReceiptLineItemsAggregationCountToHourFunc>;
  toMinute?: Maybe<ReceiptLineItemsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<ReceiptLineItemsAggregationCountToMonthFunc>;
  toYear?: Maybe<ReceiptLineItemsAggregationCountToYearFunc>;
  /** totalCostPoolAllocation is aggregation field */
  totalCostPoolAllocation?: Maybe<Scalars['Int']['output']>;
  /** totalUnitCost is aggregation field */
  totalUnitCost?: Maybe<Scalars['Int']['output']>;
  /** unitCostPoolAllocation is aggregation field */
  unitCostPoolAllocation?: Maybe<Scalars['Int']['output']>;
  /** variantID is aggregation field */
  variantID?: Maybe<Scalars['Int']['output']>;
};

export type ReceiptLineItemsAggregationCountToDayFunc = {
  __typename?: 'ReceiptLineItemsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** receivedAt is aggregation field */
  receivedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ReceiptLineItemsAggregationCountToHourFunc = {
  __typename?: 'ReceiptLineItemsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** receivedAt is aggregation field */
  receivedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ReceiptLineItemsAggregationCountToMinuteFunc = {
  __typename?: 'ReceiptLineItemsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** receivedAt is aggregation field */
  receivedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ReceiptLineItemsAggregationCountToMonthFunc = {
  __typename?: 'ReceiptLineItemsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** receivedAt is aggregation field */
  receivedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ReceiptLineItemsAggregationCountToYearFunc = {
  __typename?: 'ReceiptLineItemsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** receivedAt is aggregation field */
  receivedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ReceiptLineItemsAggregationGroupByResult = {
  __typename?: 'ReceiptLineItemsAggregationGroupByResult';
  /** cubicMeters */
  cubicMeters?: Maybe<Scalars['Float']['output']>;
  /** quantity */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** receipt ID */
  receiptID?: Maybe<Scalars['ID']['output']>;
  /** inventoryType */
  receiptStatus?: Maybe<ReceiptLineItemsReceiptStatus>;
  /** subtotalCost */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  /** subtotalUnitCost */
  subtotalUnitCost?: Maybe<Scalars['Float']['output']>;
  toDay?: Maybe<ReceiptLineItemsAggregationGroupByToDayFunc>;
  toHour?: Maybe<ReceiptLineItemsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<ReceiptLineItemsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<ReceiptLineItemsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<ReceiptLineItemsAggregationGroupByToYearFunc>;
  /** totalCostPoolAllocation */
  totalCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
  /** totalUnitCost */
  totalUnitCost?: Maybe<Scalars['Float']['output']>;
  /** unitCostPoolAllocation */
  unitCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

export type ReceiptLineItemsAggregationGroupByToDayFunc = {
  __typename?: 'ReceiptLineItemsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  receivedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ReceiptLineItemsAggregationGroupByToHourFunc = {
  __typename?: 'ReceiptLineItemsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  receivedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ReceiptLineItemsAggregationGroupByToMinuteFunc = {
  __typename?: 'ReceiptLineItemsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  receivedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ReceiptLineItemsAggregationGroupByToMonthFunc = {
  __typename?: 'ReceiptLineItemsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  receivedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ReceiptLineItemsAggregationGroupByToYearFunc = {
  __typename?: 'ReceiptLineItemsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  receivedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ReceiptLineItemsAggregationQuantityResult = {
  __typename?: 'ReceiptLineItemsAggregationQuantityResult';
  /** cubicMeters is aggregation field */
  cubicMeters?: Maybe<Scalars['Float']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** subtotalCost is aggregation field */
  subtotalCost?: Maybe<Scalars['Float']['output']>;
  /** subtotalUnitCost is aggregation field */
  subtotalUnitCost?: Maybe<Scalars['Float']['output']>;
  /** totalCostPoolAllocation is aggregation field */
  totalCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
  /** totalUnitCost is aggregation field */
  totalUnitCost?: Maybe<Scalars['Float']['output']>;
  /** unitCostPoolAllocation is aggregation field */
  unitCostPoolAllocation?: Maybe<Scalars['Float']['output']>;
};

export type ReceiptLineItemsAggregationResult = {
  __typename?: 'ReceiptLineItemsAggregationResult';
  avg?: Maybe<ReceiptLineItemsAggregationAvgResult>;
  count?: Maybe<ReceiptLineItemsAggregationCountResult>;
  groupBy: ReceiptLineItemsAggregationGroupByResult;
  max?: Maybe<ReceiptLineItemsAggregationQuantityResult>;
  min?: Maybe<ReceiptLineItemsAggregationQuantityResult>;
  sum?: Maybe<ReceiptLineItemsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum ReceiptLineItemsReceiptStatus {
  Draft = 'DRAFT',
  Received = 'RECEIVED'
}

export enum ReceiptOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Date = 'date',
  ReceiptNumber = 'receiptNumber',
  ReceiptStatus = 'receiptStatus',
  UpdatedAt = 'updatedAt'
}

export type ReceiptOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ReceiptOrderFieldEnum;
};

/** Receipt model(Input) */
export type ReceiptQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<ReceiptQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  date?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<ReceiptQueryInput>>;
  or?: InputMaybe<Array<ReceiptQueryInput>>;
  purchaseOrderID?: InputMaybe<UuidFilter>;
  receiptNumber?: InputMaybe<StringFilter>;
  receiptStatus?: InputMaybe<ReceiptReceiptStatusEnumFilter>;
  supplierID?: InputMaybe<UuidFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

export enum ReceiptReceiptStatus {
  /** CANNOT BE EDITED. RECEIVED State, items were received */
  Closed = 'CLOSED',
  /** OPEN State, meaning it can be updated */
  Open = 'OPEN'
}

export type ReceiptReceiptStatusEnumFilter = {
  eq?: InputMaybe<ReceiptReceiptStatus>;
  in?: InputMaybe<Array<InputMaybe<ReceiptReceiptStatus>>>;
  ne?: InputMaybe<ReceiptReceiptStatus>;
  nin?: InputMaybe<Array<InputMaybe<ReceiptReceiptStatus>>>;
};

/** Receipt model(UpdateInput) */
export type ReceiptUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** purchaseOrder ID */
  purchaseOrderID?: InputMaybe<Scalars['ID']['input']>;
  /** Receipt number */
  receiptNumber?: InputMaybe<Scalars['String']['input']>;
  /** inventoryType */
  receiptStatus?: InputMaybe<ReceiptReceiptStatus>;
  /** Supplier ID */
  supplierID?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** User Roles */
export type Role = {
  __typename?: 'Role';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Name of the Role */
  name: Scalars['String']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** User Roles(Connection) */
export type RoleConnection = {
  __typename?: 'RoleConnection';
  edges: Array<RoleEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** User Roles(CreateInput) */
export type RoleCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the User Roles */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the Role */
  name: Scalars['String']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** role(Edge) */
export type RoleEdge = {
  __typename?: 'RoleEdge';
  cursor: Scalars['String']['output'];
  node: Role;
};

export enum RoleOrderFieldEnum {
  CreatedAt = 'createdAt',
  Name = 'name',
  UpdatedAt = 'updatedAt'
}

export type RoleOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: RoleOrderFieldEnum;
};

/** User Roles(Input) */
export type RoleQueryInput = {
  and?: InputMaybe<Array<RoleQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<RoleQueryInput>>;
  or?: InputMaybe<Array<RoleQueryInput>>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** User Roles(UpdateInput) */
export type RoleUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Name of the Role */
  name?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** SalesOrder model */
export type SalesOrder = {
  __typename?: 'SalesOrder';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** Reason for cancellation */
  cancelReason?: Maybe<Scalars['String']['output']>;
  /** Cancellation date */
  cancelledAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Currency */
  currency?: Maybe<Scalars['String']['output']>;
  /** Current subtotal price */
  currentSubtotalPrice?: Maybe<Scalars['String']['output']>;
  /** Customer contact */
  customer?: Maybe<Contact>;
  /** Customer email */
  customerEmail?: Maybe<Scalars['String']['output']>;
  /** Contact model. Contact and this model is n:1 */
  customerID?: Maybe<Scalars['ID']['output']>;
  /** Customer name */
  customerName?: Maybe<Scalars['String']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Order number */
  orderNumber?: Maybe<Scalars['Int']['output']>;
  /** inventoryType */
  shipStationOrderStatus?: Maybe<SalesOrderShipStationOrderStatus>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['DateTime']['output']>;
  /** Shopify created at */
  shopifyCreatedAt?: Maybe<Scalars['DateTime']['output']>;
  /** Shopify order ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** SalesOrder model(Connection) */
export type SalesOrderConnection = {
  __typename?: 'SalesOrderConnection';
  edges: Array<SalesOrderEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** SalesOrder model(CreateInput) */
export type SalesOrderCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Reason for cancellation */
  cancelReason?: InputMaybe<Scalars['String']['input']>;
  /** Cancellation date */
  cancelledAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Currency */
  currency?: InputMaybe<Scalars['String']['input']>;
  /** Current subtotal price */
  currentSubtotalPrice?: InputMaybe<Scalars['String']['input']>;
  /** Customer email */
  customerEmail?: InputMaybe<Scalars['String']['input']>;
  /** Contact model. Contact and this model is n:1 */
  customerID?: InputMaybe<Scalars['ID']['input']>;
  /** Customer name */
  customerName?: InputMaybe<Scalars['String']['input']>;
  /** ID of the SalesOrder model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Order number */
  orderNumber?: InputMaybe<Scalars['Int']['input']>;
  /** inventoryType */
  shipStationOrderStatus?: InputMaybe<SalesOrderShipStationOrderStatus>;
  /** shipped at */
  shippedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Shopify created at */
  shopifyCreatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Shopify order ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** salesOrder(Edge) */
export type SalesOrderEdge = {
  __typename?: 'SalesOrderEdge';
  cursor: Scalars['String']['output'];
  node: SalesOrder;
};

/** SalesOrderLineItem model */
export type SalesOrderLineItem = {
  __typename?: 'SalesOrderLineItem';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** discount */
  discount?: Maybe<Scalars['Float']['output']>;
  /** fulfillmentStatus */
  fulfillmentStatus?: Maybe<SalesOrderLineItemFulfillmentStatus>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** name */
  name?: Maybe<Scalars['String']['output']>;
  /** quantity */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** requiresShipping */
  requiresShipping?: Maybe<Scalars['Boolean']['output']>;
  /** SalesOrder model. SalesOrder and this model is n:1. */
  salesOrder?: Maybe<SalesOrder>;
  /** salesOrder ID */
  salesOrderID?: Maybe<Scalars['ID']['output']>;
  /** Shopify product ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /** sku */
  sku?: Maybe<Scalars['String']['output']>;
  /** subtotalCost */
  subtotalPrice?: Maybe<Scalars['Float']['output']>;
  /** taxable */
  taxable?: Maybe<Scalars['Boolean']['output']>;
  /** unitCompareAtPrice */
  unitCompareAtPrice?: Maybe<Scalars['Float']['output']>;
  /** unitPrice */
  unitPrice?: Maybe<Scalars['Float']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

/** SalesOrderLineItem model(Connection) */
export type SalesOrderLineItemConnection = {
  __typename?: 'SalesOrderLineItemConnection';
  edges: Array<SalesOrderLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** SalesOrderLineItem model(CreateInput) */
export type SalesOrderLineItemCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** discount */
  discount?: InputMaybe<Scalars['Float']['input']>;
  /** fulfillmentStatus */
  fulfillmentStatus?: InputMaybe<SalesOrderLineItemFulfillmentStatus>;
  /** ID of the SalesOrderLineItem model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** quantity */
  quantity?: InputMaybe<Scalars['Float']['input']>;
  /** requiresShipping */
  requiresShipping?: InputMaybe<Scalars['Boolean']['input']>;
  /** salesOrder ID */
  salesOrderID?: InputMaybe<Scalars['ID']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** sku */
  sku?: InputMaybe<Scalars['String']['input']>;
  /** subtotalCost */
  subtotalPrice?: InputMaybe<Scalars['Float']['input']>;
  /** taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** unitCompareAtPrice */
  unitCompareAtPrice?: InputMaybe<Scalars['Float']['input']>;
  /** unitPrice */
  unitPrice?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

/** salesOrderLineItem(Edge) */
export type SalesOrderLineItemEdge = {
  __typename?: 'SalesOrderLineItemEdge';
  cursor: Scalars['String']['output'];
  node: SalesOrderLineItem;
};

export enum SalesOrderLineItemFulfillmentStatus {
  /** FULFILLED item */
  Fulfilled = 'FULFILLED',
  /** PENDING item */
  Pending = 'PENDING'
}

export type SalesOrderLineItemFulfillmentStatusEnumFilter = {
  eq?: InputMaybe<SalesOrderLineItemFulfillmentStatus>;
  in?: InputMaybe<Array<InputMaybe<SalesOrderLineItemFulfillmentStatus>>>;
  ne?: InputMaybe<SalesOrderLineItemFulfillmentStatus>;
  nin?: InputMaybe<Array<InputMaybe<SalesOrderLineItemFulfillmentStatus>>>;
};

export enum SalesOrderLineItemOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Discount = 'discount',
  FulfillmentStatus = 'fulfillmentStatus',
  Name = 'name',
  Quantity = 'quantity',
  RequiresShipping = 'requiresShipping',
  ShopifyId = 'shopifyID',
  Sku = 'sku',
  SubtotalPrice = 'subtotalPrice',
  Taxable = 'taxable',
  UnitCompareAtPrice = 'unitCompareAtPrice',
  UnitPrice = 'unitPrice',
  UpdatedAt = 'updatedAt'
}

export type SalesOrderLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: SalesOrderLineItemOrderFieldEnum;
};

/** SalesOrderLineItem model(Input) */
export type SalesOrderLineItemQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<SalesOrderLineItemQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  discount?: InputMaybe<FloatFilter>;
  fulfillmentStatus?: InputMaybe<SalesOrderLineItemFulfillmentStatusEnumFilter>;
  id?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<SalesOrderLineItemQueryInput>>;
  or?: InputMaybe<Array<SalesOrderLineItemQueryInput>>;
  quantity?: InputMaybe<FloatFilter>;
  requiresShipping?: InputMaybe<BoolFilter>;
  salesOrderID?: InputMaybe<UuidFilter>;
  shopifyID?: InputMaybe<StringFilter>;
  sku?: InputMaybe<StringFilter>;
  subtotalPrice?: InputMaybe<FloatFilter>;
  taxable?: InputMaybe<BoolFilter>;
  unitCompareAtPrice?: InputMaybe<FloatFilter>;
  unitPrice?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

/** SalesOrderLineItem model(UpdateInput) */
export type SalesOrderLineItemUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** discount */
  discount?: InputMaybe<Scalars['Float']['input']>;
  /** fulfillmentStatus */
  fulfillmentStatus?: InputMaybe<SalesOrderLineItemFulfillmentStatus>;
  /** name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** quantity */
  quantity?: InputMaybe<Scalars['Float']['input']>;
  /** requiresShipping */
  requiresShipping?: InputMaybe<Scalars['Boolean']['input']>;
  /** salesOrder ID */
  salesOrderID?: InputMaybe<Scalars['ID']['input']>;
  /** Shopify product ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** sku */
  sku?: InputMaybe<Scalars['String']['input']>;
  /** subtotalCost */
  subtotalPrice?: InputMaybe<Scalars['Float']['input']>;
  /** taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** unitCompareAtPrice */
  unitCompareAtPrice?: InputMaybe<Scalars['Float']['input']>;
  /** unitPrice */
  unitPrice?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type SalesOrderLineItemsAggregationAvgResult = {
  __typename?: 'SalesOrderLineItemsAggregationAvgResult';
  /** discount is aggregation field */
  discount?: Maybe<Scalars['Float']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** subtotalPrice is aggregation field */
  subtotalPrice?: Maybe<Scalars['Float']['output']>;
  /** unitCompareAtPrice is aggregation field */
  unitCompareAtPrice?: Maybe<Scalars['Float']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Float']['output']>;
};

export type SalesOrderLineItemsAggregationCountResult = {
  __typename?: 'SalesOrderLineItemsAggregationCountResult';
  /** discount is aggregation field */
  discount?: Maybe<Scalars['Int']['output']>;
  /** fulfillmentStatus is aggregation field */
  fulfillmentStatus?: Maybe<Scalars['Int']['output']>;
  /** name is aggregation field */
  name?: Maybe<Scalars['Int']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** salesOrderID is aggregation field */
  salesOrderID?: Maybe<Scalars['Int']['output']>;
  /** shopifyID is aggregation field */
  shopifyID?: Maybe<Scalars['Int']['output']>;
  /** sku is aggregation field */
  sku?: Maybe<Scalars['Int']['output']>;
  /** subtotalPrice is aggregation field */
  subtotalPrice?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<SalesOrderLineItemsAggregationCountToDayFunc>;
  toHour?: Maybe<SalesOrderLineItemsAggregationCountToHourFunc>;
  toMinute?: Maybe<SalesOrderLineItemsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<SalesOrderLineItemsAggregationCountToMonthFunc>;
  toYear?: Maybe<SalesOrderLineItemsAggregationCountToYearFunc>;
  /** unitCompareAtPrice is aggregation field */
  unitCompareAtPrice?: Maybe<Scalars['Int']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Int']['output']>;
  /** variantID is aggregation field */
  variantID?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrderLineItemsAggregationCountToDayFunc = {
  __typename?: 'SalesOrderLineItemsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrderLineItemsAggregationCountToHourFunc = {
  __typename?: 'SalesOrderLineItemsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrderLineItemsAggregationCountToMinuteFunc = {
  __typename?: 'SalesOrderLineItemsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrderLineItemsAggregationCountToMonthFunc = {
  __typename?: 'SalesOrderLineItemsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrderLineItemsAggregationCountToYearFunc = {
  __typename?: 'SalesOrderLineItemsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrderLineItemsAggregationGroupByResult = {
  __typename?: 'SalesOrderLineItemsAggregationGroupByResult';
  /** discount */
  discount?: Maybe<Scalars['Float']['output']>;
  /** fulfillmentStatus */
  fulfillmentStatus?: Maybe<SalesOrderLineItemsFulfillmentStatus>;
  /** name */
  name?: Maybe<Scalars['String']['output']>;
  /** quantity */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** salesOrder ID */
  salesOrderID?: Maybe<Scalars['ID']['output']>;
  /** Shopify product ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  /** sku */
  sku?: Maybe<Scalars['String']['output']>;
  /** subtotalCost */
  subtotalPrice?: Maybe<Scalars['Float']['output']>;
  toDay?: Maybe<SalesOrderLineItemsAggregationGroupByToDayFunc>;
  toHour?: Maybe<SalesOrderLineItemsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<SalesOrderLineItemsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<SalesOrderLineItemsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<SalesOrderLineItemsAggregationGroupByToYearFunc>;
  /** unitCompareAtPrice */
  unitCompareAtPrice?: Maybe<Scalars['Float']['output']>;
  /** unitPrice */
  unitPrice?: Maybe<Scalars['Float']['output']>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

export type SalesOrderLineItemsAggregationGroupByToDayFunc = {
  __typename?: 'SalesOrderLineItemsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrderLineItemsAggregationGroupByToHourFunc = {
  __typename?: 'SalesOrderLineItemsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrderLineItemsAggregationGroupByToMinuteFunc = {
  __typename?: 'SalesOrderLineItemsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrderLineItemsAggregationGroupByToMonthFunc = {
  __typename?: 'SalesOrderLineItemsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrderLineItemsAggregationGroupByToYearFunc = {
  __typename?: 'SalesOrderLineItemsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrderLineItemsAggregationQuantityResult = {
  __typename?: 'SalesOrderLineItemsAggregationQuantityResult';
  /** discount is aggregation field */
  discount?: Maybe<Scalars['Float']['output']>;
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** subtotalPrice is aggregation field */
  subtotalPrice?: Maybe<Scalars['Float']['output']>;
  /** unitCompareAtPrice is aggregation field */
  unitCompareAtPrice?: Maybe<Scalars['Float']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Float']['output']>;
};

export type SalesOrderLineItemsAggregationResult = {
  __typename?: 'SalesOrderLineItemsAggregationResult';
  avg?: Maybe<SalesOrderLineItemsAggregationAvgResult>;
  count?: Maybe<SalesOrderLineItemsAggregationCountResult>;
  groupBy: SalesOrderLineItemsAggregationGroupByResult;
  max?: Maybe<SalesOrderLineItemsAggregationQuantityResult>;
  min?: Maybe<SalesOrderLineItemsAggregationQuantityResult>;
  sum?: Maybe<SalesOrderLineItemsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum SalesOrderLineItemsFulfillmentStatus {
  Fulfilled = 'FULFILLED',
  Pending = 'PENDING'
}

export enum SalesOrderOrderFieldEnum {
  Active = 'active',
  CancelReason = 'cancelReason',
  CancelledAt = 'cancelledAt',
  CreatedAt = 'createdAt',
  Currency = 'currency',
  CurrentSubtotalPrice = 'currentSubtotalPrice',
  CustomerEmail = 'customerEmail',
  CustomerName = 'customerName',
  OrderNumber = 'orderNumber',
  ShipStationOrderStatus = 'shipStationOrderStatus',
  ShippedAt = 'shippedAt',
  ShopifyCreatedAt = 'shopifyCreatedAt',
  ShopifyId = 'shopifyID',
  UpdatedAt = 'updatedAt'
}

export type SalesOrderOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: SalesOrderOrderFieldEnum;
};

/** SalesOrder model(Input) */
export type SalesOrderQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<SalesOrderQueryInput>>;
  cancelReason?: InputMaybe<StringFilter>;
  cancelledAt?: InputMaybe<DatetimeFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  currency?: InputMaybe<StringFilter>;
  currentSubtotalPrice?: InputMaybe<StringFilter>;
  customerEmail?: InputMaybe<StringFilter>;
  customerID?: InputMaybe<UuidFilter>;
  customerName?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<SalesOrderQueryInput>>;
  or?: InputMaybe<Array<SalesOrderQueryInput>>;
  orderNumber?: InputMaybe<IntegerFilter>;
  shipStationOrderStatus?: InputMaybe<SalesOrderShipStationOrderStatusEnumFilter>;
  shippedAt?: InputMaybe<DatetimeFilter>;
  shopifyCreatedAt?: InputMaybe<DatetimeFilter>;
  shopifyID?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

export enum SalesOrderShipStationOrderStatus {
  /** AWAITING PAYMENT. Order is awaiting payment */
  AwaitingPayment = 'awaiting_payment',
  /** CHANGES NOT SENT. Order has been changed but not sent to ShipStation */
  ChangesNotSent = 'changes_not_sent',
  /** Not yet sent to ShipStation. Order is awaiting payment */
  NotSent = 'not_sent',
  /** SHIPPED. Order has been shipped */
  Shipped = 'shipped'
}

export type SalesOrderShipStationOrderStatusEnumFilter = {
  eq?: InputMaybe<SalesOrderShipStationOrderStatus>;
  in?: InputMaybe<Array<InputMaybe<SalesOrderShipStationOrderStatus>>>;
  ne?: InputMaybe<SalesOrderShipStationOrderStatus>;
  nin?: InputMaybe<Array<InputMaybe<SalesOrderShipStationOrderStatus>>>;
};

/** SalesOrder model(UpdateInput) */
export type SalesOrderUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** Reason for cancellation */
  cancelReason?: InputMaybe<Scalars['String']['input']>;
  /** Cancellation date */
  cancelledAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Currency */
  currency?: InputMaybe<Scalars['String']['input']>;
  /** Current subtotal price */
  currentSubtotalPrice?: InputMaybe<Scalars['String']['input']>;
  /** Customer email */
  customerEmail?: InputMaybe<Scalars['String']['input']>;
  /** Contact model. Contact and this model is n:1 */
  customerID?: InputMaybe<Scalars['ID']['input']>;
  /** Customer name */
  customerName?: InputMaybe<Scalars['String']['input']>;
  /** Order number */
  orderNumber?: InputMaybe<Scalars['Int']['input']>;
  /** inventoryType */
  shipStationOrderStatus?: InputMaybe<SalesOrderShipStationOrderStatus>;
  /** shipped at */
  shippedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Shopify created at */
  shopifyCreatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Shopify order ID */
  shopifyID?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type SalesOrdersAggregationAvgResult = {
  __typename?: 'SalesOrdersAggregationAvgResult';
  /** orderNumber is aggregation field */
  orderNumber?: Maybe<Scalars['Float']['output']>;
};

export type SalesOrdersAggregationCountResult = {
  __typename?: 'SalesOrdersAggregationCountResult';
  /** cancelReason is aggregation field */
  cancelReason?: Maybe<Scalars['Int']['output']>;
  /** currency is aggregation field */
  currency?: Maybe<Scalars['Int']['output']>;
  /** currentSubtotalPrice is aggregation field */
  currentSubtotalPrice?: Maybe<Scalars['Int']['output']>;
  /** customerEmail is aggregation field */
  customerEmail?: Maybe<Scalars['Int']['output']>;
  /** customerID is aggregation field */
  customerID?: Maybe<Scalars['Int']['output']>;
  /** customerName is aggregation field */
  customerName?: Maybe<Scalars['Int']['output']>;
  /** orderNumber is aggregation field */
  orderNumber?: Maybe<Scalars['Int']['output']>;
  /** shipStationOrderStatus is aggregation field */
  shipStationOrderStatus?: Maybe<Scalars['Int']['output']>;
  /** shopifyID is aggregation field */
  shopifyID?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<SalesOrdersAggregationCountToDayFunc>;
  toHour?: Maybe<SalesOrdersAggregationCountToHourFunc>;
  toMinute?: Maybe<SalesOrdersAggregationCountToMinuteFunc>;
  toMonth?: Maybe<SalesOrdersAggregationCountToMonthFunc>;
  toYear?: Maybe<SalesOrdersAggregationCountToYearFunc>;
};

export type SalesOrdersAggregationCountToDayFunc = {
  __typename?: 'SalesOrdersAggregationCountToDayFunc';
  /** cancelledAt is aggregation field */
  cancelledAt?: Maybe<Scalars['Int']['output']>;
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** shopifyCreatedAt is aggregation field */
  shopifyCreatedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrdersAggregationCountToHourFunc = {
  __typename?: 'SalesOrdersAggregationCountToHourFunc';
  /** cancelledAt is aggregation field */
  cancelledAt?: Maybe<Scalars['Int']['output']>;
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** shopifyCreatedAt is aggregation field */
  shopifyCreatedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrdersAggregationCountToMinuteFunc = {
  __typename?: 'SalesOrdersAggregationCountToMinuteFunc';
  /** cancelledAt is aggregation field */
  cancelledAt?: Maybe<Scalars['Int']['output']>;
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** shopifyCreatedAt is aggregation field */
  shopifyCreatedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrdersAggregationCountToMonthFunc = {
  __typename?: 'SalesOrdersAggregationCountToMonthFunc';
  /** cancelledAt is aggregation field */
  cancelledAt?: Maybe<Scalars['Int']['output']>;
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** shopifyCreatedAt is aggregation field */
  shopifyCreatedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrdersAggregationCountToYearFunc = {
  __typename?: 'SalesOrdersAggregationCountToYearFunc';
  /** cancelledAt is aggregation field */
  cancelledAt?: Maybe<Scalars['Int']['output']>;
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** shopifyCreatedAt is aggregation field */
  shopifyCreatedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrdersAggregationGroupByResult = {
  __typename?: 'SalesOrdersAggregationGroupByResult';
  /** Reason for cancellation */
  cancelReason?: Maybe<Scalars['String']['output']>;
  /** Currency */
  currency?: Maybe<Scalars['String']['output']>;
  /** Current subtotal price */
  currentSubtotalPrice?: Maybe<Scalars['String']['output']>;
  /** Customer email */
  customerEmail?: Maybe<Scalars['String']['output']>;
  /** Contact model. Contact and this model is n:1 */
  customerID?: Maybe<Scalars['ID']['output']>;
  /** Customer name */
  customerName?: Maybe<Scalars['String']['output']>;
  /** Order number */
  orderNumber?: Maybe<Scalars['Int']['output']>;
  /** inventoryType */
  shipStationOrderStatus?: Maybe<SalesOrdersShipStationOrderStatus>;
  /** Shopify order ID */
  shopifyID?: Maybe<Scalars['String']['output']>;
  toDay?: Maybe<SalesOrdersAggregationGroupByToDayFunc>;
  toHour?: Maybe<SalesOrdersAggregationGroupByToHourFunc>;
  toMinute?: Maybe<SalesOrdersAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<SalesOrdersAggregationGroupByToMonthFunc>;
  toYear?: Maybe<SalesOrdersAggregationGroupByToYearFunc>;
};

export type SalesOrdersAggregationGroupByToDayFunc = {
  __typename?: 'SalesOrdersAggregationGroupByToDayFunc';
  /** Cancellation date */
  cancelledAt?: Maybe<Scalars['String']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** Shopify created at */
  shopifyCreatedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrdersAggregationGroupByToHourFunc = {
  __typename?: 'SalesOrdersAggregationGroupByToHourFunc';
  /** Cancellation date */
  cancelledAt?: Maybe<Scalars['String']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** Shopify created at */
  shopifyCreatedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrdersAggregationGroupByToMinuteFunc = {
  __typename?: 'SalesOrdersAggregationGroupByToMinuteFunc';
  /** Cancellation date */
  cancelledAt?: Maybe<Scalars['String']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** Shopify created at */
  shopifyCreatedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrdersAggregationGroupByToMonthFunc = {
  __typename?: 'SalesOrdersAggregationGroupByToMonthFunc';
  /** Cancellation date */
  cancelledAt?: Maybe<Scalars['String']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** Shopify created at */
  shopifyCreatedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrdersAggregationGroupByToYearFunc = {
  __typename?: 'SalesOrdersAggregationGroupByToYearFunc';
  /** Cancellation date */
  cancelledAt?: Maybe<Scalars['String']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** Shopify created at */
  shopifyCreatedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type SalesOrdersAggregationQuantityResult = {
  __typename?: 'SalesOrdersAggregationQuantityResult';
  /** orderNumber is aggregation field */
  orderNumber?: Maybe<Scalars['Int']['output']>;
};

export type SalesOrdersAggregationResult = {
  __typename?: 'SalesOrdersAggregationResult';
  avg?: Maybe<SalesOrdersAggregationAvgResult>;
  count?: Maybe<SalesOrdersAggregationCountResult>;
  groupBy: SalesOrdersAggregationGroupByResult;
  max?: Maybe<SalesOrdersAggregationQuantityResult>;
  min?: Maybe<SalesOrdersAggregationQuantityResult>;
  sum?: Maybe<SalesOrdersAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum SalesOrdersShipStationOrderStatus {
  AwaitingPayment = 'awaiting_payment',
  ChangesNotSent = 'changes_not_sent',
  NotSent = 'not_sent',
  Shipped = 'shipped'
}

export type SetWorkOrderStartAndEndDateInput = {
  bookDuration: Scalars['Int']['input'];
  scheduleDateTime: Scalars['DateTime']['input'];
  workOrderId: Scalars['ID']['input'];
};

export type SetWorkOrderStartAndEndDateOutput = {
  __typename?: 'SetWorkOrderStartAndEndDateOutput';
  endDateTime?: Maybe<Scalars['DateTime']['output']>;
  startDateTime?: Maybe<Scalars['DateTime']['output']>;
};

/** Shipment model */
export type Shipment = {
  __typename?: 'Shipment';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Contact model. Contact and this model is n:1 */
  customer?: Maybe<Contact>;
  /** Contact ID */
  customerID?: Maybe<Scalars['ID']['output']>;
  /** date */
  date?: Maybe<Scalars['DateTime']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** SalesOrder model. SalesOrder and this model is n:1. */
  salesOrder?: Maybe<SalesOrder>;
  /** salesOrder ID */
  salesOrderID?: Maybe<Scalars['ID']['output']>;
  /** Shipment number */
  shipmentNumber?: Maybe<Scalars['String']['output']>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Shipment model(Connection) */
export type ShipmentConnection = {
  __typename?: 'ShipmentConnection';
  edges: Array<ShipmentEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Shipment model(CreateInput) */
export type ShipmentCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Contact ID */
  customerID?: InputMaybe<Scalars['ID']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Shipment model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** salesOrder ID */
  salesOrderID?: InputMaybe<Scalars['ID']['input']>;
  /** Shipment number */
  shipmentNumber?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** shipment(Edge) */
export type ShipmentEdge = {
  __typename?: 'ShipmentEdge';
  cursor: Scalars['String']['output'];
  node: Shipment;
};

/** ShipmentLineItem model */
export type ShipmentLineItem = {
  __typename?: 'ShipmentLineItem';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** quantity */
  quantity: Scalars['Float']['output'];
  /** Shipment model. Shipment and this model is n:1. */
  shipment?: Maybe<Shipment>;
  /** Shipment ID */
  shipmentID: Scalars['ID']['output'];
  /** inventoryType */
  shipmentStatus?: Maybe<ShipmentLineItemShipmentStatus>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['DateTime']['output']>;
  /** taxable */
  taxable?: Maybe<Scalars['Boolean']['output']>;
  /** unit cost */
  unitCost: Scalars['Float']['output'];
  /** unit price */
  unitPrice: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

/** ShipmentLineItem model(Connection) */
export type ShipmentLineItemConnection = {
  __typename?: 'ShipmentLineItemConnection';
  edges: Array<ShipmentLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** ShipmentLineItem model(CreateInput) */
export type ShipmentLineItemCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the ShipmentLineItem model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** quantity */
  quantity: Scalars['Float']['input'];
  /** Shipment ID */
  shipmentID: Scalars['ID']['input'];
  /** inventoryType */
  shipmentStatus?: InputMaybe<ShipmentLineItemShipmentStatus>;
  /** shipped at */
  shippedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** unit cost */
  unitCost: Scalars['Float']['input'];
  /** unit price */
  unitPrice: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

/** shipmentLineItem(Edge) */
export type ShipmentLineItemEdge = {
  __typename?: 'ShipmentLineItemEdge';
  cursor: Scalars['String']['output'];
  node: ShipmentLineItem;
};

export enum ShipmentLineItemOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Quantity = 'quantity',
  ShipmentStatus = 'shipmentStatus',
  ShippedAt = 'shippedAt',
  Taxable = 'taxable',
  UnitCost = 'unitCost',
  UnitPrice = 'unitPrice',
  UpdatedAt = 'updatedAt'
}

export type ShipmentLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ShipmentLineItemOrderFieldEnum;
};

/** ShipmentLineItem model(Input) */
export type ShipmentLineItemQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<ShipmentLineItemQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<ShipmentLineItemQueryInput>>;
  or?: InputMaybe<Array<ShipmentLineItemQueryInput>>;
  quantity?: InputMaybe<FloatFilter>;
  shipmentID?: InputMaybe<UuidFilter>;
  shipmentStatus?: InputMaybe<ShipmentLineItemShipmentStatusEnumFilter>;
  shippedAt?: InputMaybe<DatetimeFilter>;
  taxable?: InputMaybe<BoolFilter>;
  unitCost?: InputMaybe<FloatFilter>;
  unitPrice?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

export enum ShipmentLineItemShipmentStatus {
  /** DRAFT State, meaning it can be updated */
  Draft = 'DRAFT',
  /** CANNOT BE EDITED. ONHOLD State, meaning inventory is on hold on hold */
  Onhold = 'ONHOLD',
  /** CANNOT BE EDITED. SHIPPED State, items were shipped */
  Shipped = 'SHIPPED'
}

export type ShipmentLineItemShipmentStatusEnumFilter = {
  eq?: InputMaybe<ShipmentLineItemShipmentStatus>;
  in?: InputMaybe<Array<InputMaybe<ShipmentLineItemShipmentStatus>>>;
  ne?: InputMaybe<ShipmentLineItemShipmentStatus>;
  nin?: InputMaybe<Array<InputMaybe<ShipmentLineItemShipmentStatus>>>;
};

/** ShipmentLineItem model(UpdateInput) */
export type ShipmentLineItemUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** quantity */
  quantity?: InputMaybe<Scalars['Float']['input']>;
  /** Shipment ID */
  shipmentID?: InputMaybe<Scalars['ID']['input']>;
  /** inventoryType */
  shipmentStatus?: InputMaybe<ShipmentLineItemShipmentStatus>;
  /** shipped at */
  shippedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** taxable */
  taxable?: InputMaybe<Scalars['Boolean']['input']>;
  /** unit cost */
  unitCost?: InputMaybe<Scalars['Float']['input']>;
  /** unit price */
  unitPrice?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type ShipmentLineItemsAggregationAvgResult = {
  __typename?: 'ShipmentLineItemsAggregationAvgResult';
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Float']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Float']['output']>;
};

export type ShipmentLineItemsAggregationCountResult = {
  __typename?: 'ShipmentLineItemsAggregationCountResult';
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** shipmentID is aggregation field */
  shipmentID?: Maybe<Scalars['Int']['output']>;
  /** shipmentStatus is aggregation field */
  shipmentStatus?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<ShipmentLineItemsAggregationCountToDayFunc>;
  toHour?: Maybe<ShipmentLineItemsAggregationCountToHourFunc>;
  toMinute?: Maybe<ShipmentLineItemsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<ShipmentLineItemsAggregationCountToMonthFunc>;
  toYear?: Maybe<ShipmentLineItemsAggregationCountToYearFunc>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Int']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Int']['output']>;
  /** variantID is aggregation field */
  variantID?: Maybe<Scalars['Int']['output']>;
};

export type ShipmentLineItemsAggregationCountToDayFunc = {
  __typename?: 'ShipmentLineItemsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ShipmentLineItemsAggregationCountToHourFunc = {
  __typename?: 'ShipmentLineItemsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ShipmentLineItemsAggregationCountToMinuteFunc = {
  __typename?: 'ShipmentLineItemsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ShipmentLineItemsAggregationCountToMonthFunc = {
  __typename?: 'ShipmentLineItemsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ShipmentLineItemsAggregationCountToYearFunc = {
  __typename?: 'ShipmentLineItemsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** shippedAt is aggregation field */
  shippedAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type ShipmentLineItemsAggregationGroupByResult = {
  __typename?: 'ShipmentLineItemsAggregationGroupByResult';
  /** quantity */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** Shipment ID */
  shipmentID?: Maybe<Scalars['ID']['output']>;
  /** inventoryType */
  shipmentStatus?: Maybe<ShipmentLineItemsShipmentStatus>;
  toDay?: Maybe<ShipmentLineItemsAggregationGroupByToDayFunc>;
  toHour?: Maybe<ShipmentLineItemsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<ShipmentLineItemsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<ShipmentLineItemsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<ShipmentLineItemsAggregationGroupByToYearFunc>;
  /** unit cost */
  unitCost?: Maybe<Scalars['Float']['output']>;
  /** unit price */
  unitPrice?: Maybe<Scalars['Float']['output']>;
  /** Variant ID */
  variantID?: Maybe<Scalars['ID']['output']>;
};

export type ShipmentLineItemsAggregationGroupByToDayFunc = {
  __typename?: 'ShipmentLineItemsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ShipmentLineItemsAggregationGroupByToHourFunc = {
  __typename?: 'ShipmentLineItemsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ShipmentLineItemsAggregationGroupByToMinuteFunc = {
  __typename?: 'ShipmentLineItemsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ShipmentLineItemsAggregationGroupByToMonthFunc = {
  __typename?: 'ShipmentLineItemsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ShipmentLineItemsAggregationGroupByToYearFunc = {
  __typename?: 'ShipmentLineItemsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** shipped at */
  shippedAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type ShipmentLineItemsAggregationQuantityResult = {
  __typename?: 'ShipmentLineItemsAggregationQuantityResult';
  /** quantity is aggregation field */
  quantity?: Maybe<Scalars['Float']['output']>;
  /** unitCost is aggregation field */
  unitCost?: Maybe<Scalars['Float']['output']>;
  /** unitPrice is aggregation field */
  unitPrice?: Maybe<Scalars['Float']['output']>;
};

export type ShipmentLineItemsAggregationResult = {
  __typename?: 'ShipmentLineItemsAggregationResult';
  avg?: Maybe<ShipmentLineItemsAggregationAvgResult>;
  count?: Maybe<ShipmentLineItemsAggregationCountResult>;
  groupBy: ShipmentLineItemsAggregationGroupByResult;
  max?: Maybe<ShipmentLineItemsAggregationQuantityResult>;
  min?: Maybe<ShipmentLineItemsAggregationQuantityResult>;
  sum?: Maybe<ShipmentLineItemsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum ShipmentLineItemsShipmentStatus {
  Draft = 'DRAFT',
  Onhold = 'ONHOLD',
  Shipped = 'SHIPPED'
}

export enum ShipmentOrderFieldEnum {
  Active = 'active',
  CreatedAt = 'createdAt',
  Date = 'date',
  ShipmentNumber = 'shipmentNumber',
  UpdatedAt = 'updatedAt'
}

export type ShipmentOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: ShipmentOrderFieldEnum;
};

/** Shipment model(Input) */
export type ShipmentQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<ShipmentQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  customerID?: InputMaybe<UuidFilter>;
  date?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<ShipmentQueryInput>>;
  or?: InputMaybe<Array<ShipmentQueryInput>>;
  salesOrderID?: InputMaybe<UuidFilter>;
  shipmentNumber?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Shipment model(UpdateInput) */
export type ShipmentUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Contact ID */
  customerID?: InputMaybe<Scalars['ID']['input']>;
  /** date */
  date?: InputMaybe<Scalars['DateTime']['input']>;
  /** salesOrder ID */
  salesOrderID?: InputMaybe<Scalars['ID']['input']>;
  /** Shipment number */
  shipmentNumber?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type SimulateInputRequirementByOutputQuantityInput = {
  bomId: Scalars['ID']['input'];
  outputQuantity: Scalars['Float']['input'];
};

export type SimulateOutputByIngredientsInput = {
  bomId?: InputMaybe<Scalars['ID']['input']>;
  inputQuantities?: InputMaybe<Array<InputMaybe<ListInput>>>;
};

export enum StockEventAction {
  Hold = 'HOLD',
  Release = 'RELEASE',
  Ship = 'SHIP'
}

/** StockSummary model */
export type StockSummary = {
  __typename?: 'StockSummary';
  /** active */
  active?: Maybe<Scalars['Boolean']['output']>;
  /** availableQuantity */
  availableQuantity: Scalars['Float']['output'];
  /** averageCost */
  averageCost?: Maybe<Scalars['Float']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: Maybe<Scalars['Float']['output']>;
  /** onHoldQuantity */
  onHoldQuantity: Scalars['Float']['output'];
  /** totalCost */
  totalCost: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Variant */
  variant?: Maybe<ProductVariant>;
  /** Variant ID */
  variantID: Scalars['ID']['output'];
};

/** StockSummary model(Connection) */
export type StockSummaryConnection = {
  __typename?: 'StockSummaryConnection';
  edges: Array<StockSummaryEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** StockSummary model(CreateInput) */
export type StockSummaryCreateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** availableQuantity */
  availableQuantity: Scalars['Float']['input'];
  /** averageCost */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the StockSummary model */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** onHoldQuantity */
  onHoldQuantity: Scalars['Float']['input'];
  /** totalCost */
  totalCost: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID: Scalars['ID']['input'];
};

/** stockSummary(Edge) */
export type StockSummaryEdge = {
  __typename?: 'StockSummaryEdge';
  cursor: Scalars['String']['output'];
  node: StockSummary;
};

export enum StockSummaryOrderFieldEnum {
  Active = 'active',
  AvailableQuantity = 'availableQuantity',
  AverageCost = 'averageCost',
  CreatedAt = 'createdAt',
  InStockQuantity = 'inStockQuantity',
  OnHoldQuantity = 'onHoldQuantity',
  TotalCost = 'totalCost',
  UpdatedAt = 'updatedAt'
}

export type StockSummaryOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: StockSummaryOrderFieldEnum;
};

/** StockSummary model(Input) */
export type StockSummaryQueryInput = {
  active?: InputMaybe<BoolFilter>;
  and?: InputMaybe<Array<StockSummaryQueryInput>>;
  availableQuantity?: InputMaybe<FloatFilter>;
  averageCost?: InputMaybe<FloatFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  inStockQuantity?: InputMaybe<FloatFilter>;
  not?: InputMaybe<Array<StockSummaryQueryInput>>;
  onHoldQuantity?: InputMaybe<FloatFilter>;
  or?: InputMaybe<Array<StockSummaryQueryInput>>;
  totalCost?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  variantID?: InputMaybe<UuidFilter>;
};

/** StockSummary model(UpdateInput) */
export type StockSummaryUpdateInput = {
  /** active */
  active?: InputMaybe<Scalars['Boolean']['input']>;
  /** availableQuantity */
  availableQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** averageCost */
  averageCost?: InputMaybe<Scalars['Float']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock. */
  inStockQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** onHoldQuantity */
  onHoldQuantity?: InputMaybe<Scalars['Float']['input']>;
  /** totalCost */
  totalCost?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Variant ID */
  variantID?: InputMaybe<Scalars['ID']['input']>;
};

export type StringFilter = {
  contains?: InputMaybe<Scalars['String']['input']>;
  eq?: InputMaybe<Scalars['String']['input']>;
  in?: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  ne?: InputMaybe<Scalars['String']['input']>;
  nin?: InputMaybe<Array<InputMaybe<Scalars['String']['input']>>>;
  regex?: InputMaybe<Scalars['String']['input']>;
};

export type TimeBetweenFilter = {
  max?: InputMaybe<Scalars['Time']['input']>;
  min?: InputMaybe<Scalars['Time']['input']>;
};

export type TimeFilter = {
  between?: InputMaybe<TimeBetweenFilter>;
  eq?: InputMaybe<Scalars['Time']['input']>;
  gt?: InputMaybe<Scalars['Time']['input']>;
  gte?: InputMaybe<Scalars['Time']['input']>;
  in?: InputMaybe<Array<InputMaybe<Scalars['Time']['input']>>>;
  lt?: InputMaybe<Scalars['Time']['input']>;
  lte?: InputMaybe<Scalars['Time']['input']>;
  ne?: InputMaybe<Scalars['Time']['input']>;
  nin?: InputMaybe<Array<InputMaybe<Scalars['Time']['input']>>>;
};

export type UuidFilter = {
  eq?: InputMaybe<Scalars['ID']['input']>;
  in?: InputMaybe<Array<InputMaybe<Scalars['ID']['input']>>>;
  ne?: InputMaybe<Scalars['ID']['input']>;
  nin?: InputMaybe<Array<InputMaybe<Scalars['ID']['input']>>>;
};

export type UnPlanManufacturingOrderInput = {
  manufacturingOrderId: Scalars['ID']['input'];
};

export type UnPlanManufacturingOrderOutput = {
  __typename?: 'UnPlanManufacturingOrderOutput';
  success?: Maybe<Scalars['Boolean']['output']>;
};

/** Unit of Measure */
export type Uom = {
  __typename?: 'Uom';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Detailed description of the unit of measure */
  description?: Maybe<Scalars['String']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Indicates if the unit of measure is active */
  isActive?: Maybe<Scalars['Boolean']['output']>;
  /** Name of the unit of measure */
  name: Scalars['String']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Unit of Measure(Connection) */
export type UomConnection = {
  __typename?: 'UomConnection';
  edges: Array<UomEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** UOMConversion description */
export type UomConversion = {
  __typename?: 'UomConversion';
  /** Factor used to convert between units */
  conversionFactor: Scalars['Float']['output'];
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Link to the source Unit of Measure */
  fromUom?: Maybe<Uom>;
  /** Unique identifier of the source unit of measure */
  fromUomId: Scalars['ID']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /** Link to the target Unit of Measure */
  toUom?: Maybe<Uom>;
  /** Unique identifier of the target unit of measure */
  toUomId: Scalars['ID']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

export type UomConversionCompositeKey = {
  /** Unique identifier of the source unit of measure */
  fromUomId: Scalars['ID']['input'];
  /** Unique identifier of the target unit of measure */
  toUomId: Scalars['ID']['input'];
};

/** UOMConversion description(Connection) */
export type UomConversionConnection = {
  __typename?: 'UomConversionConnection';
  edges: Array<UomConversionEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** UOMConversion description(CreateInput) */
export type UomConversionCreateInput = {
  /** Factor used to convert between units */
  conversionFactor: Scalars['Float']['input'];
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Unique identifier of the source unit of measure */
  fromUomId: Scalars['ID']['input'];
  /** ID of the UOMConversion description */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the target unit of measure */
  toUomId: Scalars['ID']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** uomConversion(Edge) */
export type UomConversionEdge = {
  __typename?: 'UomConversionEdge';
  cursor: Scalars['String']['output'];
  node: UomConversion;
};

export enum UomConversionOrderFieldEnum {
  ConversionFactor = 'conversionFactor',
  CreatedAt = 'createdAt',
  UpdatedAt = 'updatedAt'
}

export type UomConversionOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: UomConversionOrderFieldEnum;
};

/** UOMConversion description(Input) */
export type UomConversionQueryInput = {
  and?: InputMaybe<Array<UomConversionQueryInput>>;
  conversionFactor?: InputMaybe<FloatFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  fromUomId?: InputMaybe<UuidFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<UomConversionQueryInput>>;
  or?: InputMaybe<Array<UomConversionQueryInput>>;
  toUomId?: InputMaybe<UuidFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** UOMConversion description(UpdateInput) */
export type UomConversionUpdateInput = {
  /** Factor used to convert between units */
  conversionFactor?: InputMaybe<Scalars['Float']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Unique identifier of the source unit of measure */
  fromUomId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the target unit of measure */
  toUomId?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** Unit of Measure(CreateInput) */
export type UomCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Detailed description of the unit of measure */
  description?: InputMaybe<Scalars['String']['input']>;
  /** ID of the Unit of Measure */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Indicates if the unit of measure is active */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Name of the unit of measure */
  name: Scalars['String']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** uom(Edge) */
export type UomEdge = {
  __typename?: 'UomEdge';
  cursor: Scalars['String']['output'];
  node: Uom;
};

export enum UomOrderFieldEnum {
  CreatedAt = 'createdAt',
  Description = 'description',
  IsActive = 'isActive',
  Name = 'name',
  UpdatedAt = 'updatedAt'
}

export type UomOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: UomOrderFieldEnum;
};

/** Unit of Measure(Input) */
export type UomQueryInput = {
  and?: InputMaybe<Array<UomQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  description?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  isActive?: InputMaybe<BoolFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<UomQueryInput>>;
  or?: InputMaybe<Array<UomQueryInput>>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Unit of Measure(UpdateInput) */
export type UomUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Detailed description of the unit of measure */
  description?: InputMaybe<Scalars['String']['input']>;
  /** Indicates if the unit of measure is active */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Name of the unit of measure */
  name?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** User of the system */
export type User = {
  __typename?: 'User';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Email of the user */
  email: Scalars['String']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /** Name of the user */
  name: Scalars['String']['output'];
  /** Role IDs of the user */
  roles?: Maybe<Array<Scalars['ID']['output']>>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** User of the system(Connection) */
export type UserConnection = {
  __typename?: 'UserConnection';
  edges: Array<UserEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** User of the system(CreateInput) */
export type UserCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Email of the user */
  email: Scalars['String']['input'];
  /** ID of the User of the system */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Name of the user */
  name: Scalars['String']['input'];
  /** Role IDs of the user */
  roles?: InputMaybe<Array<Scalars['ID']['input']>>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** user(Edge) */
export type UserEdge = {
  __typename?: 'UserEdge';
  cursor: Scalars['String']['output'];
  node: User;
};

export enum UserOrderFieldEnum {
  CreatedAt = 'createdAt',
  Email = 'email',
  Name = 'name',
  UpdatedAt = 'updatedAt'
}

export type UserOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: UserOrderFieldEnum;
};

/** User of the system(Input) */
export type UserQueryInput = {
  and?: InputMaybe<Array<UserQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  email?: InputMaybe<StringFilter>;
  id?: InputMaybe<UuidFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<UserQueryInput>>;
  or?: InputMaybe<Array<UserQueryInput>>;
  roles?: InputMaybe<UuidFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** User of the system(UpdateInput) */
export type UserUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Email of the user */
  email?: InputMaybe<Scalars['String']['input']>;
  /** Name of the user */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Role IDs of the user */
  roles?: InputMaybe<Array<Scalars['ID']['input']>>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** Time tracking by employee */
export type WoTimeTracking = {
  __typename?: 'WOTimeTracking';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Minutes worked */
  duration: Scalars['Int']['output'];
  /** Link to the Employee */
  employee?: Maybe<Employee>;
  /** ID of the Employee */
  employeeId: Scalars['ID']['output'];
  /** End date */
  endDate?: Maybe<Scalars['DateTime']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Start date */
  startDate: Scalars['DateTime']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Link to the WorkOrder */
  workOrder?: Maybe<WorkOrder>;
  /** ID of the WorkOrder */
  workOrderId: Scalars['ID']['output'];
};

/** Time tracking by employee(Connection) */
export type WoTimeTrackingConnection = {
  __typename?: 'WOTimeTrackingConnection';
  edges: Array<WoTimeTrackingEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Time tracking by employee(CreateInput) */
export type WoTimeTrackingCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Minutes worked */
  duration: Scalars['Int']['input'];
  /** ID of the Employee */
  employeeId: Scalars['ID']['input'];
  /** End date */
  endDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Time tracking by employee */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Start date */
  startDate: Scalars['DateTime']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the WorkOrder */
  workOrderId: Scalars['ID']['input'];
};

/** wOTimeTracking(Edge) */
export type WoTimeTrackingEdge = {
  __typename?: 'WOTimeTrackingEdge';
  cursor: Scalars['String']['output'];
  node: WoTimeTracking;
};

export enum WoTimeTrackingOrderFieldEnum {
  CreatedAt = 'createdAt',
  Duration = 'duration',
  EndDate = 'endDate',
  StartDate = 'startDate',
  UpdatedAt = 'updatedAt'
}

export type WoTimeTrackingOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: WoTimeTrackingOrderFieldEnum;
};

/** Time tracking by employee(Input) */
export type WoTimeTrackingQueryInput = {
  and?: InputMaybe<Array<WoTimeTrackingQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  duration?: InputMaybe<IntegerFilter>;
  employeeId?: InputMaybe<UuidFilter>;
  endDate?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<WoTimeTrackingQueryInput>>;
  or?: InputMaybe<Array<WoTimeTrackingQueryInput>>;
  startDate?: InputMaybe<DatetimeFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  workOrderId?: InputMaybe<UuidFilter>;
};

/** Time tracking by employee(UpdateInput) */
export type WoTimeTrackingUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Minutes worked */
  duration?: InputMaybe<Scalars['Int']['input']>;
  /** ID of the Employee */
  employeeId?: InputMaybe<Scalars['ID']['input']>;
  /** End date */
  endDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** Start date */
  startDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the WorkOrder */
  workOrderId?: InputMaybe<Scalars['ID']['input']>;
};

export type WoTimeTrackingsAggregationAvgResult = {
  __typename?: 'WOTimeTrackingsAggregationAvgResult';
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Float']['output']>;
};

export type WoTimeTrackingsAggregationCountResult = {
  __typename?: 'WOTimeTrackingsAggregationCountResult';
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Int']['output']>;
  /** employeeId is aggregation field */
  employeeId?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<WoTimeTrackingsAggregationCountToDayFunc>;
  toHour?: Maybe<WoTimeTrackingsAggregationCountToHourFunc>;
  toMinute?: Maybe<WoTimeTrackingsAggregationCountToMinuteFunc>;
  toMonth?: Maybe<WoTimeTrackingsAggregationCountToMonthFunc>;
  toYear?: Maybe<WoTimeTrackingsAggregationCountToYearFunc>;
  /** workOrderId is aggregation field */
  workOrderId?: Maybe<Scalars['Int']['output']>;
};

export type WoTimeTrackingsAggregationCountToDayFunc = {
  __typename?: 'WOTimeTrackingsAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WoTimeTrackingsAggregationCountToHourFunc = {
  __typename?: 'WOTimeTrackingsAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WoTimeTrackingsAggregationCountToMinuteFunc = {
  __typename?: 'WOTimeTrackingsAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WoTimeTrackingsAggregationCountToMonthFunc = {
  __typename?: 'WOTimeTrackingsAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WoTimeTrackingsAggregationCountToYearFunc = {
  __typename?: 'WOTimeTrackingsAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WoTimeTrackingsAggregationGroupByResult = {
  __typename?: 'WOTimeTrackingsAggregationGroupByResult';
  /** Minutes worked */
  duration?: Maybe<Scalars['Int']['output']>;
  /** ID of the Employee */
  employeeId?: Maybe<Scalars['ID']['output']>;
  toDay?: Maybe<WoTimeTrackingsAggregationGroupByToDayFunc>;
  toHour?: Maybe<WoTimeTrackingsAggregationGroupByToHourFunc>;
  toMinute?: Maybe<WoTimeTrackingsAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<WoTimeTrackingsAggregationGroupByToMonthFunc>;
  toYear?: Maybe<WoTimeTrackingsAggregationGroupByToYearFunc>;
  /** ID of the WorkOrder */
  workOrderId?: Maybe<Scalars['ID']['output']>;
};

export type WoTimeTrackingsAggregationGroupByToDayFunc = {
  __typename?: 'WOTimeTrackingsAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** End date */
  endDate?: Maybe<Scalars['String']['output']>;
  /** Start date */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WoTimeTrackingsAggregationGroupByToHourFunc = {
  __typename?: 'WOTimeTrackingsAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** End date */
  endDate?: Maybe<Scalars['String']['output']>;
  /** Start date */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WoTimeTrackingsAggregationGroupByToMinuteFunc = {
  __typename?: 'WOTimeTrackingsAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** End date */
  endDate?: Maybe<Scalars['String']['output']>;
  /** Start date */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WoTimeTrackingsAggregationGroupByToMonthFunc = {
  __typename?: 'WOTimeTrackingsAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** End date */
  endDate?: Maybe<Scalars['String']['output']>;
  /** Start date */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WoTimeTrackingsAggregationGroupByToYearFunc = {
  __typename?: 'WOTimeTrackingsAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** End date */
  endDate?: Maybe<Scalars['String']['output']>;
  /** Start date */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WoTimeTrackingsAggregationQuantityResult = {
  __typename?: 'WOTimeTrackingsAggregationQuantityResult';
  /** duration is aggregation field */
  duration?: Maybe<Scalars['Int']['output']>;
};

export type WoTimeTrackingsAggregationResult = {
  __typename?: 'WOTimeTrackingsAggregationResult';
  avg?: Maybe<WoTimeTrackingsAggregationAvgResult>;
  count?: Maybe<WoTimeTrackingsAggregationCountResult>;
  groupBy: WoTimeTrackingsAggregationGroupByResult;
  max?: Maybe<WoTimeTrackingsAggregationQuantityResult>;
  min?: Maybe<WoTimeTrackingsAggregationQuantityResult>;
  sum?: Maybe<WoTimeTrackingsAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

/** Work Center are the physical locations where the production happens */
export type WorkCenter = {
  __typename?: 'WorkCenter';
  /** Clean time required to get the work center ready for the next work order */
  cleanupTime?: Maybe<Scalars['Int']['output']>;
  /** Work station identification short code */
  code: Scalars['String']['output'];
  /** Hourly cost of the employee at the work center */
  costPerEmployee?: Maybe<Scalars['Int']['output']>;
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Work Center Description */
  description?: Maybe<Scalars['String']['output']>;
  /** Hourly processing cost of the center. Includes electricity cost, average usage cost, rental cost etc. */
  hourlyProcessingCost: Scalars['Int']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /** Is the work center active? */
  isActive?: Maybe<Scalars['Boolean']['output']>;
  /** Work Center Name */
  name: Scalars['String']['output'];
  /** Number of items that can be parallelly processed */
  parallelProcessingLimit: Scalars['Int']['output'];
  /** Setup time required to get the work center ready before each work order */
  setupTime?: Maybe<Scalars['Int']['output']>;
  /**
   * % efficiency of a work center,
   *   eg. If the operational time is 60 mins, and efficiency is 50%
   *   then the usage time will be calculated as 120 mins because the work center is operating slower.
   *   Ranges from 0 to 100.
   */
  timeEfficiency: Scalars['Float']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Link to the Working Hours for the work center */
  workingHours?: Maybe<WorkingHour>;
  /** ID of the Working hours for the work center */
  workingHoursId: Scalars['ID']['output'];
};

/** Work Center are the physical locations where the production happens(Connection) */
export type WorkCenterConnection = {
  __typename?: 'WorkCenterConnection';
  edges: Array<WorkCenterEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Work Center are the physical locations where the production happens(CreateInput) */
export type WorkCenterCreateInput = {
  /** Clean time required to get the work center ready for the next work order */
  cleanupTime?: InputMaybe<Scalars['Int']['input']>;
  /** Work station identification short code */
  code: Scalars['String']['input'];
  /** Hourly cost of the employee at the work center */
  costPerEmployee?: InputMaybe<Scalars['Int']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work Center Description */
  description?: InputMaybe<Scalars['String']['input']>;
  /** Hourly processing cost of the center. Includes electricity cost, average usage cost, rental cost etc. */
  hourlyProcessingCost: Scalars['Int']['input'];
  /** ID of the Work Center are the physical locations where the production happens */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Is the work center active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Work Center Name */
  name: Scalars['String']['input'];
  /** Number of items that can be parallelly processed */
  parallelProcessingLimit: Scalars['Int']['input'];
  /** Setup time required to get the work center ready before each work order */
  setupTime?: InputMaybe<Scalars['Int']['input']>;
  /**
   * % efficiency of a work center,
   *   eg. If the operational time is 60 mins, and efficiency is 50%
   *   then the usage time will be calculated as 120 mins because the work center is operating slower.
   *   Ranges from 0 to 100.
   */
  timeEfficiency: Scalars['Float']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Working hours for the work center */
  workingHoursId: Scalars['ID']['input'];
};

/** workCenter(Edge) */
export type WorkCenterEdge = {
  __typename?: 'WorkCenterEdge';
  cursor: Scalars['String']['output'];
  node: WorkCenter;
};

export enum WorkCenterOrderFieldEnum {
  CleanupTime = 'cleanupTime',
  Code = 'code',
  CostPerEmployee = 'costPerEmployee',
  CreatedAt = 'createdAt',
  Description = 'description',
  HourlyProcessingCost = 'hourlyProcessingCost',
  IsActive = 'isActive',
  Name = 'name',
  ParallelProcessingLimit = 'parallelProcessingLimit',
  SetupTime = 'setupTime',
  TimeEfficiency = 'timeEfficiency',
  UpdatedAt = 'updatedAt'
}

export type WorkCenterOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: WorkCenterOrderFieldEnum;
};

/** Work Center are the physical locations where the production happens(Input) */
export type WorkCenterQueryInput = {
  and?: InputMaybe<Array<WorkCenterQueryInput>>;
  cleanupTime?: InputMaybe<IntegerFilter>;
  code?: InputMaybe<StringFilter>;
  costPerEmployee?: InputMaybe<IntegerFilter>;
  createdAt?: InputMaybe<DatetimeFilter>;
  description?: InputMaybe<StringFilter>;
  hourlyProcessingCost?: InputMaybe<IntegerFilter>;
  id?: InputMaybe<UuidFilter>;
  isActive?: InputMaybe<BoolFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<WorkCenterQueryInput>>;
  or?: InputMaybe<Array<WorkCenterQueryInput>>;
  parallelProcessingLimit?: InputMaybe<IntegerFilter>;
  setupTime?: InputMaybe<IntegerFilter>;
  timeEfficiency?: InputMaybe<FloatFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  workingHoursId?: InputMaybe<UuidFilter>;
};

/** Work Center are the physical locations where the production happens(UpdateInput) */
export type WorkCenterUpdateInput = {
  /** Clean time required to get the work center ready for the next work order */
  cleanupTime?: InputMaybe<Scalars['Int']['input']>;
  /** Work station identification short code */
  code?: InputMaybe<Scalars['String']['input']>;
  /** Hourly cost of the employee at the work center */
  costPerEmployee?: InputMaybe<Scalars['Int']['input']>;
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Work Center Description */
  description?: InputMaybe<Scalars['String']['input']>;
  /** Hourly processing cost of the center. Includes electricity cost, average usage cost, rental cost etc. */
  hourlyProcessingCost?: InputMaybe<Scalars['Int']['input']>;
  /** Is the work center active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Work Center Name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Number of items that can be parallelly processed */
  parallelProcessingLimit?: InputMaybe<Scalars['Int']['input']>;
  /** Setup time required to get the work center ready before each work order */
  setupTime?: InputMaybe<Scalars['Int']['input']>;
  /**
   * % efficiency of a work center,
   *   eg. If the operational time is 60 mins, and efficiency is 50%
   *   then the usage time will be calculated as 120 mins because the work center is operating slower.
   *   Ranges from 0 to 100.
   */
  timeEfficiency?: InputMaybe<Scalars['Float']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Working hours for the work center */
  workingHoursId?: InputMaybe<Scalars['ID']['input']>;
};

export type WorkCentersAggregationAvgResult = {
  __typename?: 'WorkCentersAggregationAvgResult';
  /** cleanupTime is aggregation field */
  cleanupTime?: Maybe<Scalars['Float']['output']>;
  /** costPerEmployee is aggregation field */
  costPerEmployee?: Maybe<Scalars['Float']['output']>;
  /** hourlyProcessingCost is aggregation field */
  hourlyProcessingCost?: Maybe<Scalars['Float']['output']>;
  /** parallelProcessingLimit is aggregation field */
  parallelProcessingLimit?: Maybe<Scalars['Float']['output']>;
  /** setupTime is aggregation field */
  setupTime?: Maybe<Scalars['Float']['output']>;
  /** timeEfficiency is aggregation field */
  timeEfficiency?: Maybe<Scalars['Float']['output']>;
};

export type WorkCentersAggregationCountResult = {
  __typename?: 'WorkCentersAggregationCountResult';
  /** cleanupTime is aggregation field */
  cleanupTime?: Maybe<Scalars['Int']['output']>;
  /** code is aggregation field */
  code?: Maybe<Scalars['Int']['output']>;
  /** costPerEmployee is aggregation field */
  costPerEmployee?: Maybe<Scalars['Int']['output']>;
  /** description is aggregation field */
  description?: Maybe<Scalars['Int']['output']>;
  /** hourlyProcessingCost is aggregation field */
  hourlyProcessingCost?: Maybe<Scalars['Int']['output']>;
  /** name is aggregation field */
  name?: Maybe<Scalars['Int']['output']>;
  /** parallelProcessingLimit is aggregation field */
  parallelProcessingLimit?: Maybe<Scalars['Int']['output']>;
  /** setupTime is aggregation field */
  setupTime?: Maybe<Scalars['Int']['output']>;
  /** timeEfficiency is aggregation field */
  timeEfficiency?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<WorkCentersAggregationCountToDayFunc>;
  toHour?: Maybe<WorkCentersAggregationCountToHourFunc>;
  toMinute?: Maybe<WorkCentersAggregationCountToMinuteFunc>;
  toMonth?: Maybe<WorkCentersAggregationCountToMonthFunc>;
  toYear?: Maybe<WorkCentersAggregationCountToYearFunc>;
  /** workingHoursId is aggregation field */
  workingHoursId?: Maybe<Scalars['Int']['output']>;
};

export type WorkCentersAggregationCountToDayFunc = {
  __typename?: 'WorkCentersAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkCentersAggregationCountToHourFunc = {
  __typename?: 'WorkCentersAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkCentersAggregationCountToMinuteFunc = {
  __typename?: 'WorkCentersAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkCentersAggregationCountToMonthFunc = {
  __typename?: 'WorkCentersAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkCentersAggregationCountToYearFunc = {
  __typename?: 'WorkCentersAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkCentersAggregationGroupByResult = {
  __typename?: 'WorkCentersAggregationGroupByResult';
  /** Clean time required to get the work center ready for the next work order */
  cleanupTime?: Maybe<Scalars['Int']['output']>;
  /** Work station identification short code */
  code?: Maybe<Scalars['String']['output']>;
  /** Hourly cost of the employee at the work center */
  costPerEmployee?: Maybe<Scalars['Int']['output']>;
  /** Work Center Description */
  description?: Maybe<Scalars['String']['output']>;
  /** Hourly processing cost of the center. Includes electricity cost, average usage cost, rental cost etc. */
  hourlyProcessingCost?: Maybe<Scalars['Int']['output']>;
  /** Work Center Name */
  name?: Maybe<Scalars['String']['output']>;
  /** Number of items that can be parallelly processed */
  parallelProcessingLimit?: Maybe<Scalars['Int']['output']>;
  /** Setup time required to get the work center ready before each work order */
  setupTime?: Maybe<Scalars['Int']['output']>;
  /**
   * % efficiency of a work center,
   *   eg. If the operational time is 60 mins, and efficiency is 50%
   *   then the usage time will be calculated as 120 mins because the work center is operating slower.
   *   Ranges from 0 to 100.
   */
  timeEfficiency?: Maybe<Scalars['Float']['output']>;
  toDay?: Maybe<WorkCentersAggregationGroupByToDayFunc>;
  toHour?: Maybe<WorkCentersAggregationGroupByToHourFunc>;
  toMinute?: Maybe<WorkCentersAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<WorkCentersAggregationGroupByToMonthFunc>;
  toYear?: Maybe<WorkCentersAggregationGroupByToYearFunc>;
  /** ID of the Working hours for the work center */
  workingHoursId?: Maybe<Scalars['ID']['output']>;
};

export type WorkCentersAggregationGroupByToDayFunc = {
  __typename?: 'WorkCentersAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkCentersAggregationGroupByToHourFunc = {
  __typename?: 'WorkCentersAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkCentersAggregationGroupByToMinuteFunc = {
  __typename?: 'WorkCentersAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkCentersAggregationGroupByToMonthFunc = {
  __typename?: 'WorkCentersAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkCentersAggregationGroupByToYearFunc = {
  __typename?: 'WorkCentersAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkCentersAggregationQuantityResult = {
  __typename?: 'WorkCentersAggregationQuantityResult';
  /** cleanupTime is aggregation field */
  cleanupTime?: Maybe<Scalars['Int']['output']>;
  /** costPerEmployee is aggregation field */
  costPerEmployee?: Maybe<Scalars['Int']['output']>;
  /** hourlyProcessingCost is aggregation field */
  hourlyProcessingCost?: Maybe<Scalars['Int']['output']>;
  /** parallelProcessingLimit is aggregation field */
  parallelProcessingLimit?: Maybe<Scalars['Int']['output']>;
  /** setupTime is aggregation field */
  setupTime?: Maybe<Scalars['Int']['output']>;
  /** timeEfficiency is aggregation field */
  timeEfficiency?: Maybe<Scalars['Float']['output']>;
};

export type WorkCentersAggregationResult = {
  __typename?: 'WorkCentersAggregationResult';
  avg?: Maybe<WorkCentersAggregationAvgResult>;
  count?: Maybe<WorkCentersAggregationCountResult>;
  groupBy: WorkCentersAggregationGroupByResult;
  max?: Maybe<WorkCentersAggregationQuantityResult>;
  min?: Maybe<WorkCentersAggregationQuantityResult>;
  sum?: Maybe<WorkCentersAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

/** The actual work order which is created based on the Bom requirement */
export type WorkOrder = {
  __typename?: 'WorkOrder';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** endDate description */
  endDate?: Maybe<Scalars['DateTime']['output']>;
  /** expectedDuration description */
  expectedDuration: Scalars['Int']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /** isBlocked description */
  isBlocked?: Maybe<Scalars['Boolean']['output']>;
  /** isDeleted description */
  isDeleted?: Maybe<Scalars['Boolean']['output']>;
  /** Link to the ManufacturingOrder */
  mo?: Maybe<ManufacturingOrder>;
  /** Unique identifier of the associated ManufacturingOrder */
  moId?: Maybe<Scalars['ID']['output']>;
  /** Link to the Operation */
  operation?: Maybe<Operation>;
  /** operationId description */
  operationId: Scalars['ID']['output'];
  /** sequence order description */
  order?: Maybe<Scalars['Int']['output']>;
  /** realDuration description */
  realDuration?: Maybe<Scalars['Int']['output']>;
  /** startDate description */
  startDate?: Maybe<Scalars['DateTime']['output']>;
  /** status description */
  status?: Maybe<WorkOrderStatus>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** The actual work order which is created based on the Bom requirement(Connection) */
export type WorkOrderConnection = {
  __typename?: 'WorkOrderConnection';
  edges: Array<WorkOrderEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** The actual work order which is created based on the Bom requirement(CreateInput) */
export type WorkOrderCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** endDate description */
  endDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** expectedDuration description */
  expectedDuration: Scalars['Int']['input'];
  /** ID of the The actual work order which is created based on the Bom requirement */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** isBlocked description */
  isBlocked?: InputMaybe<Scalars['Boolean']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated ManufacturingOrder */
  moId?: InputMaybe<Scalars['ID']['input']>;
  /** operationId description */
  operationId: Scalars['ID']['input'];
  /** sequence order description */
  order?: InputMaybe<Scalars['Int']['input']>;
  /** realDuration description */
  realDuration?: InputMaybe<Scalars['Int']['input']>;
  /** startDate description */
  startDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** status description */
  status?: InputMaybe<WorkOrderStatus>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type WorkOrderDependenciesCompositeKey = {
  /** Depends On WorkOrderId description */
  dependsOnWorkOrderId: Scalars['ID']['input'];
  /** workOrderId description */
  workOrderId: Scalars['ID']['input'];
};

/** To know the dependency of workOrder */
export type WorkOrderDependency = {
  __typename?: 'WorkOrderDependency';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Depends On WorkOrderId description */
  dependsOnWorkOrder?: Maybe<WorkOrder>;
  /** Depends On WorkOrderId description */
  dependsOnWorkOrderId: Scalars['ID']['output'];
  /** Document id */
  id: Scalars['ID']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Link to the WorkOrder */
  workOrder?: Maybe<WorkOrder>;
  /** workOrderId description */
  workOrderId: Scalars['ID']['output'];
};

/** To know the dependency of workOrder(Connection) */
export type WorkOrderDependencyConnection = {
  __typename?: 'WorkOrderDependencyConnection';
  edges: Array<WorkOrderDependencyEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** To know the dependency of workOrder(CreateInput) */
export type WorkOrderDependencyCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Depends On WorkOrderId description */
  dependsOnWorkOrderId: Scalars['ID']['input'];
  /** ID of the To know the dependency of workOrder */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** workOrderId description */
  workOrderId: Scalars['ID']['input'];
};

/** workOrderDependency(Edge) */
export type WorkOrderDependencyEdge = {
  __typename?: 'WorkOrderDependencyEdge';
  cursor: Scalars['String']['output'];
  node: WorkOrderDependency;
};

export enum WorkOrderDependencyOrderFieldEnum {
  CreatedAt = 'createdAt',
  UpdatedAt = 'updatedAt'
}

export type WorkOrderDependencyOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: WorkOrderDependencyOrderFieldEnum;
};

/** To know the dependency of workOrder(Input) */
export type WorkOrderDependencyQueryInput = {
  and?: InputMaybe<Array<WorkOrderDependencyQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  dependsOnWorkOrderId?: InputMaybe<UuidFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<WorkOrderDependencyQueryInput>>;
  or?: InputMaybe<Array<WorkOrderDependencyQueryInput>>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  workOrderId?: InputMaybe<UuidFilter>;
};

/** To know the dependency of workOrder(UpdateInput) */
export type WorkOrderDependencyUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Depends On WorkOrderId description */
  dependsOnWorkOrderId?: InputMaybe<Scalars['ID']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** workOrderId description */
  workOrderId?: InputMaybe<Scalars['ID']['input']>;
};

/** workOrder(Edge) */
export type WorkOrderEdge = {
  __typename?: 'WorkOrderEdge';
  cursor: Scalars['String']['output'];
  node: WorkOrder;
};

/** Represents a line item in a work order */
export type WorkOrderLineItem = {
  __typename?: 'WorkOrderLineItem';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** isDeleted description */
  isDeleted?: Maybe<Scalars['Boolean']['output']>;
  /** Link to the MO */
  mo?: Maybe<ManufacturingOrder>;
  /** Unique identifier of the associated MO */
  moId: Scalars['ID']['output'];
  /** Link to the MOLineItem */
  moLineItem?: Maybe<MoLineItem>;
  /** Unique identifier of the associated MOLineItem */
  moLineItemId: Scalars['ID']['output'];
  /** Quantity */
  quantity?: Maybe<Scalars['Int']['output']>;
  /** Link to the Item */
  returnAsNewSkuItem?: Maybe<Item>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: Maybe<Scalars['ID']['output']>;
  /** Scrap action for item */
  scrapAction?: Maybe<WorkOrderLineItemScrapAction>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Link to the WorkOrder */
  workOrder?: Maybe<WorkOrder>;
  /** Unique identifier of the associated WorkOrder */
  workOrderId: Scalars['ID']['output'];
};

/** Represents a line item in a work order(Connection) */
export type WorkOrderLineItemConnection = {
  __typename?: 'WorkOrderLineItemConnection';
  edges: Array<WorkOrderLineItemEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Represents a line item in a work order(CreateInput) */
export type WorkOrderLineItemCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Represents a line item in a work order */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated MO */
  moId: Scalars['ID']['input'];
  /** Unique identifier of the associated MOLineItem */
  moLineItemId: Scalars['ID']['input'];
  /** Quantity */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<WorkOrderLineItemScrapAction>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Unique identifier of the associated WorkOrder */
  workOrderId: Scalars['ID']['input'];
};

/** workOrderLineItem(Edge) */
export type WorkOrderLineItemEdge = {
  __typename?: 'WorkOrderLineItemEdge';
  cursor: Scalars['String']['output'];
  node: WorkOrderLineItem;
};

export enum WorkOrderLineItemOrderFieldEnum {
  CreatedAt = 'createdAt',
  IsDeleted = 'isDeleted',
  Quantity = 'quantity',
  ScrapAction = 'scrapAction',
  UpdatedAt = 'updatedAt'
}

export type WorkOrderLineItemOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: WorkOrderLineItemOrderFieldEnum;
};

/** Represents a line item in a work order(Input) */
export type WorkOrderLineItemQueryInput = {
  and?: InputMaybe<Array<WorkOrderLineItemQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  isDeleted?: InputMaybe<BoolFilter>;
  moId?: InputMaybe<UuidFilter>;
  moLineItemId?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<WorkOrderLineItemQueryInput>>;
  or?: InputMaybe<Array<WorkOrderLineItemQueryInput>>;
  quantity?: InputMaybe<IntegerFilter>;
  returnAsNewSkuItemId?: InputMaybe<UuidFilter>;
  scrapAction?: InputMaybe<WorkOrderLineItemScrapActionEnumFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  workOrderId?: InputMaybe<UuidFilter>;
};

export enum WorkOrderLineItemScrapAction {
  /** Return */
  Return = 'Return',
  /** Return as new SKU */
  ReturnAsNewSku = 'Return_as_new_SKU',
  /** Waste */
  Waste = 'Waste'
}

export type WorkOrderLineItemScrapActionEnumFilter = {
  eq?: InputMaybe<WorkOrderLineItemScrapAction>;
  in?: InputMaybe<Array<InputMaybe<WorkOrderLineItemScrapAction>>>;
  ne?: InputMaybe<WorkOrderLineItemScrapAction>;
  nin?: InputMaybe<Array<InputMaybe<WorkOrderLineItemScrapAction>>>;
};

/** Represents a line item in a work order(UpdateInput) */
export type WorkOrderLineItemUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated MO */
  moId?: InputMaybe<Scalars['ID']['input']>;
  /** Unique identifier of the associated MOLineItem */
  moLineItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Quantity */
  quantity?: InputMaybe<Scalars['Int']['input']>;
  /** Unique identifier of the associated item */
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  /** Scrap action for item */
  scrapAction?: InputMaybe<WorkOrderLineItemScrapAction>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Unique identifier of the associated WorkOrder */
  workOrderId?: InputMaybe<Scalars['ID']['input']>;
};

export enum WorkOrderOrderFieldEnum {
  CreatedAt = 'createdAt',
  EndDate = 'endDate',
  ExpectedDuration = 'expectedDuration',
  IsBlocked = 'isBlocked',
  IsDeleted = 'isDeleted',
  Order = 'order',
  RealDuration = 'realDuration',
  StartDate = 'startDate',
  Status = 'status',
  UpdatedAt = 'updatedAt'
}

export type WorkOrderOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: WorkOrderOrderFieldEnum;
};

/** The actual work order which is created based on the Bom requirement(Input) */
export type WorkOrderQueryInput = {
  and?: InputMaybe<Array<WorkOrderQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  endDate?: InputMaybe<DatetimeFilter>;
  expectedDuration?: InputMaybe<IntegerFilter>;
  id?: InputMaybe<UuidFilter>;
  isBlocked?: InputMaybe<BoolFilter>;
  isDeleted?: InputMaybe<BoolFilter>;
  moId?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<WorkOrderQueryInput>>;
  operationId?: InputMaybe<UuidFilter>;
  or?: InputMaybe<Array<WorkOrderQueryInput>>;
  order?: InputMaybe<IntegerFilter>;
  realDuration?: InputMaybe<IntegerFilter>;
  startDate?: InputMaybe<DatetimeFilter>;
  status?: InputMaybe<WorkOrderStatusEnumFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

export enum WorkOrderStatus {
  /** Canceled */
  Canceled = 'Canceled',
  /** Draft */
  Draft = 'Draft',
  /** Finished */
  Finished = 'Finished',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Ready */
  Ready = 'Ready',
  /** Waiting for another Work Order */
  WaitingForAnotherWo = 'Waiting_for_another_WO',
  /** Waiting for components */
  WaitingForComponents = 'Waiting_for_components'
}

export type WorkOrderStatusEnumFilter = {
  eq?: InputMaybe<WorkOrderStatus>;
  in?: InputMaybe<Array<InputMaybe<WorkOrderStatus>>>;
  ne?: InputMaybe<WorkOrderStatus>;
  nin?: InputMaybe<Array<InputMaybe<WorkOrderStatus>>>;
};

/** Status tracking of work order */
export type WorkOrderTransition = {
  __typename?: 'WorkOrderTransition';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** from status description */
  fromStatus?: Maybe<WorkOrderTransitionFromStatus>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Minutes in particular status */
  timeInStatus: Scalars['Int']['output'];
  /** to status description */
  toStatus?: Maybe<WorkOrderTransitionToStatus>;
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
  /** Link to the WorkOrder */
  workOrder?: Maybe<WorkOrder>;
  /** ID of the WorkOrder */
  workOrderId: Scalars['ID']['output'];
};

/** Status tracking of work order(Connection) */
export type WorkOrderTransitionConnection = {
  __typename?: 'WorkOrderTransitionConnection';
  edges: Array<WorkOrderTransitionEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Status tracking of work order(CreateInput) */
export type WorkOrderTransitionCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** from status description */
  fromStatus?: InputMaybe<WorkOrderTransitionFromStatus>;
  /** ID of the Status tracking of work order */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Minutes in particular status */
  timeInStatus: Scalars['Int']['input'];
  /** to status description */
  toStatus?: InputMaybe<WorkOrderTransitionToStatus>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the WorkOrder */
  workOrderId: Scalars['ID']['input'];
};

/** workOrderTransition(Edge) */
export type WorkOrderTransitionEdge = {
  __typename?: 'WorkOrderTransitionEdge';
  cursor: Scalars['String']['output'];
  node: WorkOrderTransition;
};

export enum WorkOrderTransitionFromStatus {
  /** Canceled */
  Canceled = 'Canceled',
  /** Draft */
  Draft = 'Draft',
  /** Finished */
  Finished = 'Finished',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Ready */
  Ready = 'Ready',
  /** Waiting for another Work Order */
  WaitingForAnotherWo = 'Waiting_for_another_WO',
  /** Waiting for components */
  WaitingForComponents = 'Waiting_for_components'
}

export type WorkOrderTransitionFromStatusEnumFilter = {
  eq?: InputMaybe<WorkOrderTransitionFromStatus>;
  in?: InputMaybe<Array<InputMaybe<WorkOrderTransitionFromStatus>>>;
  ne?: InputMaybe<WorkOrderTransitionFromStatus>;
  nin?: InputMaybe<Array<InputMaybe<WorkOrderTransitionFromStatus>>>;
};

export enum WorkOrderTransitionOrderFieldEnum {
  CreatedAt = 'createdAt',
  FromStatus = 'fromStatus',
  TimeInStatus = 'timeInStatus',
  ToStatus = 'toStatus',
  UpdatedAt = 'updatedAt'
}

export type WorkOrderTransitionOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: WorkOrderTransitionOrderFieldEnum;
};

/** Status tracking of work order(Input) */
export type WorkOrderTransitionQueryInput = {
  and?: InputMaybe<Array<WorkOrderTransitionQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  fromStatus?: InputMaybe<WorkOrderTransitionFromStatusEnumFilter>;
  id?: InputMaybe<UuidFilter>;
  not?: InputMaybe<Array<WorkOrderTransitionQueryInput>>;
  or?: InputMaybe<Array<WorkOrderTransitionQueryInput>>;
  timeInStatus?: InputMaybe<IntegerFilter>;
  toStatus?: InputMaybe<WorkOrderTransitionToStatusEnumFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
  workOrderId?: InputMaybe<UuidFilter>;
};

export enum WorkOrderTransitionToStatus {
  /** Canceled */
  Canceled = 'Canceled',
  /** Draft */
  Draft = 'Draft',
  /** Finished */
  Finished = 'Finished',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Ready */
  Ready = 'Ready',
  /** Waiting for another Work Order */
  WaitingForAnotherWo = 'Waiting_for_another_WO',
  /** Waiting for components */
  WaitingForComponents = 'Waiting_for_components'
}

export type WorkOrderTransitionToStatusEnumFilter = {
  eq?: InputMaybe<WorkOrderTransitionToStatus>;
  in?: InputMaybe<Array<InputMaybe<WorkOrderTransitionToStatus>>>;
  ne?: InputMaybe<WorkOrderTransitionToStatus>;
  nin?: InputMaybe<Array<InputMaybe<WorkOrderTransitionToStatus>>>;
};

/** Status tracking of work order(UpdateInput) */
export type WorkOrderTransitionUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** from status description */
  fromStatus?: InputMaybe<WorkOrderTransitionFromStatus>;
  /** Minutes in particular status */
  timeInStatus?: InputMaybe<Scalars['Int']['input']>;
  /** to status description */
  toStatus?: InputMaybe<WorkOrderTransitionToStatus>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the WorkOrder */
  workOrderId?: InputMaybe<Scalars['ID']['input']>;
};

/** The actual work order which is created based on the Bom requirement(UpdateInput) */
export type WorkOrderUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** endDate description */
  endDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** expectedDuration description */
  expectedDuration?: InputMaybe<Scalars['Int']['input']>;
  /** isBlocked description */
  isBlocked?: InputMaybe<Scalars['Boolean']['input']>;
  /** isDeleted description */
  isDeleted?: InputMaybe<Scalars['Boolean']['input']>;
  /** Unique identifier of the associated ManufacturingOrder */
  moId?: InputMaybe<Scalars['ID']['input']>;
  /** operationId description */
  operationId?: InputMaybe<Scalars['ID']['input']>;
  /** sequence order description */
  order?: InputMaybe<Scalars['Int']['input']>;
  /** realDuration description */
  realDuration?: InputMaybe<Scalars['Int']['input']>;
  /** startDate description */
  startDate?: InputMaybe<Scalars['DateTime']['input']>;
  /** status description */
  status?: InputMaybe<WorkOrderStatus>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type WorkOrdersAggregationAvgResult = {
  __typename?: 'WorkOrdersAggregationAvgResult';
  /** expectedDuration is aggregation field */
  expectedDuration?: Maybe<Scalars['Float']['output']>;
  /** order is aggregation field */
  order?: Maybe<Scalars['Float']['output']>;
  /** realDuration is aggregation field */
  realDuration?: Maybe<Scalars['Float']['output']>;
};

export type WorkOrdersAggregationCountResult = {
  __typename?: 'WorkOrdersAggregationCountResult';
  /** expectedDuration is aggregation field */
  expectedDuration?: Maybe<Scalars['Int']['output']>;
  /** moId is aggregation field */
  moId?: Maybe<Scalars['Int']['output']>;
  /** operationId is aggregation field */
  operationId?: Maybe<Scalars['Int']['output']>;
  /** order is aggregation field */
  order?: Maybe<Scalars['Int']['output']>;
  /** realDuration is aggregation field */
  realDuration?: Maybe<Scalars['Int']['output']>;
  /** status is aggregation field */
  status?: Maybe<Scalars['Int']['output']>;
  toDay?: Maybe<WorkOrdersAggregationCountToDayFunc>;
  toHour?: Maybe<WorkOrdersAggregationCountToHourFunc>;
  toMinute?: Maybe<WorkOrdersAggregationCountToMinuteFunc>;
  toMonth?: Maybe<WorkOrdersAggregationCountToMonthFunc>;
  toYear?: Maybe<WorkOrdersAggregationCountToYearFunc>;
};

export type WorkOrdersAggregationCountToDayFunc = {
  __typename?: 'WorkOrdersAggregationCountToDayFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkOrdersAggregationCountToHourFunc = {
  __typename?: 'WorkOrdersAggregationCountToHourFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkOrdersAggregationCountToMinuteFunc = {
  __typename?: 'WorkOrdersAggregationCountToMinuteFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkOrdersAggregationCountToMonthFunc = {
  __typename?: 'WorkOrdersAggregationCountToMonthFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkOrdersAggregationCountToYearFunc = {
  __typename?: 'WorkOrdersAggregationCountToYearFunc';
  /** createdAt is aggregation field */
  createdAt?: Maybe<Scalars['Int']['output']>;
  /** endDate is aggregation field */
  endDate?: Maybe<Scalars['Int']['output']>;
  /** startDate is aggregation field */
  startDate?: Maybe<Scalars['Int']['output']>;
  /** updatedAt is aggregation field */
  updatedAt?: Maybe<Scalars['Int']['output']>;
};

export type WorkOrdersAggregationGroupByResult = {
  __typename?: 'WorkOrdersAggregationGroupByResult';
  /** expectedDuration description */
  expectedDuration?: Maybe<Scalars['Int']['output']>;
  /** Unique identifier of the associated ManufacturingOrder */
  moId?: Maybe<Scalars['ID']['output']>;
  /** operationId description */
  operationId?: Maybe<Scalars['ID']['output']>;
  /** sequence order description */
  order?: Maybe<Scalars['Int']['output']>;
  /** realDuration description */
  realDuration?: Maybe<Scalars['Int']['output']>;
  /** status description */
  status?: Maybe<WorkOrdersStatus>;
  toDay?: Maybe<WorkOrdersAggregationGroupByToDayFunc>;
  toHour?: Maybe<WorkOrdersAggregationGroupByToHourFunc>;
  toMinute?: Maybe<WorkOrdersAggregationGroupByToMinuteFunc>;
  toMonth?: Maybe<WorkOrdersAggregationGroupByToMonthFunc>;
  toYear?: Maybe<WorkOrdersAggregationGroupByToYearFunc>;
};

export type WorkOrdersAggregationGroupByToDayFunc = {
  __typename?: 'WorkOrdersAggregationGroupByToDayFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** endDate description */
  endDate?: Maybe<Scalars['String']['output']>;
  /** startDate description */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkOrdersAggregationGroupByToHourFunc = {
  __typename?: 'WorkOrdersAggregationGroupByToHourFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** endDate description */
  endDate?: Maybe<Scalars['String']['output']>;
  /** startDate description */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkOrdersAggregationGroupByToMinuteFunc = {
  __typename?: 'WorkOrdersAggregationGroupByToMinuteFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** endDate description */
  endDate?: Maybe<Scalars['String']['output']>;
  /** startDate description */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkOrdersAggregationGroupByToMonthFunc = {
  __typename?: 'WorkOrdersAggregationGroupByToMonthFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** endDate description */
  endDate?: Maybe<Scalars['String']['output']>;
  /** startDate description */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkOrdersAggregationGroupByToYearFunc = {
  __typename?: 'WorkOrdersAggregationGroupByToYearFunc';
  /** createdAt */
  createdAt?: Maybe<Scalars['String']['output']>;
  /** endDate description */
  endDate?: Maybe<Scalars['String']['output']>;
  /** startDate description */
  startDate?: Maybe<Scalars['String']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['String']['output']>;
};

export type WorkOrdersAggregationQuantityResult = {
  __typename?: 'WorkOrdersAggregationQuantityResult';
  /** expectedDuration is aggregation field */
  expectedDuration?: Maybe<Scalars['Int']['output']>;
  /** order is aggregation field */
  order?: Maybe<Scalars['Int']['output']>;
  /** realDuration is aggregation field */
  realDuration?: Maybe<Scalars['Int']['output']>;
};

export type WorkOrdersAggregationResult = {
  __typename?: 'WorkOrdersAggregationResult';
  avg?: Maybe<WorkOrdersAggregationAvgResult>;
  count?: Maybe<WorkOrdersAggregationCountResult>;
  groupBy: WorkOrdersAggregationGroupByResult;
  max?: Maybe<WorkOrdersAggregationQuantityResult>;
  min?: Maybe<WorkOrdersAggregationQuantityResult>;
  sum?: Maybe<WorkOrdersAggregationQuantityResult>;
  totalSize?: Maybe<Scalars['Int']['output']>;
};

export enum WorkOrdersStatus {
  Canceled = 'Canceled',
  Draft = 'Draft',
  Finished = 'Finished',
  InProgress = 'In_Progress',
  Ready = 'Ready',
  WaitingForAnotherWo = 'Waiting_for_another_WO',
  WaitingForComponents = 'Waiting_for_components'
}

/** Used to define the hours during which a work center will be available */
export type WorkingHour = {
  __typename?: 'WorkingHour';
  /**
   * Create time
   * @deprecated No longer supported
   */
  created?: Maybe<Scalars['DateTime']['output']>;
  /** createdAt */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * created by
   * @deprecated No longer supported
   */
  createdByID?: Maybe<Scalars['ID']['output']>;
  /** Document id */
  id: Scalars['ID']['output'];
  /** Is active? */
  isActive?: Maybe<Scalars['Boolean']['output']>;
  /** Working hour name */
  name: Scalars['String']['output'];
  /** Standard hours per week */
  standardHoursPerWeek: Scalars['Int']['output'];
  /** Time zone */
  timeZone: Scalars['String']['output'];
  /**
   * Update time
   * @deprecated No longer supported
   */
  updated?: Maybe<Scalars['DateTime']['output']>;
  /** updatedAt */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
  /**
   * updated by
   * @deprecated No longer supported
   */
  updatedByID?: Maybe<Scalars['ID']['output']>;
};

/** Used to define the hours during which a work center will be available(Connection) */
export type WorkingHourConnection = {
  __typename?: 'WorkingHourConnection';
  edges: Array<WorkingHourEdge>;
  pageInfo: PageInfo;
  total?: Maybe<Scalars['Int']['output']>;
};

/** Used to define the hours during which a work center will be available(CreateInput) */
export type WorkingHourCreateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** ID of the Used to define the hours during which a work center will be available */
  id?: InputMaybe<Scalars['ID']['input']>;
  /** Is active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Working hour name */
  name: Scalars['String']['input'];
  /** Standard hours per week */
  standardHoursPerWeek: Scalars['Int']['input'];
  /** Time zone */
  timeZone: Scalars['String']['input'];
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

/** workingHour(Edge) */
export type WorkingHourEdge = {
  __typename?: 'WorkingHourEdge';
  cursor: Scalars['String']['output'];
  node: WorkingHour;
};

export enum WorkingHourOrderFieldEnum {
  CreatedAt = 'createdAt',
  IsActive = 'isActive',
  Name = 'name',
  StandardHoursPerWeek = 'standardHoursPerWeek',
  TimeZone = 'timeZone',
  UpdatedAt = 'updatedAt'
}

export type WorkingHourOrderInput = {
  direction?: InputMaybe<OrderDirectionEnum>;
  field: WorkingHourOrderFieldEnum;
};

/** Used to define the hours during which a work center will be available(Input) */
export type WorkingHourQueryInput = {
  and?: InputMaybe<Array<WorkingHourQueryInput>>;
  createdAt?: InputMaybe<DatetimeFilter>;
  id?: InputMaybe<UuidFilter>;
  isActive?: InputMaybe<BoolFilter>;
  name?: InputMaybe<StringFilter>;
  not?: InputMaybe<Array<WorkingHourQueryInput>>;
  or?: InputMaybe<Array<WorkingHourQueryInput>>;
  standardHoursPerWeek?: InputMaybe<IntegerFilter>;
  timeZone?: InputMaybe<StringFilter>;
  updatedAt?: InputMaybe<DatetimeFilter>;
};

/** Used to define the hours during which a work center will be available(UpdateInput) */
export type WorkingHourUpdateInput = {
  /** createdAt */
  createdAt?: InputMaybe<Scalars['DateTime']['input']>;
  /** Is active? */
  isActive?: InputMaybe<Scalars['Boolean']['input']>;
  /** Working hour name */
  name?: InputMaybe<Scalars['String']['input']>;
  /** Standard hours per week */
  standardHoursPerWeek?: InputMaybe<Scalars['Int']['input']>;
  /** Time zone */
  timeZone?: InputMaybe<Scalars['String']['input']>;
  /** updatedAt */
  updatedAt?: InputMaybe<Scalars['DateTime']['input']>;
};

export type AddBatchMoInput = {
  batchSize: Scalars['Int']['input'];
  bomId: Scalars['ID']['input'];
  name: Scalars['String']['input'];
  quantity: Scalars['Int']['input'];
};

export type AddBatchMoOutput = {
  __typename?: 'addBatchMoOutput';
  batchManufacturingOrderId: Scalars['ID']['output'];
};

export type AllocateCostInput = {
  costPoolID: Scalars['ID']['input'];
};

export type AllocateInventoryItemInput = {
  itemId: Scalars['ID']['input'];
  quantity: Scalars['Int']['input'];
};

export type AllocateInventoryItemOutput = {
  __typename?: 'allocateInventoryItemOutput';
  itemId?: Maybe<Scalars['ID']['output']>;
  success: Scalars['Boolean']['output'];
};

export type CalculateStockEventAndUpdateStockSummaryInput = {
  stockEventID: Scalars['ID']['input'];
};

export type CalculatedWorkOrderListResult = {
  __typename?: 'calculatedWorkOrderListResult';
  totalCost?: Maybe<Scalars['Float']['output']>;
  totalDuration?: Maybe<Scalars['Float']['output']>;
  totalExpectedCost?: Maybe<Scalars['Float']['output']>;
  totalExpectedDuration?: Maybe<Scalars['Float']['output']>;
  workOrderId?: Maybe<Scalars['ID']['output']>;
};

export type CancelManufacturingOrderInput = {
  moId: Scalars['ID']['input'];
};

export type CancelManufacturingOrderOutput = {
  __typename?: 'cancelManufacturingOrderOutput';
  manufacturingOrderId: Scalars['ID']['output'];
  success: Scalars['Boolean']['output'];
};

export type CancelWorkOrderInput = {
  workOrderId: Scalars['ID']['input'];
};

export type CancelWorkOrderOutput = {
  __typename?: 'cancelWorkOrderOutput';
  success: Scalars['Boolean']['output'];
};

export type ComputeBatchMoCostInput = {
  moBatchId: Scalars['ID']['input'];
};

export type ComputeBatchMoCostOutput = {
  __typename?: 'computeBatchMoCostOutput';
  expectedTotalCost?: Maybe<Scalars['Float']['output']>;
  expectedUnitCost?: Maybe<Scalars['Float']['output']>;
  success: Scalars['Boolean']['output'];
  totalCost?: Maybe<Scalars['Float']['output']>;
  unitCost?: Maybe<Scalars['Float']['output']>;
};

export type ConfigureBomItemsWithOperationInput = {
  bomId: Scalars['ID']['input'];
};

export type ConfigureBomItemsWithOperationOutput = {
  __typename?: 'configureBomItemsWithOperationOutput';
  success: Scalars['Boolean']['output'];
};

export type ConsumeAllocatedInventoryItemInput = {
  itemId: Scalars['ID']['input'];
  quantity: Scalars['Int']['input'];
};

export type ConsumeAllocatedInventoryItemOutput = {
  __typename?: 'consumeAllocatedInventoryItemOutput';
  itemId?: Maybe<Scalars['ID']['output']>;
  success: Scalars['Boolean']['output'];
};

export type ConsumeInventoryItemInput = {
  consumeQuantity: Scalars['Int']['input'];
  itemId: Scalars['ID']['input'];
};

export type ConsumeInventoryItemOutput = {
  __typename?: 'consumeInventoryItemOutput';
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type CreateInvoiceFromShipmentInput = {
  shipmentID: Scalars['ID']['input'];
};

export type CreateManufacturingInput = {
  bomId: Scalars['ID']['input'];
  moBatchId?: InputMaybe<Scalars['ID']['input']>;
  name: Scalars['String']['input'];
  parentMoId?: InputMaybe<Scalars['ID']['input']>;
  parentMoItem?: InputMaybe<Scalars['ID']['input']>;
  quantity: Scalars['Int']['input'];
};

export type CreateManufacturingOrderOutput = {
  __typename?: 'createManufacturingOrderOutput';
  manufacturingOrderId: Scalars['ID']['output'];
};

export type CreateNestedManufacturingOrderInput = {
  manufacturingOrderId: Scalars['ID']['input'];
};

export type CreateNestedManufacturingOrderOutput = {
  __typename?: 'createNestedManufacturingOrderOutput';
  success: Scalars['Boolean']['output'];
};

export type CreateReceiptFromPurchaseOrderInput = {
  purchaseOrderID: Scalars['ID']['input'];
};

export type CreateShipmentFromSalesOrderInput = {
  markAsShipped?: InputMaybe<Scalars['Boolean']['input']>;
  salesOrderID: Scalars['ID']['input'];
};

export type CreateShipmentFromSalesOrderOutput = {
  __typename?: 'createShipmentFromSalesOrderOutput';
  shipmentId?: Maybe<Scalars['ID']['output']>;
};

export type CreateStockEventsFromReceiptLineItemsInput = {
  receiptLineItemIDs: Array<InputMaybe<Scalars['ID']['input']>>;
};

export type CreateStockEventsFromReceiptLineItemsOutput = {
  __typename?: 'createStockEventsFromReceiptLineItemsOutput';
  stockEventIDs?: Maybe<Array<Maybe<Scalars['ID']['output']>>>;
};

export type CreateStockEventsFromShipmentLineItemsInput = {
  action: StockEventAction;
  shipmentItemIDs: Array<InputMaybe<Scalars['ID']['input']>>;
};

export enum InventoryOperationType {
  Consume = 'CONSUME',
  Ignore = 'IGNORE'
}

export type ListInput = {
  inputQuantity?: InputMaybe<Scalars['Float']['input']>;
  itemId?: InputMaybe<Scalars['ID']['input']>;
  uomId?: InputMaybe<Scalars['ID']['input']>;
};

export type ListOutputResult = {
  __typename?: 'listOutputResult';
  outputQuantity: Scalars['Float']['output'];
  result?: Maybe<Array<Maybe<ListOutputResult>>>;
};

export type ListPickingItemResult = {
  __typename?: 'listPickingItemResult';
  id?: Maybe<Scalars['ID']['output']>;
  itemDescription?: Maybe<Scalars['String']['output']>;
  itemId?: Maybe<Scalars['ID']['output']>;
  itemInventoryType?: Maybe<Scalars['String']['output']>;
  itemIsActive?: Maybe<Scalars['Boolean']['output']>;
  itemIsFinalProduct?: Maybe<Scalars['Boolean']['output']>;
  itemName?: Maybe<Scalars['String']['output']>;
  outputQuantity?: Maybe<Scalars['Float']['output']>;
  uomId?: Maybe<Scalars['ID']['output']>;
  uomName?: Maybe<Scalars['String']['output']>;
};

export type ListPickingOperationResult = {
  __typename?: 'listPickingOperationResult';
  calculatedDuration?: Maybe<Scalars['Float']['output']>;
  description?: Maybe<Scalars['String']['output']>;
  documentUrl?: Maybe<Scalars['String']['output']>;
  duration?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['ID']['output']>;
  isActive?: Maybe<Scalars['Boolean']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  order?: Maybe<Scalars['Int']['output']>;
  workCenter?: Maybe<Scalars['String']['output']>;
  workCenterId?: Maybe<Scalars['ID']['output']>;
};

export type ListPickingResult = {
  __typename?: 'listPickingResult';
  outputQuantity: Scalars['Float']['output'];
  result?: Maybe<Array<Maybe<ListPickingItemResult>>>;
};

export enum ManufacturingOrderStatusEnum {
  /** Canceled */
  Canceled = 'Canceled',
  /** Completed */
  Completed = 'Completed',
  /** Draft */
  Draft = 'Draft',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Planned */
  Planned = 'Planned'
}

export type ManufacturingOrderStatusTransitionRecordInput = {
  fromStatus: ManufacturingOrderStatusEnum;
  manufacturingOrderId: Scalars['ID']['input'];
  toStatus: ManufacturingOrderStatusEnum;
};

export type ManufacturingOrderStatusTransitionRecordOutput = {
  __typename?: 'manufacturingOrderStatusTransitionRecordOutput';
  success: Scalars['Boolean']['output'];
};

export type MoBatchPreviewOutput = {
  __typename?: 'moBatchPreviewOutput';
  moBatches?: Maybe<Array<Maybe<MoBatchesList>>>;
};

export type MoBatchesList = {
  __typename?: 'moBatchesList';
  bomId?: Maybe<Scalars['ID']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  quantity?: Maybe<Scalars['Int']['output']>;
};

export type MoveWoToFinishInput = {
  workOrderId: Scalars['ID']['input'];
};

export type MoveWoToFinishOutput = {
  __typename?: 'moveWoToFinishOutput';
  success: Scalars['Boolean']['output'];
};

export type MoveWoToInProgressInput = {
  workOrderId: Scalars['ID']['input'];
};

export type MoveWoToInProgressOutput = {
  __typename?: 'moveWoToInProgressOutput';
  success: Scalars['Boolean']['output'];
};

export type MoveWoToReadyInput = {
  workOrderId: Scalars['ID']['input'];
};

export type MoveWoToReadyOutput = {
  __typename?: 'moveWoToReadyOutput';
  success: Scalars['Boolean']['output'];
};

export type MoveWoToWaitingForComponentsInput = {
  workOrderId: Scalars['ID']['input'];
};

export type MoveWoToWaitingForComponentsOutput = {
  __typename?: 'moveWoToWaitingForComponentsOutput';
  success: Scalars['Boolean']['output'];
};

export type PlanBatchManufacturingOrderInput = {
  moBatchId: Scalars['ID']['input'];
  scheduleDateTime: Scalars['String']['input'];
};

export type PlanBatchManufacturingOrderOutput = {
  __typename?: 'planBatchManufacturingOrderOutput';
  endDateTime?: Maybe<Scalars['DateTime']['output']>;
  startDateTime?: Maybe<Scalars['DateTime']['output']>;
  success: Scalars['Boolean']['output'];
};

export type PreviewManufacturingInput = {
  bomId: Scalars['ID']['input'];
  outputQuantity: Scalars['Float']['input'];
};

export type PreviewManufacturingOutput = {
  __typename?: 'previewManufacturingOutput';
  outputQuantity: Scalars['Float']['output'];
  requiredItems?: Maybe<Array<Maybe<ListPickingItemResult>>>;
  workOperations?: Maybe<Array<Maybe<ListPickingOperationResult>>>;
};

export type RemoveAllocatedInventoryItemInput = {
  itemId: Scalars['ID']['input'];
  quantity: Scalars['Int']['input'];
};

export type RemoveAllocatedInventoryItemOutput = {
  __typename?: 'removeAllocatedInventoryItemOutput';
  itemId?: Maybe<Scalars['ID']['output']>;
  success: Scalars['Boolean']['output'];
};

export type RemoveBatchManufacturingOrderInput = {
  moBatchId: Scalars['ID']['input'];
};

export type RemoveBatchManufacturingOrderOutput = {
  __typename?: 'removeBatchManufacturingOrderOutput';
  success: Scalars['Boolean']['output'];
};

export type RemoveManufacturingOrderInput = {
  moId: Scalars['ID']['input'];
};

export type RemoveManufacturingOrderOutput = {
  __typename?: 'removeManufacturingOrderOutput';
  manufacturingOrderId: Scalars['ID']['output'];
  success: Scalars['Boolean']['output'];
};

export enum ScrapActionType {
  Return = 'Return',
  ReturnAsNewSku = 'Return_as_new_SKU',
  Waste = 'Waste'
}

export type ScrapConsumedInventoryItemInput = {
  itemId: Scalars['ID']['input'];
  quantity: Scalars['Int']['input'];
  returnAsNewSkuItemId?: InputMaybe<Scalars['ID']['input']>;
  scrapAction: ScrapActionType;
};

export type ScrapConsumedInventoryItemOutput = {
  __typename?: 'scrapConsumedInventoryItemOutput';
  success: Scalars['Boolean']['output'];
};

export type SimulateWorkOperationInput = {
  bomId: Scalars['ID']['input'];
  outputQuantity: Scalars['Float']['input'];
};

export type SimulateWorkOperationOutput = {
  __typename?: 'simulateWorkOperationOutput';
  outputQuantity: Scalars['Float']['output'];
  result?: Maybe<Array<Maybe<ListPickingOperationResult>>>;
};

export type UnPlanBatchManufacturingOrderOutput = {
  __typename?: 'unPlanBatchManufacturingOrderOutput';
  success: Scalars['Boolean']['output'];
};

export type UnmappedItemsList = {
  __typename?: 'unmappedItemsList';
  bomLineItemId?: Maybe<Scalars['ID']['output']>;
  remainingQuantity?: Maybe<Scalars['Int']['output']>;
};

export type UnplanBatchManufacturingOrderInput = {
  moBatchId: Scalars['ID']['input'];
};

export type UpdateManufacturingOrderBatchStatusInput = {
  moBatchId: Scalars['ID']['input'];
};

export type UpdateManufacturingOrderBatchStatusOutput = {
  __typename?: 'updateManufacturingOrderBatchStatusOutput';
  success: Scalars['Boolean']['output'];
};

export type UpdateManufacturingOrderStatusInput = {
  inventoryOperation?: InputMaybe<InventoryOperationType>;
  manufacturingOrderId: Scalars['ID']['input'];
};

export type UpdateManufacturingOrderStatusOutput = {
  __typename?: 'updateManufacturingOrderStatusOutput';
  success: Scalars['Boolean']['output'];
};

export type ValidateBomItemWithOperationsInput = {
  bomId: Scalars['ID']['input'];
};

export type ValidateBomItemWithOperationsOutput = {
  __typename?: 'validateBomItemWithOperationsOutput';
  isValid: Scalars['Boolean']['output'];
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
  unmappedItems?: Maybe<Array<Maybe<UnmappedItemsList>>>;
};

export enum WorkOrderStatusEnum {
  /** Canceled */
  Canceled = 'Canceled',
  /** Draft */
  Draft = 'Draft',
  /** Finished */
  Finished = 'Finished',
  /** In Progress */
  InProgress = 'In_Progress',
  /** Ready */
  Ready = 'Ready',
  /** Waiting for another Work Order */
  WaitingForAnotherWo = 'Waiting_for_another_WO',
  /** Waiting for components */
  WaitingForComponents = 'Waiting_for_components'
}

export type WorkOrderStatusTransitionRecordInput = {
  fromStatus: WorkOrderStatusEnum;
  toStatus: WorkOrderStatusEnum;
  workOrderId: Scalars['ID']['input'];
};

export type WorkOrderStatusTransitionRecordOutput = {
  __typename?: 'workOrderStatusTransitionRecordOutput';
  success: Scalars['Boolean']['output'];
};

export type ContactsQueryVariables = Exact<{ [key: string]: never; }>;


export type ContactsQuery = { __typename?: 'Query', contacts: { __typename?: 'ContactConnection', edges: Array<{ __typename?: 'ContactEdge', node: { __typename?: 'Contact', id: string, name: string, email: string, company?: string | null, phone?: string | null, address1?: string | null, address2?: string | null, city?: string | null, province?: string | null, provinceCode?: string | null, zip?: string | null, country?: string | null, countryCode?: string | null, creditLimit?: number | null, openBalance?: number | null, availableCredit?: number | null, quickBookCustomerId?: string | null, active?: boolean | null } }> } };

export type InvoicesQueryVariables = Exact<{ [key: string]: never; }>;


export type InvoicesQuery = { __typename?: 'Query', invoices: { __typename?: 'InvoiceConnection', edges: Array<{ __typename?: 'InvoiceEdge', node: { __typename?: 'Invoice', id: string, invoiceStatus?: InvoiceInvoiceStatus | null, invoiceNumber?: string | null, date?: any | null, shipmentID?: string | null, customer?: { __typename?: 'Contact', name: string } | null } }> } };

export type ProductsQueryVariables = Exact<{ [key: string]: never; }>;


export type ProductsQuery = { __typename?: 'Query', products: { __typename?: 'ProductConnection', edges: Array<{ __typename?: 'ProductEdge', node: { __typename?: 'Product', id: string, description?: string | null, title?: string | null, handle?: string | null, shopifyID?: string | null, active?: boolean | null } }> } };

export type ProductVariantsQueryVariables = Exact<{ [key: string]: never; }>;


export type ProductVariantsQuery = { __typename?: 'Query', productVariants: { __typename?: 'ProductVariantConnection', edges: Array<{ __typename?: 'ProductVariantEdge', node: { __typename?: 'ProductVariant', id: string, displayName?: string | null, availableForSale?: boolean | null, barcode?: string | null, sku?: string | null, productID?: string | null, price?: number | null, shopifyID?: string | null, inventoryType?: ProductVariantInventoryType | null, inventoryQuantity?: number | null, quickbookItemId?: string | null, quickbookSyncToken?: string | null, quickbookItemName?: string | null, active?: boolean | null, image?: { __typename?: 'ProductImage', url?: string | null } | null } }> } };

export type SalesOrdersQueryVariables = Exact<{ [key: string]: never; }>;


export type SalesOrdersQuery = { __typename?: 'Query', salesOrders: { __typename?: 'SalesOrderConnection', edges: Array<{ __typename?: 'SalesOrderEdge', node: { __typename?: 'SalesOrder', currency?: string | null, created?: any | null, shopifyID?: string | null, updated?: any | null, orderNumber?: number | null, customerEmail?: string | null, customerID?: string | null, createdAt?: any | null, shipStationOrderStatus?: SalesOrderShipStationOrderStatus | null, updatedAt?: any | null, shippedAt?: any | null, id: string, cancelledAt?: any | null, currentSubtotalPrice?: string | null, updatedByID?: string | null, customerName?: string | null, cancelReason?: string | null, active?: boolean | null, createdByID?: string | null, shopifyCreatedAt?: any | null } }> } };

export type ShipmenLineItemsQueryVariables = Exact<{
  shipmentID: Scalars['ID']['input'];
}>;


export type ShipmenLineItemsQuery = { __typename?: 'Query', shipmentLineItems: { __typename?: 'ShipmentLineItemConnection', edges: Array<{ __typename?: 'ShipmentLineItemEdge', node: { __typename?: 'ShipmentLineItem', shipmentID: string, id: string, variantID?: string | null, unitCost: number, unitPrice: number, quantity: number, taxable?: boolean | null, shipmentStatus?: ShipmentLineItemShipmentStatus | null, shippedAt?: any | null } }> } };

export type ShipmentsQueryVariables = Exact<{ [key: string]: never; }>;


export type ShipmentsQuery = { __typename?: 'Query', shipments: { __typename?: 'ShipmentConnection', total?: number | null, edges: Array<{ __typename?: 'ShipmentEdge', cursor: string, node: { __typename?: 'Shipment', shipmentNumber?: string | null, updated?: any | null, updatedAt?: any | null, created?: any | null, createdByID?: string | null, updatedByID?: string | null, date?: any | null, active?: boolean | null, customerID?: string | null, salesOrderID?: string | null, createdAt?: any | null, id: string, customer?: { __typename?: 'Contact', updatedByID?: string | null, zip?: string | null, quickBookCustomerId?: string | null, country?: string | null, countryCode?: string | null, address1?: string | null, updatedAt?: any | null, active?: boolean | null, name: string, company?: string | null, province?: string | null, availableCredit?: number | null, createdAt?: any | null, city?: string | null, createdByID?: string | null, address2?: string | null, email: string, provinceCode?: string | null, id: string, updated?: any | null, openBalance?: number | null, creditLimit?: number | null, phone?: string | null, created?: any | null } | null, salesOrder?: { __typename?: 'SalesOrder', currency?: string | null, created?: any | null, shopifyID?: string | null, updated?: any | null, orderNumber?: number | null, customerEmail?: string | null, customerID?: string | null, createdAt?: any | null, shipStationOrderStatus?: SalesOrderShipStationOrderStatus | null, updatedAt?: any | null, shippedAt?: any | null, id: string, cancelledAt?: any | null, currentSubtotalPrice?: string | null, updatedByID?: string | null, customerName?: string | null, cancelReason?: string | null, active?: boolean | null, createdByID?: string | null } | null } }> } };
