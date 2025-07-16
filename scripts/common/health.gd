"""
This class handles everything about health management.
"""
class_name Health extends Node

#region Properties variables
@export var health = 100
@export var current_max_health = 100
@export var current_shield = 0
#endregion

#region Signals
## Emitted when the health is lowered to 0
signal death

## Emitted when health is changed
signal change_health(new_health: int)

## Emitted when shield is changed
signal changed_current_shield(new_shield: int)


signal shielded_damage(value: int)

## Emitted when max health is changed
signal change_max_health(new_max_health: int)

## Emitted when damage has been taken
signal damaged(amount: int)

## Emitted after healing
signal healed
#endregion

func _ready():
    change_health.emit(health)
    change_max_health.emit(current_max_health)


func take_damage(amount: int) -> void:
    """
    Handles taking damage
    
    Emits:
        - change_health
        - damaged
        - death
    """
    var initial_shield = current_shield
    var damage_without_shield = max(amount - current_shield, 0)
    current_shield = max(current_shield - amount, 0)
    changed_current_shield.emit(current_shield)
    
    if current_shield < initial_shield:
        shielded_damage.emit(initial_shield - current_shield)
    
    health = max(health - damage_without_shield, 0)
    change_health.emit(health)
    
    if damage_without_shield > 0:
        damaged.emit(damage_without_shield)

    if health == 0:
        death.emit()


func heal(amount: int) -> void:
    """
    Handles healing
    
    Emits: 
        - change_health
        - healed
    """
    health = min(health + amount, current_max_health)
    change_health.emit(health)
    healed.emit()


func add_shield(amount: int) -> void:
    current_shield += amount
    changed_current_shield.emit(current_shield)


func reset_shield() -> void:
    current_shield = 0
    changed_current_shield.emit(0)


func increase_max_health(amount: int) -> void:
    """
    Handles maximum health increment
    
    Emits: 
        - change_max_health
    """
    current_max_health += amount
    change_max_health.emit(current_max_health)
