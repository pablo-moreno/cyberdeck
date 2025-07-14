class_name AttackAction extends Action


@export_range(0, 32) var base_damage: int = 5


func _get_damage_to_apply(player: Character) -> int:
    return base_damage


func run(player: Character, enemy: Enemy):
    print("al ataqueeeeerrrr")
    var damage = _get_damage_to_apply(player)
    player.health.take_damage(damage)
