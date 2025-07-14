extends Node2D


@onready var player: Character = $Player
@onready var hand: Hand = $Hand
@onready var turn_manager: TurnManager = $TurnManager

@onready var discard_counter := $UI/DiscardCounter
@onready var draw_counter := $UI/DrawCounter
@onready var hand_counter := $UI/HandCounter

@onready var enemies_parent: Node = $Enemies

const CARD_UI = preload("res://scenes/ui/card_ui.tscn")


func _ready() -> void:
    _setup()
    GlobalSignals.discard_card.connect(_on_card_discarded)
    GlobalSignals.drawn_card.connect(_on_drawn_card)
    draw_counter.text = str(player.draw_pile.get_child_count())
    discard_counter.text = str(player.discard_pile.get_child_count())


func _setup():
    for child in enemies_parent.get_children():
        if child is Enemy:
            turn_manager.add_enemy(child)
            child.set_player(player)
        
    turn_manager.init()


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
    print("ME TOCAAAAA")
    player.start_turn()


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
