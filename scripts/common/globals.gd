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


func _ready() -> void:
    changed_energy.connect(set_energy_remaining)


func set_energy_remaining(value: int):
    energy_remaining = value
