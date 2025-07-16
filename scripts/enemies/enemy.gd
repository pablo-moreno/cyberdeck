class_name Enemy extends CharacterBody2D

signal round_started
signal turn_started
signal turn_ended(enemy: Enemy)
signal death(enemy: Enemy)

@onready var health: Health = $Health
@onready var actions: Node = $Actions
@onready var intention_sprite: Sprite2D = $IntentionSprite
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dropable_card_area: DropableCardArea = $DropableArea
@onready var health_progress_bar: TextureProgressBar = $TextureProgressBar

@export var modulate_color: Color = Color(1.0, 0.512, 0.433)


signal animate_action(name: String)


var _player: Character = null
var _current_action_index: int = 0
var is_dead: bool = false
var is_active: bool = false


func _ready() -> void:
    turn_started.connect(play)
    round_started.connect(_on_round_started)
    health.death.connect(_on_dead)
    health.damaged.connect(_on_damaged)
    dropable_card_area.dragging_over.connect(_on_dropable_area_dragging_over)
    dropable_card_area.not_dragging.connect(_on_dropable_area_not_dragging)
    sprite.animation_finished.connect(_on_animation_finished)
    sprite.play('idle')
    is_active = false


func set_player(player: Character):
    _player = player


func play():
    is_active = true
    health.reset_shield()
    _apply_next_action()

func _get_next_action() -> Action:
    var action = actions.get_child(_current_action_index)
    
    if action is Action:
        return action
        
    return null

func _apply_next_action():
    var actions_count = actions.get_child_count()
    var action = _get_next_action()

    sprite.play(action.animation_name)
    action.run(_player, self)

    _current_action_index += 1

    if _current_action_index == actions_count:
        _current_action_index = 0

    action.icon.visible = false


func _end_turn():
    is_active = false

    if sprite.animation_finished.is_connected(_end_turn):
        sprite.animation_finished.disconnect(_end_turn)

    turn_ended.emit(self)


func _on_dead():
    health_progress_bar.visible = false
    intention_sprite.visible = false
    is_dead = true
    sprite.play("dead")


func _on_damaged(_amount: int):
    sprite.play('damaged')


func _on_round_started():
    var _next_action = _get_next_action()
    intention_sprite.texture = _next_action.texture
    intention_sprite.texture_changed.emit()


func _on_dropable_area_dragging_over() -> void:
    sprite.modulate = modulate_color


func _on_dropable_area_not_dragging() -> void:
    sprite.modulate = Color(Color.WHITE, 1)


func _on_animation_finished():
    sprite.play('idle')

    if is_dead:
        _emit_death()
    elif is_active:
        _end_turn()


func _emit_death():
    death.emit(self)
