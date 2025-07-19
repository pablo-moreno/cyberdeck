class_name HealEffect extends CardEffect


@export var base_healing: int = 6


func apply(_card: Card, origin: Character, _targets: Array[Variant]):
    origin.health.heal(base_healing)

func get_description() -> String:
    return tr("Cura %s" % base_healing)
