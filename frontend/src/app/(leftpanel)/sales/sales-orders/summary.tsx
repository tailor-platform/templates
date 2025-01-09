type SummaryMetric = {
  label: string;
  value: string | number;
  change?: string;
};

type Props = {
  metrics: {
    totalOrders: number;
    totalRevenue: number;
    averageOrderValue: number;
    pendingOrders: number;
    cancelledOrders: number;
    previousTotalOrders: number;
    previousTotalRevenue: number;
    previousAverageOrderValue: number;
    previousCancelledOrders: number;
    shippedOrders: number;
  };
};

export const SalesOrderSummary = ({ metrics }: Props) => {
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    }).format(amount);
  };

  const calculatePercentageChange = (
    current: number,
    previous: number,
  ): string => {
    if (previous === 0) return "0%";
    const change = ((current - previous) / previous) * 100;
    return `${change >= 0 ? "+" : ""}${change.toFixed(0)}%`;
  };

  const summaryCards: SummaryMetric[] = [
    {
      label: "Total Sales Orders",
      value: metrics.totalOrders,
      change: `${calculatePercentageChange(metrics.totalOrders, metrics.previousTotalOrders)} from yesterday`,
    },
    {
      label: "Total Revenue",
      value: formatCurrency(metrics.totalRevenue),
      change: `${calculatePercentageChange(metrics.totalRevenue, metrics.previousTotalRevenue)} from yesterday`,
    },
    {
      label: "Average Order Value",
      value: formatCurrency(metrics.averageOrderValue),
      change: `${calculatePercentageChange(metrics.averageOrderValue, metrics.previousAverageOrderValue)} from yesterday`,
    },
    {
      label: "Not Sent Orders",
      value: metrics.pendingOrders,
      change: `${metrics.shippedOrders} shipped today`,
    },
    {
      label: "Cancelled Orders",
      value: metrics.cancelledOrders,
      change: `${calculatePercentageChange(metrics.cancelledOrders, metrics.previousCancelledOrders)} from yesterday`,
    },
  ];

  return (
    <div className="py-2">
      <div
        className="grid gap-4"
        style={{ gridTemplateColumns: "minmax(100px, 0.5fr) repeat(5, 1fr)" }}
      >
        <div
          key={0}
          className="flex items-center justify-center rounded-md border border-border/40 bg-card bg-transparent p-4 transition-colors"
        >
          <div className="text-2xl font-semibold tracking-tight">Today</div>
        </div>
        {summaryCards.map((metric, index) => (
          <div
            key={index}
            className="rounded-md border border-border/40 bg-card bg-transparent p-4 transition-colors"
          >
            <div className="mb-2 text-sm text-muted-foreground">
              {metric.label}
            </div>
            <div className="text-2xl font-semibold tracking-tight">
              {metric.value}
            </div>
            {metric.change && (
              <div
                className={`mt-1 mt-2 text-xs ${
                  metric.change.startsWith("+")
                    ? "text-emerald-500"
                    : "text-muted-foreground"
                }`}
              >
                {metric.change}
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};
