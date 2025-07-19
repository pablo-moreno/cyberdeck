class_name ShieldAction extends Action

@export_range(0, 32) var base_shield: int = 5


func run(player: Character, enemy: Enemy):
    super(player, enemy)
    enemy.health.add_shield(base_shield)
