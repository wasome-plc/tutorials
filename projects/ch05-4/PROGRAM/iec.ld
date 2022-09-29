{
    "graph": [
        {
            "id": "1",
            "label": "",
            "start_node": {
                "id": "3",
                "next_node_h": {
                    "id": "7",
                    "next_node_h": {
                        "id": "4",
                        "next_node_h": {
                            "id": "15",
                            "next_node_h": {
                                "id": "13",
                                "next_node_h": {
                                    "id": "8",
                                    "next_node_h": {
                                        "id": "6",
                                        "next_node_h": {
                                            "id": "2",
                                            "next_node_h": null,
                                            "className": "EndNode"
                                        },
                                        "className": "ItemNode",
                                        "variable": "Q00",
                                        "item_type": "Coil"
                                    },
                                    "className": "BranchCloseNode",
                                    "next_node_v": {
                                        "id": "20",
                                        "next_node_h": null,
                                        "className": "BranchCloseNode",
                                        "next_node_v": {
                                            "id": "21",
                                            "next_node_h": null,
                                            "className": "LineEndNode",
                                            "next_node_v": null
                                        }
                                    }
                                },
                                "className": "ItemNode",
                                "variable": "I30",
                                "item_type": "ReverseContact"
                            },
                            "className": "BranchCloseNode",
                            "next_node_v": {
                                "id": "16",
                                "next_node_h": null,
                                "className": "LineEndNode",
                                "next_node_v": null
                            }
                        },
                        "className": "ItemNode",
                        "variable": "I00",
                        "item_type": "Contact"
                    },
                    "className": "BranchOpenNode",
                    "next_node_v": {
                        "id": "18",
                        "next_node_h": {
                            "id": "17",
                            "next_node_h": {
                                "id": "16",
                                "next_node_h": null,
                                "className": "LineEndNode",
                                "next_node_v": null
                            },
                            "className": "ItemNode",
                            "variable": "Q00",
                            "item_type": "Contact"
                        },
                        "className": "LineBeginNode",
                        "next_node_v": {
                            "id": "19",
                            "next_node_h": {
                                "id": "10",
                                "next_node_h": {
                                    "id": "20",
                                    "next_node_h": null,
                                    "className": "BranchCloseNode",
                                    "next_node_v": {
                                        "id": "21",
                                        "next_node_h": null,
                                        "className": "LineEndNode",
                                        "next_node_v": null
                                    }
                                },
                                "className": "ItemNode",
                                "variable": "Q10",
                                "item_type": "Contact"
                            },
                            "className": "BranchOpenNode",
                            "next_node_v": {
                                "id": "23",
                                "next_node_h": {
                                    "id": "22",
                                    "next_node_h": {
                                        "id": "21",
                                        "next_node_h": null,
                                        "className": "LineEndNode",
                                        "next_node_v": null
                                    },
                                    "className": "ItemNode",
                                    "variable": "Q20",
                                    "item_type": "Contact"
                                },
                                "className": "LineBeginNode",
                                "next_node_v": null,
                                "close_node": "20"
                            },
                            "close_nodes": [
                                "20"
                            ]
                        },
                        "close_node": "15"
                    },
                    "close_nodes": [
                        "15",
                        "8"
                    ]
                },
                "className": "StartNode"
            },
            "className": "LDSection"
        },
        {
            "id": "24",
            "label": "",
            "start_node": {
                "id": "26",
                "next_node_h": {
                    "id": "27",
                    "next_node_h": {
                        "id": "29",
                        "next_node_h": {
                            "id": "28",
                            "next_node_h": {
                                "id": "30",
                                "next_node_h": {
                                    "id": "25",
                                    "next_node_h": null,
                                    "className": "EndNode"
                                },
                                "className": "ItemNode",
                                "variable": "Q10",
                                "item_type": "Coil"
                            },
                            "className": "ItemNode",
                            "variable": "Q20",
                            "item_type": "ReverseContact"
                        },
                        "className": "ItemNode",
                        "variable": "Q00",
                        "item_type": "Contact"
                    },
                    "className": "ItemNode",
                    "variable": "I10",
                    "item_type": "Contact"
                },
                "className": "StartNode"
            },
            "className": "LDSection"
        },
        {
            "id": "31",
            "label": "",
            "start_node": {
                "id": "33",
                "next_node_h": {
                    "id": "34",
                    "next_node_h": {
                        "id": "35",
                        "next_node_h": {
                            "id": "36",
                            "next_node_h": {
                                "id": "37",
                                "next_node_h": {
                                    "id": "32",
                                    "next_node_h": null,
                                    "className": "EndNode"
                                },
                                "className": "ItemNode",
                                "variable": "Q20",
                                "item_type": "Coil"
                            },
                            "className": "ItemNode",
                            "variable": "Q10",
                            "item_type": "ReverseContact"
                        },
                        "className": "ItemNode",
                        "variable": "Q00",
                        "item_type": "Contact"
                    },
                    "className": "ItemNode",
                    "variable": "I20",
                    "item_type": "Contact"
                },
                "className": "StartNode"
            },
            "className": "LDSection"
        }
    ],
    "variables": [],
    "type": "PROGRAM"
}