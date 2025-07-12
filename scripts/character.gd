class_name Character extends Node


@onready var strength: Attribute = $Skills/Strength
@onready var intelligence: Attribute = $Skills/Intelligence
@onready var dexterity: Attribute = $Skills/Dexterity
@onready var persuasion: Attribute = $Skills/Persuasion
@onready var wisdom: Attribute = $Skills/Wisdom
@onready var constitution: Attribute = $Skills/Constitution

@onready var deck: Pile = $Piles/Deck
@onready var draw_pile: Pile = $Piles/Draw
@onready var discard_pile: Pile = $Piles/Discard
@onready var hand: Pile = $Piles/Hand
@onready var exhaust_pile: Pile = $Piles/Exhaust

@onready var health: Health = $Health
@onready var weaknesses_parent: Node = $Weaknesses


func _ready() -> void:
    pass


func get_weaknesses() -> Array[Weakness]:
    var weaknesses: Array[Weakness] = []
    var children = weaknesses_parent.get_children()

    for child in children:
        if child is Weakness:
            weaknesses.append(child)

    return weaknesses


func play_card(card: Card, targets: Array[Character]):
    var is_exhaust = card.play(self, targets)

    if is_exhaust:
        hand.move_to([card], exhaust_pile)
    else:
        hand.move_to([card], discard_pile)
