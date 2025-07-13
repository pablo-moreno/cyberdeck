class_name AttackEffect extends CardEffect


@export var base_damage: int = 6


func get_damage_to_apply(card: Card, origin: Character, target: Character) -> int:
    var multiplier = 1
    
    for weakness in target.get_weaknesses():
        if weakness.type == card.element:
            multiplier *= 2
    
    return base_damage * multiplier


func apply(card: Card, origin: Character, targets: Array[Character]):
    for target in targets:
        var damage = get_damage_to_apply(card, origin, target)
        target.health.take_damage(damage)
