class_name HealEffect extends CardEffect


@export var base_healing: int = 6


func apply(card: Card, origin: Character, targets: Array[Variant]):
    origin.health.heal(base_healing)

func get_description() -> String:
    return tr("Cura %s" % base_healing)
