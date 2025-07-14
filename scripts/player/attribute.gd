class_name Attribute extends Node

@export_range(0, 20) var value: int = 10

var modifier:
    get:
        return (value - 10) / 2
