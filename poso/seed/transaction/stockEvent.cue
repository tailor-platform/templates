package transaction

import (
	"tailor.build/template/seed/utils"
)

#StockEvents: {
    StockEvent5: {
        documentID: utils.uuid & {_, #type: "document", #value: "7"},
        isAdding: true,
    },
    StockEvent6: {
        documentID: utils.uuid & {_, #type: "document", #value: "5"},
        isAdding: false,
    }
}

StockEvent: {
	items: [
		for k, v in #StockEvents {
			v
		},
	]
    query: """
    mutation createStockEventsFromDocument ($input: createStockEventsFromDocumentInput!){
        createStockEventsFromDocument(
            input: $input
        ){
            result
            error
        }
    }
    """
}
