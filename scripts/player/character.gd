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
    GlobalSignals.exhaust_card.connect(exhaust_card)
    started_player_turn.connect(start_turn)


func _get_cards_to_draw() -> int:
    return cards_to_draw


func move_cards_to_draw():
    var cards = deck.get_all_cards()
    
    for card in cards:
        card.move_to(draw_pile)


func draw_cards(amount: int = 5):
    var _cards = draw_pile.get_cards(amount)
    var _drawed_cards = len(_cards)

    for _card in _cards:
        _card.move_to(hand)
        GlobalSignals.drawn_card.emit(_card)

    if _drawed_cards == amount:
        return

    for _card in discard_pile.get_all_cards():
        if _card is Card:
            _card.move_to(draw_pile)

    hand_reset.emit()

    _cards = draw_pile.get_cards(amount - _drawed_cards)
    for _card in _cards:
        if _card is Card:
            _card.move_to(hand)
            GlobalSignals.drawn_card.emit(_card)


func draw_round_cards():
    draw_cards(_get_cards_to_draw())


func discard_all_hand():
    var cards = hand.get_all_cards()

    for card in cards:
        GlobalSignals.discard_card.emit(card)


func discard_card(card: Card):
    card.move_to(discard_pile)


func exhaust_card(card: Card):
    card.move_to(exhaust_pile)


func play_card(card: Card, targets: Array[Enemy]):
    if card.energy > current_energy:
        cannot_play_card.emit()
        return
    
    var is_exhaust = card.play(targets)
    current_energy -= card.energy
    current_energy_changed.emit(current_energy)

    if is_exhaust:
        GlobalSignals.exhaust_card.emit(card)
    else:
        GlobalSignals.discard_card.emit(card)
    
    current_energy -= card.energy
    current_energy_changed.emit(current_energy)


func end_turn():
    ended_player_turn.emit()


func start_turn():
    print("turno de %s" % name)
    apply_effects()
    draw_round_cards()
    current_energy = max_energy
    GlobalSignals.set_energy_remaining(current_energy)


func apply_effects():
    var _traits = traits.get_children()
    
    for _trait in _traits:
        if _trait is not Trait:
            continue

        _trait.apply(self)


func set_max_energy(amount):
    max_energy = amount
