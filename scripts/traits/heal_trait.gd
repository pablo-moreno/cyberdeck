class_name HealTrait extends Trait


@export var amount: int = 6


func apply(target: Character):
    target.health.heal(amount)
