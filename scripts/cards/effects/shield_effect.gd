class_name ShieldEffect extends CardEffect

@export var base_shield: int = 6


func apply(_card: Card, origin: Character, _targets: Array[Variant]):
    origin.health.add_shield(base_shield)

func get_description() -> String:
    return tr("Añade %s de escudo" % base_shield)
