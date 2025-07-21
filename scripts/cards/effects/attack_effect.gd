class_name AttackEffect extends CardEffect


@export var base_damage: int = 6


func get_damage_to_apply(_card: Card, _origin: Character, _target: Enemy) -> int:
    var multiplier = 1
    return base_damage * multiplier


func apply(card: Card, origin: Character, targets: Array[Variant]):
    for target in targets:
        if target == null:
            continue

        var damage = get_damage_to_apply(card, origin, target)
        target.health.take_damage(damage)

func get_description() -> String:
    return tr("Hace %s de daño" % base_damage)
