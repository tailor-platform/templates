const sumOutputQuantities = (data) => {
    const result = {};

    data.forEach(item => {
        const key = `${item.id}_${item.uomId}`;
        if (result[key]) {
            result[key].outputQuantity += item.outputQuantity;
        } else {
            result[key] = { ...item };
        }
    });

    return Object.values(result);
};


function flattenJson(data) {
    const flattenedData = [];

    function recurse(items) {
        items.flatMap(item => {
            if (typeof item === 'object' && item !== null) {
                const { result, ...rest } = item;
                flattenedData.push(rest);

                if (Array.isArray(result)) {
                    recurse(result);
                }
            }
        });
    }

    recurse(data);
    return flattenedData;
}


const maxLevelOfdepth = 5

const simulateQuery = async (bomId, quantity) => {
  try {
    return new Promise((resolve, reject) => {
      simulateLineItems2.trigger({
        additionalScope: {
          bomId,
          quantity,
        },
        onSuccess: (data) => {
          resolve(data);
        },
        onError: (error) => {
          reject(error);
        },
      });
    });
  } catch (error) {
    console.error("Error in simulateQuery:", error);
    return null;
  }
};

const getItemQuery = async (itemsId) => {
  try {
    return new Promise((resolve, reject) => {
      simulateRequirementTable2.trigger({
        additionalScope: {
          itemsId,
        },
        onSuccess: (data) => {
          resolve(data);
        },
        onError: (error) => {
          reject(error);
        },
      });
    });
  } catch (error) {
    console.error("Error in getItemQuery:", error);
    return null;
  }
};

const processItem = async (bomId, outputQuantity,lod=1) => {
  try {
    const simulateQueryResponse = await simulateQuery(bomId, outputQuantity);
    console.log("simulateQueryResponse", simulateQueryResponse);

    if (!simulateQueryResponse || !simulateQueryResponse.simulateInputRequirementByOutputQuantity) {
      throw new Error("Invalid simulateQueryResponse structure");
    }

    const resultData = simulateQueryResponse.simulateInputRequirementByOutputQuantity.result || [];
    if (resultData.length === 0) {
      return [];
    }

    const itemIds = resultData.map(obj => obj.itemId);
    if (itemIds.length === 0) {
      throw new Error("No itemIds found in resultData");
    }

    const getItemQueryResponse = await getItemQuery(itemIds);
    console.log("getItemQueryResponse", getItemQueryResponse);

    if (!getItemQueryResponse || !getItemQueryResponse.items) {
      throw new Error("Invalid getItemQueryResponse structure");
    }

    const items = getItemQueryResponse.items.collection || [];
    for (let i = 0; i < items.length; i++) {
      const simulateLine = resultData.find(line => line.itemId === items[i].id);
      if (simulateLine) {
        items[i].outputQuantity = simulateLine.outputQuantity;
      }
      // Recursively process items that have bomId and outputQuantity
      if (items[i].bomId && items[i].outputQuantity && lod<=maxLevelOfdepth) {
        items[i].result = await processItem(items[i].bomId, items[i].outputQuantity,lod++);
      } else {
        items[i].result = [];
      }
    }
    return items;
  } catch (error) {
    console.error("Error in processItem:", error);
    return [];
  }
};

(async () => {
  try {
    let simulateRequirementTableData = simulateRequirementTable.data;
    console.log("simulateRequirementTableData", simulateRequirementTableData);

    if (!Array.isArray(simulateRequirementTableData)) {
      throw new Error("Invalid simulateRequirementTableData structure");
    }

    for (const item of simulateRequirementTableData) {
      if (item.bomId && item.outputQuantity) {
        item.result = await processItem(item.bomId, item.outputQuantity);
      } else {
        item.result = [];
      }
    }

    console.log("simulateRequirementTableData", simulateRequirementTableData);
    nestedBom.setValue(simulateRequirementTableData);
    
    // Flatten the data
    const flattenedData = flattenJson(simulateRequirementTableData);
    console.log("flattenedData", flattenedData);
    const summedData = sumOutputQuantities(flattenedData);
    console.log("summedData",summedData);
    nestedBomSummary.setValue(summedData)
  } catch (error) {
    console.error("Error in main process:", error);
  }
})();
