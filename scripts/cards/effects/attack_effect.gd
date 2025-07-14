class_name AttackEffect extends CardEffect


@export var base_damage: int = 6


@warning_ignore("unused_parameter")
func get_damage_to_apply(card: Card, origin: Character, target: Character) -> int:
    var multiplier = 1
    return base_damage * multiplier


func apply(card: Card, origin: Character, targets: Array[Character]):
    for target in targets:
        var damage = get_damage_to_apply(card, origin, target)
        target.health.take_damage(damage)
