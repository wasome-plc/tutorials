{
    "graph": [
        {
            "id": "1",
            "label": "",
            "start_node": {
                "id": "3",
                "next_node_h": {
                    "id": "4",
                    "next_node_h": {
                        "id": "5",
                        "next_node_h": {
                            "id": "2",
                            "next_node_h": null,
                            "className": "EndNode"
                        },
                        "className": "BlockNode",
                        "functionName": "MC_MoveVelocity",
                        "type": "FB",
                        "inputs": [
                            {
                                "paramName": "Execute",
                                "linkedVariable": "mpower.Status",
                                "type": "BOOL",
                                "input_not": false,
                                "output_not": false
                            },
                            {
                                "paramName": "ContinuousUpdate",
                                "linkedVariable": "continuousUpdate",
                                "type": "BOOL",
                                "input_not": false,
                                "output_not": false
                            },
                            {
                                "paramName": "Velocity",
                                "linkedVariable": "velocity",
                                "type": "REAL",
                                "input_not": false,
                                "output_not": false
                            },
                            {
                                "paramName": "Acceleration",
                                "linkedVariable": "acceleration",
                                "type": "REAL",
                                "input_not": false,
                                "output_not": false
                            },
                            {
                                "paramName": "Deceleration",
                                "linkedVariable": "deceleretion",
                                "type": "REAL",
                                "input_not": false,
                                "output_not": false
                            },
                            {
                                "paramName": "Jerk",
                                "linkedVariable": "jerk",
                                "type": "REAL",
                                "input_not": false,
                                "output_not": false
                            },
                            {
                                "paramName": "Direction",
                                "linkedVariable": "direction",
                                "type": "MC_DIRECTION",
                                "input_not": false,
                                "output_not": false
                            },
                            {
                                "paramName": "BufferMode",
                                "linkedVariable": "bufferMode",
                                "type": "MC_BUFFER_MODE",
                                "input_not": false,
                                "output_not": false
                            }
                        ],
                        "outputs": [
                            {
                                "paramName": "InVelocity",
                                "linkedVariable": "invelocity",
                                "type": "BOOL",
                                "output_not": false,
                                "input_not": false
                            },
                            {
                                "paramName": "Busy",
                                "linkedVariable": "busy",
                                "type": "BOOL",
                                "output_not": false,
                                "input_not": false
                            },
                            {
                                "paramName": "Active",
                                "linkedVariable": "active",
                                "type": "BOOL",
                                "output_not": false,
                                "input_not": false
                            },
                            {
                                "paramName": "CommandAborted",
                                "linkedVariable": "commandAbort",
                                "type": "BOOL",
                                "output_not": false,
                                "input_not": false
                            },
                            {
                                "paramName": "Error",
                                "linkedVariable": "vel_error",
                                "type": "BOOL",
                                "output_not": false,
                                "input_not": false
                            },
                            {
                                "paramName": "ErrorID",
                                "linkedVariable": "vel_errorID",
                                "type": "WORD",
                                "output_not": false,
                                "input_not": false
                            }
                        ],
                        "inouts": [
                            {
                                "paramName": "Axis",
                                "linkedVariable": "Axis1",
                                "type": "AXIS_REF",
                                "input_not": false,
                                "output_not": false
                            }
                        ],
                        "variable": "mc_ve"
                    },
                    "className": "BlockNode",
                    "functionName": "MC_Power",
                    "type": "FB",
                    "inputs": [
                        {
                            "paramName": "Enable",
                            "linkedVariable": "___rail___",
                            "type": "BOOL",
                            "input_not": false,
                            "output_not": false
                        },
                        {
                            "paramName": "EnablePositive",
                            "linkedVariable": "enablepostion",
                            "type": "BOOL",
                            "input_not": false,
                            "output_not": false
                        },
                        {
                            "paramName": "EnableNegative",
                            "linkedVariable": "enableNegative",
                            "type": "BOOL",
                            "input_not": false,
                            "output_not": false
                        }
                    ],
                    "outputs": [
                        {
                            "paramName": "Status",
                            "linkedVariable": "status",
                            "type": "BOOL",
                            "output_not": false,
                            "input_not": false
                        },
                        {
                            "paramName": "Valid",
                            "linkedVariable": "vaild",
                            "type": "BOOL",
                            "output_not": false,
                            "input_not": false
                        },
                        {
                            "paramName": "Error",
                            "linkedVariable": "power_error",
                            "type": "BOOL",
                            "output_not": false,
                            "input_not": false
                        },
                        {
                            "paramName": "ErrorID",
                            "linkedVariable": "power_errorID",
                            "type": "WORD",
                            "output_not": false,
                            "input_not": false
                        }
                    ],
                    "inouts": [
                        {
                            "paramName": "Axis",
                            "linkedVariable": "Axis1",
                            "type": "AXIS_REF",
                            "input_not": false,
                            "output_not": false
                        }
                    ],
                    "variable": "mpower"
                },
                "className": "StartNode"
            },
            "className": "LDSection"
        }
    ],
    "variables": [
        {
            "name": "busy",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "active",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "continuousUpdate",
            "category": "VAR",
            "type": "BOOL",
            "init": "0"
        },
        {
            "name": "velocity",
            "category": "VAR",
            "type": "REAL",
            "init": "1"
        },
        {
            "name": "acceleration",
            "category": "VAR",
            "type": "REAL",
            "init": "50"
        },
        {
            "name": "deceleretion",
            "category": "VAR",
            "type": "REAL",
            "init": "10"
        },
        {
            "name": "jerk",
            "category": "VAR",
            "type": "REAL",
            "init": "10"
        },
        {
            "name": "direction",
            "category": "VAR",
            "type": "MC_DIRECTION",
            "init": "3"
        },
        {
            "name": "bufferMode",
            "category": "VAR",
            "type": "MC_BUFFER_MODE",
            "init": "1"
        },
        {
            "name": "invelocity",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "commandAbort",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "vel_error",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "vel_errorID",
            "category": "VAR",
            "type": "WORD"
        },
        {
            "name": "enablepostion",
            "category": "VAR",
            "type": "BOOL",
            "init": "1"
        },
        {
            "name": "enableNegative",
            "category": "VAR",
            "type": "BOOL",
            "init": "1"
        },
        {
            "name": "status",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "vaild",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "power_error",
            "category": "VAR",
            "type": "BOOL"
        },
        {
            "name": "power_errorID",
            "category": "VAR",
            "type": "WORD"
        }
    ],
    "type": "PROGRAM"
}