import { context } from "@tailor-platform/api-test-library";

/**
 * Test createQuoteForRequestForQuote
 * Creates Quote from the request for quote
 * and checks if the quote is created
 */
test("1. Create a quote for RFQ", async () => {
  const res = await context.runPipeline("createQuoteForRequestForQuote", {
    input: {
      requestForQuoteID: context.env.RequestForQuote.requestForQuote1.id,
      supplierID: context.env.Supplier.supplier1.id,
      quoteDate: "2024-08-01",
      expiryDate: "2024-08-31",
      reference: "Q001",
      status: "draft",
    },
  });
  const quote = await context.fetch("Quote", res);
  const quoteFromDB = await context.fetch("Quote", quote.id);
  expect(quoteFromDB).toBeDefined();
  await context.delete("Quote", quote.id);
}, 30000);

test("2. Create purchase order for a quote.", async () => {
  const res = await context.runPipeline("createPurchaseOrderForQuote", {
    input: {
      quoteID: context.env.Quote.quote1.id,
      supplierID: context.env.Supplier.supplier1.id,
      purchaseOrderDate: "2024-08-01",
      reference: "PO001",
      status: "draft",
    },
  });
  const purchaseOrder = await context.fetch("PurchaseOrder", res);
  const purchaseOrderFromDB = await context.fetch("PurchaseOrder", purchaseOrder.id);
  expect(purchaseOrderFromDB).toBeDefined();
  await context.delete("PurchaseOrder", purchaseOrder.id);
});

test("3. Create invoice for a purchase order.", async () => {
  const res = await context.runPipeline("createInvoiceForPurchaseOrder", {
    input: {
      supplierID: context.env.Supplier.supplier1.id,
      purchaseOrderID: context.env.PurchaseOrder.purchaseOrder1.id,
      invoiceDate: "2024-08-01",
      reference: "I001",
      status: "draft",
      dueDate: "2024-08-31",
    },
  });
  const invoice = await context.fetch("Invoice", res);
  const invoiceFromDB = await context.fetch("Invoice", invoice.id);
  expect(invoiceFromDB).toBeDefined();
  await context.delete("Invoice", invoice.id);
});

test("4. Create ASN for invoice.", async () => {
  const res = await context.runPipeline(
    "createAdvanceShipmentNoticeForInvoice",
    {
      input: {
        supplierID: context.env.Supplier.supplier1.id,
        invoiceID: context.env.Invoice.invoice1.id,
        reference: "ASN001",
        status: "draft",
        asnDate: "2024-08-01",
      },
    }
  );
  const asn = await context.fetch("AdvanceShipmentNotice", res);
  const asnFromDB = await context.fetch("AdvanceShipmentNotice", asn.id);
  expect(asnFromDB).toBeDefined();
  await context.delete("AdvanceShipmentNotice", asn.id);
});

test("5. Create GRN for ASN.", async () => {
  const res = await context.runPipeline("createGoodsReceivedNoteForAsn", {
    input: {
      supplierID: context.env.Supplier.supplier1.id,
      advanceShipmentNoticeID:
        context.env.AdvanceShipmentNotice.advanceShipmentNotice1.id,
      invoiceID: context.env.Invoice.invoice1.id,
      reference: "GRN001",
      status: "draft",
      grnDate: "2024-08-01",
    },
  });
  const grn = await context.fetch("GoodsReceivedNote", res);
  const grnFromDB = await context.fetch("GoodsReceivedNote", grn.id);
  expect(grnFromDB).toBeDefined();
  await context.delete("GoodsReceivedNote", grn.id);
});

test("6. reconcile purchase order", async () => {
  const res = await context.runPipeline(
    "reconcilePurchaseOrder",
    {
      id: context.env.PurchaseOrder.purchaseOrder2.id,
    },
    {
      customOutput: `{
        purchaseOrderID,
        purchaseOrderLineItemID,
        productID,
        purchaseOrderQuantity,
        invoiceQuantity,
        price,
        quantityDifference,
        valueDifference
      }`,
    }
  );
  expect(res[0].quantityDifference).toBe(-2);
});

test("7. reconcile invoice.", async () => {
  const res = await context.runPipeline(
    "reconcileInvoice",
    {
      id: context.env.Invoice.invoice2.id,
    },
    {
      customOutput: `{
        invoiceID,
        invoiceLineItemID,
        productID,
        goodsReceivedQuantity,
        invoiceQuantity,
        price,
        quantityDifference,
        valueDifference
      }`,
    }
  );
  expect(res[0].quantityDifference).toBe(2);
});

test("8. reconcile ASN.", async () => {
  const res = await context.runPipeline(
    "reconcileAdvanceShipmentNotice",
    {
      id: context.env.AdvanceShipmentNotice.advanceShipmentNotice1.id,
    },
    {
      customOutput: `{
      advanceShipmentNoticeID,
      advanceShipmentNoticeLineItemID,
      productID,
      goodsReceivedQuantity,
      advanceShipmentNoticeQuantity,
      quantityDifference
    }`,
    }
  );
  expect(res[0].quantityDifference).toBe(0);
});
