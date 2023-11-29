#!/bin/bash

tailorctl app import -m ./charts/seed/master --auto-approve
tailorctl app import -m ./charts/seed/transaction/purchaseOrder.cue --auto-approve
tailorctl app import -m ./charts/seed/transaction/putAway.cue --auto-approve
tailorctl app import -m ./charts/seed/transaction/lot.cue --auto-approve
tailorctl app import -m ./charts/seed/transaction/salesOrder.cue --auto-approve
tailorctl app import -m ./charts/seed/transaction/shipOut.cue --auto-approve
tailorctl app import -m ./charts/seed/transactionWithEvent/purchaseOrder.cue --auto-approve
tailorctl app import -m ./charts/seed/transactionWithEvent/putAwayWithEvent.cue --auto-approve
tailorctl app import -m ./charts/seed/transactionWithEvent/salesOrder.cue --auto-approve
tailorctl app import -m ./charts/seed/transactionWithEvent/shipOut.cue --auto-approve
tailorctl app import -m ./charts/seed/stockEvent.cue --auto-approve
tailorctl app import -m ./charts/seed/test.cue --auto-approve