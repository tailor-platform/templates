# Work-Order

## Overview

This template  provides a comprehensive design for the Work Order application. The application will integrate with Inventory Management Systems (IMS), Purchase Order/Sales Order (PO/SO) systems, and Bill of Materials (BOM) applications to facilitate the creation, management, and tracking of work orders.

## Usage
To deploy this template, run the following commands

```
make init
make apply
```

To gain further insight into the data structure, visit the [Tailor Console](https://console.tailor.tech) and explore the data schema using live sample data.

## Seed the initial data

1. Install dependencies in the templates folder

```
pnpm i
```

2. To seed the initial data into a deployed application run the following commands:

```bash
cd work_order
node ../common/scripts/seed.mjs
```

## Sample GraphQL queries and mutations

Get real and expected duration of work order
```graphql
query aggregateWorkOrder {
  aggregateWorkOrders {
    sum {
      realDuration
      expectedDuration
    }
  }
}
```


## ERD for this application
```mermaid
erDiagram
    DayOfWeek {
        enum Sunday
        enum Monday
        enum Tuesday
        enum Wednesday
        enum Thursday
        enum Friday
        enum Saturday
    }

    WorkOrderStatus {
        enum Waiting_for_another_WO
        enum Waiting_for_components
        enum Ready
        enum In_Progress
        enum Finished
        enum Blocked
    }

    BOM {
        id ID
        name string
        description string
        outputQuantity number
    }

    Employee {
        id ID
        name string
        role string
    }

    WorkingHours {
        id ID
        name string
        standardHoursPerWeek number
        timeZone string
        isActive boolean
    }

    DailySchedule {
        id ID
        workingHoursId ID
        dayOfWeek DayOfWeek
        workFrom string
        workTo string
        duration number
    }

    WorkCenter {
        id ID
        name string
        description string
        code string
        workingHoursId ID
        timeEfficiency number
        capacity number
        setupTime number
        cleanupTime number
        costPerHour number
        costPerEmployee number
        isActive boolean
    }

    Operation {
        id ID
        name string
        bomId ID
        workCenterId ID
        duration number
        description string
        documentUrl string
        isActive boolean
    }

    WorkOrder {
        id ID
        status WorkOrderStatus
        operationId ID
        workCenterId ID
        expectedDuration number
        realDuration number
        isBlocked boolean
        isDeleted boolean
        startDate Date
        endDate Date
    }

    WOTimeTracking {
        workOrderId ID
        employeeId ID
        duration number
        startDate Date
        endDate Date
    }

    WorkingHours ||--o{ DailySchedule : has
    DailySchedule }o--|| DayOfWeek : on

    WorkCenter ||--|| WorkingHours : uses
    Operation ||--|| BOM : uses
    Operation ||--|| WorkCenter : performed_at

    WorkOrder ||--|| Operation : based_on
    WorkOrder ||--|| WorkCenter : executed_at

    WOTimeTracking ||--|| WorkOrder : tracks
    WOTimeTracking ||--|| Employee : worked_by
```