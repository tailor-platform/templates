let workOrders = {{ dashboardWorkOrders.data.workOrders.collection || [] }};

function calculateDeviationPercentage(data) {
  return data.map(item => {
    const deviationPercentage = ((item.realDuration - item.expectedDuration) / item.expectedDuration) * 100;
    return {
      workCenter: item.workCenter,
      workCenterId: item.workCenterId,
      expectedDuration: item.expectedDuration,
      realDuration: item.realDuration,
      deviationPercentage: deviationPercentage.toFixed(2) // Rounded to 2 decimal places
    };
  });
}

function groupByWorkCenter(data) {
  return data.reduce((acc, item) => {
    const workCenterId = item.operation.workCenterId;
    const workCenterName = item.operation.workCenter.name;

    // Find if the workCenterId already exists in the accumulator
    let existingWorkCenter = acc.find(wc => wc.workCenterId === workCenterId);

    // If it doesn't exist, create a new entry
    if (!existingWorkCenter) {
      existingWorkCenter = {
        workCenter: workCenterName,
        workCenterId: workCenterId,
        expectedDuration: 0,
        realDuration: 0
      };
      acc.push(existingWorkCenter);
    }

    // Add the expectedDuration and realDuration
    existingWorkCenter.expectedDuration += item.expectedDuration;
    existingWorkCenter.realDuration += item.realDuration;

    return acc;
  }, []);
}

const result1 = groupByWorkCenter(workOrders);
const result = calculateDeviationPercentage(result1);


return { result };
