class_name TurnManager
extends Node

signal player_turn_ended
signal turn_start
signal no_enemies_left
signal round_started
signal round_ended

@export var player: Character = null
@export var enemies: Array[Enemy] = []
var _enemies_that_acted: Array[Enemy] = []

var round_number: int = 0
var current_enemy_index: int = 0


func init() -> void:
    round_started.connect(_on_round_started)
    round_ended.connect(_on_round_ended)
    round_started.emit()
    player.ended_player_turn.connect(_on_ended_player_turn)
    player.started_player_turn.connect(_on_started_player_turn)
    
    for enemy in enemies:
        enemy.turn_ended.connect(_on_ended_enemy_turn)
        enemy.death.connect(_on_enemy_dead)

func add_enemy(enemy: Enemy):
    enemies.append(enemy)


func _get_next() -> Enemy:
    if len(enemies) == 0:
        no_enemies_left.emit()
        round_ended.emit()
        return
    
    if current_enemy_index == len(enemies):
        round_ended.emit()
        return
        
    var enemy: Enemy = enemies.get(current_enemy_index)
    current_enemy_index += 1
    _enemies_that_acted.append(enemy)

    return enemy

func reset_enemies():
    current_enemy_index = 0
    _enemies_that_acted = []

func _on_started_player_turn():
    pass


func _on_ended_player_turn():
    pass


func _on_ended_enemy_turn(enemy: Enemy):
    var next_enemy = _get_next()
    
    if next_enemy != null:
        next_enemy.turn_started.emit()


func _on_round_started():
    round_number += 1
    
    for enemy in enemies:
        enemy.round_started.emit()


func _on_round_ended():
    player.started_player_turn.emit()


func _on_enemy_dead(enemy: Enemy):
    var enemy_index = enemies.find(enemy)
    enemies.remove_at(enemy_index)
    enemy.queue_free()


func _on_player_turn_ended() -> void:
    player.ended_player_turn.emit()
    reset_enemies()
    var next_enemy = _get_next()
    
    if next_enemy != null:
        next_enemy.turn_started.emit()
