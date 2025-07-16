class_name ShieldEffect extends CardEffect

@export var base_shield: int = 6


func apply(card: Card, origin: Character, targets: Array[Variant]):
    origin.health.add_shield(base_shield)

func get_description():
    return tr("Añade %s de escudo" % base_shield)
