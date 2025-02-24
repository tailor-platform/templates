globalThis.main = async function (args) {
  const client = new tailordb.Client({
    namespace: "ims",
  });
  await client.connect();
  try {
    const millis = Date.now()
    const products = await client.queryObject("SELECT * FROM Product");
    const len = products.rows.length;
    if (len !== 0) {
      throw new Error(`The size of Product, expected:0 got:${len}`)
    }
    const fixtures = [
      `${millis} - Product 1`,
      `${millis} - Product 2`,
      `${millis} - Product 3`,
      `${millis} - Product 4`,
    ]
    const transaction = client.createTransaction("add_products");
    try {
      await transaction.begin();
      for (const i of fixtures) {
        const ret = await transaction.queryObject(`INSERT INTO Product (title) VALUES ('${i}')`);
      }
      await transaction.commit();
      const products = await client.queryObject(`SELECT * FROM Product WHERE title like '${millis}%'`);
      const len = products.rows.length;
      if (len !== 4) {
        throw new Error(`The size of Product, expected:4 got:${len}`)
      }
      return {
        success: len === 4
      };
    } catch (e) {
      throw new Error(`add_products failed with error:${e}\n${e.cause}`)
    }
  }
  finally {
    await client.end();
  }
}