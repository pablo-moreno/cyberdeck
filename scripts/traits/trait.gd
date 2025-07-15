class_name Trait
extends Node

enum TYPE {
    BATTLE,
    TURN,
    COUNTER,
}


@export var type: TYPE = TYPE.TURN
@export var apply_on_count: int = 3

var _count = 0


func apply(target: Character):
    pass
