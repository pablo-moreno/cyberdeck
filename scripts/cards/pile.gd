class_name Pile extends Node


@export var max_size: int = 10
@export var _cards: Array[Card] = []


func _ready() -> void:
    var children = get_children()
    for card in children:
        if card is Card:
            _cards.append(card)


func get_cards(amount: int = 1) -> Array[Node]:
    var _card_nodes = get_children()
    _card_nodes.shuffle()
    return _card_nodes.slice(0, amount)


func get_all_cards(randomized: bool = true) -> Array[Node]:
    var _cards := get_children()
    
    if randomized:
        _cards.shuffle()
        
    return _cards
