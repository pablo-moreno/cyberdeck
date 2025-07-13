class_name Character extends CharacterBody2D

@onready var deck: Pile = $Piles/Deck
@onready var draw_pile: Pile = $Piles/Draw
@onready var discard_pile: Pile = $Piles/Discard
@onready var hand: Pile = $Piles/Hand
@onready var exhaust_pile: Pile = $Piles/Exhaust

@onready var health: Health = $Health
@export var cards_to_draw: int = 5


func _ready() -> void:
    move_cards_to_draw()
        

func move_cards_to_draw():
    var cards = deck.get_all_cards()
    deck.move_to(cards, draw_pile, true)


func draw_cards(amount: int = 5):
    var _cards = draw_pile.get_cards(amount)
    
    if len(_cards) == amount:
        draw_pile.move_to(_cards, hand)
        
        return
    
    discard_pile.move_to(discard_pile.get_all_cards(), draw_pile)
    _cards = draw_pile.get_cards(amount)
    draw_pile.move_to(_cards, hand)


func play_card(card: Card, targets: Array[Character]):
    var is_exhaust = card.play(self, targets)

    if is_exhaust:
        hand.move_to([card], exhaust_pile)
    else:
        hand.move_to([card], discard_pile)
