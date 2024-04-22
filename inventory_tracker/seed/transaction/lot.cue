package transaction

import (
	"tailor.build/template/seed/utils"
)

#Lots: {
    Lot1: {
        id: utils.uuid & {_, #type: "lot", #value: "1"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "1"}
    },
    Lot2: {
        id: utils.uuid & {_, #type: "lot", #value: "2"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "2"}
    },
    Lot3: {
        id: utils.uuid & {_, #type: "lot", #value: "3"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "3"}
    },
    Lot4: {
        id: utils.uuid & {_, #type: "lot", #value: "4"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "4"}
    },
    Lot5: {
        id: utils.uuid & {_, #type: "lot", #value: "5"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "5"}
    },
    Lot6: {
       id: utils.uuid & {_, #type: "lot", #value: "6"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "6"}
    },
    Lot7: {
        id: utils.uuid & {_, #type: "lot", #value: "7"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "7"}
    },
    Lot8: {
        id: utils.uuid & {_, #type: "lot", #value: "8"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "8"}
    },
    Lot9: {
       id: utils.uuid & {_, #type: "lot", #value: "9"},
       putAwayID: utils.uuid & {_, #type: "putAway", #value: "9"}
    },
    Lot10: {
        id: utils.uuid & {_, #type: "lot", #value: "10"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "10"}
    },
    Lot11: {
        id: utils.uuid & {_, #type: "lot", #value: "11"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "11"}
    },
    Lot12: {
        id: utils.uuid & {_, #type: "lot", #value: "12"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "12"}
    },
    Lot13: {
        id: utils.uuid & {_, #type: "lot", #value: "13"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "13"}
    },
    Lot14: {
        id: utils.uuid & {_, #type: "lot", #value: "14"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "14"}
    },
    Lot15: {
        id: utils.uuid & {_, #type: "lot", #value: "15"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "15"}
    },
    Lot16: {
        id: utils.uuid & {_, #type: "lot", #value: "16"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "16"}
    },
    Lot17: {
        id: utils.uuid & {_, #type: "lot", #value: "17"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "17"}
    },
    Lot18: {
        id: utils.uuid & {_, #type: "lot", #value: "18"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "18"}
    },
    Lot19: {
        id: utils.uuid & {_, #type: "lot", #value: "19"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "19"}
    },
    Lot20: {
        id: utils.uuid & {_, #type: "lot", #value: "20"},
        putAwayID: utils.uuid & {_, #type: "putAway", #value: "20"}
    }
}

Lot: {
   items: [
		for k, v in #Lots {
			v
		},
	],
}
