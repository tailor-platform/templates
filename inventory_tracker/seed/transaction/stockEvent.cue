package transaction

import (
	"tailor.build/template/seed/utils"
)

#StockEvents: {
    StockEvent1: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "1"},
        eventDate: "2023-11-02",
        lotID: utils.uuid & {_, #type: "lot", #value: "1"},
        incrementalQuantity: 8,
        reason: "Put Away"
    },
    StockEvent2: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "2"},
        eventDate: "2023-11-03",
        lotID: utils.uuid & {_, #type: "lot", #value: "2"},
        incrementalQuantity: 19,
        reason: "Put Away"
    },
    StockEvent3: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "3"},
        eventDate: "2023-11-05",
        lotID: utils.uuid & {_, #type: "lot", #value: "3"},
        incrementalQuantity: 3,
        reason: "Put Away"
    },
    StockEvent4: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "4"},
        eventDate: "2023-11-06",
        lotID: utils.uuid & {_, #type: "lot", #value: "4"},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent5: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "5"},
        eventDate: "2023-11-06",
        lotID: utils.uuid & {_, #type: "lot", #value: "5"},
        incrementalQuantity: 1,
        reason: "Put Away"
    },
    StockEvent6: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "6"},
        eventDate: "2023-11-06",
        lotID: utils.uuid & {_, #type: "lot", #value: "6"},
        incrementalQuantity: 1,
        reason: "Put Away"
    },
    StockEvent7: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "7"},
        eventDate: "2023-11-06",
        lotID: utils.uuid & {_, #type: "lot", #value: "7"},
        incrementalQuantity: 11,
        reason: "Put Away"
    },
    StockEvent8: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "8"},
        eventDate: "2023-11-07",
        lotID: utils.uuid & {_, #type: "lot", #value: "8"},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent9: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "9"},
        eventDate: "2023-11-07",
        lotID: utils.uuid & {_, #type: "lot", #value: "9"},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent10: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "10"},
        eventDate: "2023-11-07",
        lotID: utils.uuid & {_, #type: "lot", #value: "10"},
        incrementalQuantity: 10,
        reason: "Put Away"
    },
    StockEvent11: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "11"},
        eventDate: "2023-11-07",
        lotID: utils.uuid & {_, #type: "lot", #value: "11"},
        incrementalQuantity: 2,
        reason: "Put Away"
    },
    StockEvent12: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "12"},
        eventDate: "2023-11-08",
        lotID: utils.uuid & {_, #type: "lot", #value: "12"},
        incrementalQuantity: 20,
        reason: "Put Away"
    },
    StockEvent13: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "13"},
        eventDate: "2023-11-09",
        lotID: utils.uuid & {_, #type: "lot", #value: "13"},
        incrementalQuantity: 50,
        reason: "Put Away"
    },
    StockEvent14: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "14"},
        eventDate: "2023-11-09",
        lotID: utils.uuid & {_, #type: "lot", #value: "14"},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent15: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "15"},
        eventDate: "2023-11-10",
        lotID: utils.uuid & {_, #type: "lot", #value: "15"},
        incrementalQuantity: 3,
        reason: "Put Away"
    },
    StockEvent16: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "16"},
        eventDate: "2023-11-11",
        lotID: utils.uuid & {_, #type: "lot", #value: "16"},
        incrementalQuantity: 2,
        reason: "Put Away"
    },
    StockEvent17: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "17"},
        eventDate: "2023-11-11",
        lotID: utils.uuid & {_, #type: "lot", #value: "17"},
        incrementalQuantity: 3,
        reason: "Put Away"
    },
    StockEvent18: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "18"},
        eventDate: "2023-11-12",
        lotID: utils.uuid & {_, #type: "lot", #value: "18"},
        incrementalQuantity: 40,
        reason: "Put Away"
    },
    StockEvent19: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "19"},
        eventDate: "2023-11-14",
        lotID: utils.uuid & {_, #type: "lot", #value: "19"},
        incrementalQuantity: 10,
        reason: "Put Away"
    },
    StockEvent20: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "20"},
        eventDate: "2023-11-17",
        lotID: utils.uuid & {_, #type: "lot", #value: "20"},
        incrementalQuantity: 2,
        reason: "Put Away"
    },
    StockEvent21: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "21"},
        eventDate: "2023-11-11",
        lotID: utils.uuid & {_, #type: "lot", #value: "1"},
        incrementalQuantity: -5,
        reason: "Ship Out"
    },
    StockEvent22: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "22"},
        eventDate: "2023-11-11",
        lotID: utils.uuid & {_, #type: "lot", #value: "2"},
        incrementalQuantity: -10,
        reason: "Ship Out"
    },
    StockEvent23: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "23"},
        eventDate: "2023-11-12",
        lotID: utils.uuid & {_, #type: "lot", #value: "3"},
        incrementalQuantity: -2,
        reason: "Ship Out"
    },
    StockEvent24: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "24"},
        eventDate: "2023-11-13",
        lotID: utils.uuid & {_, #type: "lot", #value: "4"},
        incrementalQuantity: -5,
        reason: "Ship Out"
    },
    StockEvent25: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "25"},
        eventDate: "2023-11-14",
        lotID: utils.uuid & {_, #type: "lot", #value: "5"},
        incrementalQuantity: -1,
        reason: "Ship Out"
    },
    StockEvent26: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "26"},
        eventDate: "2023-11-15",
        lotID: utils.uuid & {_, #type: "lot", #value: "6"},
        incrementalQuantity: -1,
        reason: "Ship Out"
    },
    StockEvent27: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "27"},
        eventDate: "2023-11-16",
        lotID: utils.uuid & {_, #type: "lot", #value: "7"},
        incrementalQuantity: -10,
        reason: "Ship Out"
    },
    StockEvent28: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "28"},
        eventDate: "2023-11-17",
        lotID: utils.uuid & {_, #type: "lot", #value: "8"},
        incrementalQuantity: -3,
        reason: "Ship Out"
    },
    StockEvent29: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "29"},
        eventDate: "2023-11-18",
        lotID: utils.uuid & {_, #type: "lot", #value: "9"},
        incrementalQuantity: -3,
        reason: "Ship Out"
    },
    StockEvent30: {
        id: utils.uuid & {_, #type: "stockEvent", #value: "30"},
        eventDate: "2023-11-19",
        lotID: utils.uuid & {_, #type: "lot", #value: "10"},
        incrementalQuantity: -5,
        reason: "Ship Out"
    }
}

StockEvent: {
   items: [
		for k, v in #StockEvents {
			v
		},
	],
}

