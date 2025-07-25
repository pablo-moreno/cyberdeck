class_name HealTrait extends Trait


@export var amount: int = 6


func can_apply(target: Character):
    return true


func apply(target: Character):
    super(target)
    target.health.heal(amount)
