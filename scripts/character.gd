class_name Character extends CharacterBody2D

@onready var deck: Pile = $Piles/Deck
@onready var draw_pile: Pile = $Piles/Draw
@onready var discard_pile: Pile = $Piles/Discard
@onready var hand: Pile = $Piles/Hand
@onready var exhaust_pile: Pile = $Piles/Exhaust
@onready var traits: Node = $Traits

@onready var health: Health = $Health
@export var cards_to_draw: int = 5

@export var default_max_energy: int = 3
@export var max_energy: int = 3
@export var current_energy: int = 3


signal ended_player_turn
signal started_player_turn
signal current_energy_changed(value: int)
signal cannot_play_card
signal hand_reset


func _ready() -> void:
    move_cards_to_draw()
    GlobalSignals.discard_card.connect(discard_card)


func move_cards_to_draw():
    var cards = deck.get_all_cards()
    deck.move_to(cards, draw_pile)


func draw_cards(amount: int = 5):
    var _cards = draw_pile.get_cards(amount)
    
    for _card in _cards:
        GlobalSignals.drawn_card.emit(_card)
    
    if len(_cards) == amount:
        draw_pile.move_to(_cards, hand)
        return
    
    hand_reset.emit()
    discard_pile.move_to(discard_pile.get_all_cards(), draw_pile)
    _cards = draw_pile.get_cards(amount)
    draw_pile.move_to(_cards, hand)


func draw_round_cards():
    draw_cards(cards_to_draw)


func discard_all_hand():
    var cards = hand.get_all_cards()
    for card in cards:
        discard_card(card)


func discard_card(card: Card):
    hand.move_to([card], discard_pile)


func play_card(card: Card, targets: Array[Character]):
    if card.energy > current_energy:
        cannot_play_card.emit()
        return
    
    var is_exhaust = card.play(self, targets)

    if is_exhaust:
        hand.move_to([card], exhaust_pile)
    else:
        hand.move_to([card], discard_pile)
    
    current_energy -= card.energy
    current_energy_changed.emit(current_energy)


func end_turn():
    ended_player_turn.emit()


func start_turn():
    started_player_turn.emit()
    apply_effects()
    draw_round_cards()
    current_energy = max_energy


func apply_effects():
    var _traits = traits.get_children()
    
    for _trait in _traits:
        if _trait is not Trait:
            continue

        _trait.apply(self)


func set_max_energy(amount):
    max_energy = amount
