class_name Pile extends Node


@export var max_size: int = 10
@export var _cards: Array[Card] = []


func _ready() -> void:
    var children = get_children()
    for card in children:
        if card is Card:
            _cards.append(card)


func move_to(cards: Array[Card], target: Pile, copy: bool = false):
    target.add_cards(cards)
    
    for card in cards:
        if not copy:
            var index: int = _cards.find(card)
            _cards.remove_at(index)
        
        GlobalSignals.card_changed_pile.emit(card, target)

func add_cards(cards: Array[Card]):
    cards.shuffle()
    _cards.append_array(cards)


func get_cards(amount: int = 1) -> Array[Card]:
    return _cards.slice(0, amount)


func get_all_cards() -> Array[Card]:
    return _cards
