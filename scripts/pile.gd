class_name Pile extends Node


@export var max_size: int = 10
@export var _cards: Array[Card] = []


func _ready() -> void:
    var children = get_children()
    for card in children:
        if card is Card:
            _cards.append(card)


func move_to(cards: Array[Node], target: Pile):
    for node in cards:
        if node is not Card:
            continue
        
        node.reparent(target)        
        GlobalSignals.card_changed_pile.emit(node, target)


func get_cards(amount: int = 1) -> Array[Node]:
    var _card_nodes = get_children()
    return _card_nodes.slice(0, amount)


func get_all_cards() -> Array[Node]:
    return get_children()
