class_name Trait
extends Node

enum TYPE {
    BATTLE,
    START_TURN,
    END_TURN,
}

@export var texture: CompressedTexture2D = null
@export var type: TYPE = TYPE.START_TURN
@export var apply_on_count: int = 3

var counter: int = 0


func _ready() -> void:
    _set_initial_values()


func _set_initial_values():
    pass


func can_apply(_target: Character):
    return true


func apply(_target: Character):
    counter += 1


func reset_counter():
    counter = 0


func get_description():
    return tr("")
