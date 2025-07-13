class_name TurnManager
extends Node

@export var player: Character = null
@export var enemies: Array[Character] = []

signal turn_ended(character: Character)
signal turn_start(character: Character)

signal enemy_turn_start(enemy: Enemy)
signal enemy_turn_ended(enemy: Enemy)

signal no_enemies_left
signal round_started
signal round_ended


var round_number: int = 1
var current_enemy_index: int = 0


func init() -> void:
    round_started.emit()
    player.ended_player_turn.connect(_on_ended_player_turn)
    

func _get_next() -> Character:
    if len(enemies) == 0:
        no_enemies_left.emit()
        round_ended.emit()
        return

    return null


func _on_ended_player_turn():
    pass
