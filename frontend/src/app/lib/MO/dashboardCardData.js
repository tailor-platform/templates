let workOrders = {{ dashboardWorkOrders.data.workOrders.collection || [] }};

function getWorkCenterStatusCounts(data) {
  return data.reduce((acc, item) => {
    const workCenterName = item.operation.workCenter.name;
    const workCenterId = item.operation.workCenterId;
    const status = item.status;

    // Find existing work center entry
    let existingWorkCenter = acc.find(wc => wc.workcenterName === workCenterName);

    // If work center doesn't exist, create a new entry
    if (!existingWorkCenter) {
      existingWorkCenter = {
        workcenterName: workCenterName,
        workCenterId: workCenterId,
        statusCount: [],
      };
      acc.push(existingWorkCenter);
    }

    // Find the status in the statusCount array
    let statusEntry = existingWorkCenter.statusCount.find(sc => sc.status === status);

    // If status entry doesn't exist, create one
    if (!statusEntry) {
      statusEntry = { status: status, count: 0 };
      existingWorkCenter.statusCount.push(statusEntry);
    }

    // Increment the count for this status
    statusEntry.count += 1;

    return acc;
  }, []);
}

const result = getWorkCenterStatusCounts(workOrders);

return { result };
