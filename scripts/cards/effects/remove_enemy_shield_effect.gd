class_name RemoveEnemyShieldEffect extends CardEffect


func apply(_card: Card, _origin: Character, targets: Array[Variant]):
    for target in targets:
        target.health.reset_shield()

func get_description() -> String:
    return tr("Elimina el escudo")
