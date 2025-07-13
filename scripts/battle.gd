extends Node2D


@onready var player: Character = $Player
@onready var hand: Hand = $Hand
@onready var turn_manager: TurnManager = $TurnManager


const CARD_UI = preload("res://scenes/cards/card_ui.tscn")


func _ready() -> void:
    GlobalSignals.card_changed_pile.connect(_on_card_changed_pile)


func _on_card_changed_pile(card: Card, pile: Pile):
    if pile != player.hand:
        return

    var card_ui = CARD_UI.instantiate()
    card_ui.set_card(card)
    hand.draw(card_ui)


func _on_draw_button_pressed() -> void:
    player.draw_cards()


func _on_discard_button_pressed() -> void:
    pass # Replace with function body.
