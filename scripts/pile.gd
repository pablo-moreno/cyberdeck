class_name Pile extends Node


@export var max_size: int = 10


func move_to(cards: Array[Card], target: Pile, copy: bool = false):
    for card in cards:
        target.add_child(card)
        
        if not copy:
            remove_child(card)
        
        card.changed_pile.emit(target)
