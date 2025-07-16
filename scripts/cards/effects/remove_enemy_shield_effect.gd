class_name RemoveEnemyShieldEffect extends CardEffect


func apply(card: Card, origin: Character, targets: Array[Variant]):
    for target in targets:
        target.health.reset_shield()

func get_description():
    return tr("Elimina el escudo")
