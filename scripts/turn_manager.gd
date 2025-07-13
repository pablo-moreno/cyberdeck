class_name TurnManager
extends Node


@export var player: Character = null
@export var enemies: Array[Character] = []

signal turn_ended(character: Character)
signal turn_start(character: Character)

signal no_enemies_left
signal round_started
signal round_ended


func _ready() -> void:
    pass


func _get_next() -> Character:
    return null
