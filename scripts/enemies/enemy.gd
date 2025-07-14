class_name Enemy
extends CharacterBody2D

signal round_started
signal turn_started
signal turn_ended(enemy: Enemy)
signal death(enemy: Enemy)

@onready var health: Health = $Health
@onready var actions: Node = $Actions

var _player: Character = null
var _current_action_index: int = 0


func _ready() -> void:
    turn_started.connect(play)
    round_started.connect(_on_round_started)
    health.death.connect(_on_dead)

func set_player(player: Character):
    _player = player


func play():
    turn_ended.emit(self)
    _apply_next_action()


func _get_next_action() -> Action:
    var action = actions.get_child(_current_action_index)
    
    if action is Action:
        return action
        
    return null

func _apply_next_action():
    print('turno de %s' % name)
    var actions_count = actions.get_child_count()
    var action = _get_next_action()
    action.run(_player, self)

    _current_action_index += 1
    
    if _current_action_index == actions_count:
        _current_action_index = 0
    
    action.icon.visible = false


func _on_dead():
    death.emit(self)


func _on_round_started():
    print('inicio de ronda %s' % name)
    var _next_action = _get_next_action()
    _next_action.icon.visible = true
