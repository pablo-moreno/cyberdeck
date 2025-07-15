class_name Card extends Node


enum CARD_TYPE {
    BASE,
    PURPLE,
    GOLD,
}

@export var card_name: String = ''
@export var is_exhaust: bool = false
@export_range(0, 9) var energy: int = 3

@export var type: CARD_TYPE = CARD_TYPE.BASE
const SIZE: Vector2 = Vector2(48, 64)

signal play_card(targets: Variant)


func _ready() -> void:
    play_card.connect(play)


func discard():
    GlobalSignals.discard_card.emit(self)


func get_effects() -> Array[CardEffect]:
    var effects: Array[CardEffect] = []
    var children = get_children()
    
    for child in children:
        if child is CardEffect:
            effects.append(child)

    return effects


func play(targets: Array[Variant]) -> bool:
    if is_exhaust:
        GlobalSignals.exhaust_card.emit(self)
    else:
        GlobalSignals.discard_card.emit(self)
    
    return is_exhaust


func move_to(target: Pile):
    reparent(target)        
    GlobalSignals.card_changed_pile.emit(self, target)


func get_description():
    return tr('Ataca')
