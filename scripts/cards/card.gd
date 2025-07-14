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


func _ready() -> void:
    pass


func discard():
    GlobalSignals.discard_card.emit(self)


func get_effects() -> Array[CardEffect]:
    var effects: Array[CardEffect] = []
    var children = get_children()
    
    for child in children:
        if child is CardEffect:
            effects.append(child)

    return effects


func play(origin: Character, targets: Array[Character]) -> bool:
    for effect in get_effects():
        effect.apply(self, origin, targets)
    
    return is_exhaust


func move_to(target: Pile):
    reparent(target)        
    GlobalSignals.card_changed_pile.emit(self, target)


func get_description():
    return tr('Ataca')
