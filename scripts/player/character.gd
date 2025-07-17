class_name Character extends CharacterBody2D

#region Nodes
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var deck: Pile = $Piles/Deck
@onready var draw_pile: Pile = $Piles/Draw
@onready var discard_pile: Pile = $Piles/Discard
@onready var hand: Pile = $Piles/Hand
@onready var exhaust_pile: Pile = $Piles/Exhaust
@onready var traits: Node = $Traits
@onready var health: Health = $Health
@onready var dropable_card_area: DropableCardArea = $DropableCardArea
#endregion

#region Exported variables
@export var cards_to_draw: int = 5
@export var default_max_energy: int = 3
@export var max_energy: int = 3
@export var current_energy: int = 3
@export var modulate_color: Color = Color(0.0, 0.863, 0.863)
#endregion

#region Signals
signal ended_player_turn
signal started_player_turn

signal current_energy_changed(value: int)
signal max_energy_changed(value: int)

signal cannot_play_card
signal hand_reset

signal dead
#endregion


func _ready() -> void:
    move_cards_to_draw()
    health.death.connect(_on_death)
    GlobalSignals.discard_card.connect(discard_card)
    GlobalSignals.exhaust_card.connect(exhaust_card)
    started_player_turn.connect(start_turn)
    dropable_card_area.dragging_over.connect(_on_dropable_area_dragging_over)
    dropable_card_area.not_dragging.connect(_on_dropable_area_not_dragging)
    sprite.play('idle')


#region Card handling
func _get_cards_to_draw() -> int:
    return cards_to_draw


func move_cards_to_draw():
    var cards = deck.get_all_cards()
    
    for card in cards:
        card.set_player(self)
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

    if is_exhaust:
        GlobalSignals.exhaust_card.emit(card)
    else:
        GlobalSignals.discard_card.emit(card)
    
    current_energy -= card.energy
    current_energy_changed.emit(current_energy)

#endregion

#region Turn management
func end_turn():
    ended_player_turn.emit()


func start_turn():
    apply_effects()
    draw_round_cards()
    reset_energy()
    health.reset_shield()
    GlobalSignals.set_energy_remaining(current_energy)


func apply_effects():
    var _traits = traits.get_children()
    
    for _trait in _traits:
        if _trait is not Trait:
            continue

        _trait.apply(self)


func set_max_energy(amount):
    max_energy = amount


func reset_energy():
    current_energy = max_energy
    current_energy_changed.emit(current_energy)


func spend_energy(amount: int):
    current_energy -= amount
    current_energy_changed.emit(current_energy)
    
#endregion

#region Signal events
func _on_death():
    dead.emit()


func _on_dropable_area_dragging_over() -> void:
    sprite.modulate = modulate_color


func _on_dropable_area_not_dragging() -> void:
    sprite.modulate = Color(Color.WHITE, 1)
#endregion
