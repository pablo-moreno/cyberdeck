class_name Trait
extends Node

enum TYPE {
    BATTLE,
    TURN,
}


@export var type: TYPE = TYPE.TURN


func apply(target: Character):
    pass
