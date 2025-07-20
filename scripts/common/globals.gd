extends Node


enum TargetType {
    ALL_ENEMIES,
    ENEMY,
    PLAYER,
}


signal card_changed_pile(card: Card, pile: Pile)
signal enemy_dead(character: Character)

signal remove_from_hand(card_ui: CardUI)

signal discard_card(card: Card)
signal exhaust_card(card: Card)
signal drawn_card(card: Card)
signal changed_energy(value: int)

var energy_remaining: int = 0


var _mouse_arrow = load("res://sprites/textures/mouse.png")
var _mouse_pointing = load("res://sprites/textures/mouse_pointing.png")
var _mouse_drag = load("res://sprites/textures/mouse_drag.png")
var _mouse_drop = load("res://sprites/textures/mouse_rock.png")


func _ready() -> void:
    changed_energy.connect(set_energy_remaining)
    setup_mouse()    


func setup_mouse():
    Input.set_custom_mouse_cursor(_mouse_arrow)
    Input.set_custom_mouse_cursor(_mouse_pointing, Input.CURSOR_POINTING_HAND)
    Input.set_custom_mouse_cursor(_mouse_drag, Input.CURSOR_DRAG)
    Input.set_custom_mouse_cursor(_mouse_drop, Input.CURSOR_CAN_DROP)


func set_energy_remaining(value: int):
    energy_remaining = value
