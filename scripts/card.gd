class_name Card extends Node


enum MODIFIERS {
    STRENGTH,
    INTELLIGENCE,
    DEXTERITY,
    WISDOM, 
    PERSUASION,
    CONSTITUTION,
}

@export var card_name: String = ''
@export var element: Elements.ELEMENTS
@export var modifier: MODIFIERS
@export var is_exhaust: bool = false
@export_range(0, 9) var energy: int = 3

signal changed_pile(pile: Pile)


func _ready() -> void:
    pass


func get_modifier_value(origin: Character) -> int:
    if modifier == MODIFIERS.STRENGTH:
        return origin.strength.modifier
    if modifier == MODIFIERS.INTELLIGENCE:
        return origin.intelligence.modifier
    if modifier == MODIFIERS.DEXTERITY:
        return origin.dexterity.modifier
    if modifier == MODIFIERS.WISDOM:
        return origin.wisdom.modifier
    if modifier == MODIFIERS.PERSUASION:
        return origin.persuasion.modifier
    if modifier == MODIFIERS.CONSTITUTION:
        return origin.constitution.modifier
    else:
        return 0


func get_effects() -> Array[CardEffect]:
    var effects: Array[CardEffect] = []
    var children = get_children()
    
    for child in children:
        if child is CardEffect:
            effects.append(child)
            
    return effects


func play(origin: Character, targets: Array[Character]) -> bool:
    var modifier = get_modifier_value(origin)

    for effect in get_effects():
        effect.apply(self, origin, targets)
    
    return is_exhaust
