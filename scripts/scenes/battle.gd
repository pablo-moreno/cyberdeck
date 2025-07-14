extends Node2D


@onready var player: Character = $Player
@onready var hand: Hand = $Hand
@onready var turn_manager: TurnManager = $TurnManager

@onready var discard_counter := $DiscardCounter
@onready var draw_counter := $DrawCounter
@onready var hand_counter := $HandCounter

const CARD_UI = preload("res://scenes/cards/card_ui.tscn")


func _ready() -> void:
    turn_manager.init()
    GlobalSignals.discard_card.connect(_on_card_discarded)
    GlobalSignals.drawn_card.connect(_on_drawn_card)
    draw_counter.text = str(player.draw_pile.get_child_count())
    discard_counter.text = str(player.discard_pile.get_child_count())
    
    


func _on_draw_button_pressed() -> void:
    player.draw_cards(player.cards_to_draw)


func _on_discard_button_pressed() -> void:
    pass # Replace with function body.


func _on_round_started():
    player.start_turn()


func _on_round_ended():
    pass


func _on_no_enemies_left():
    pass


func _on_turn_manager_turn_ended(character: Character) -> void:
    pass # Replace with function body.


func _on_turn_manager_turn_start(character: Character) -> void:
    pass # Replace with function body.


func _on_player_ended_player_turn() -> void:
    player.discard_all_hand()


func _on_end_turn_pressed() -> void:
    player.ended_player_turn.emit()


func _on_card_discarded(_card: Card):
    draw_counter.text = str(player.draw_pile.get_child_count())
    hand_counter.text = str(player.hand.get_child_count())
    discard_counter.text = str(player.discard_pile.get_child_count())


func _on_drawn_card(_card: Card):
    draw_counter.text = str(player.draw_pile.get_child_count())
    hand_counter.text = str(player.hand.get_child_count())
    discard_counter.text = str(player.discard_pile.get_child_count())
