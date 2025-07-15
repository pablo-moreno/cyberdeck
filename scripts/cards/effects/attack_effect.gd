class_name AttackEffect extends CardEffect


@export var base_damage: int = 6


func get_damage_to_apply(card: Card, origin: Character, target: Enemy) -> int:
    var multiplier = 1
    return base_damage * multiplier


func apply(card: Card, origin: Character, targets: Array[Variant]):
    for target in targets:
        var damage = get_damage_to_apply(card, origin, target)
        target.health.take_damage(damage)

func get_description():
    return tr("Hace %s de daño" % base_damage)
