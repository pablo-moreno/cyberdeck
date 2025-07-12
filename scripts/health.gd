"""
This class handles everything about health management.
"""
class_name Health extends Node

# Properties variables

@export var health = 100
@export var current_max_health = 100

# Signals

## Emitted when the health is lowered to 0
signal death

## Emitted when health is changed
signal change_health(new_health: int)

## Emitted when max health is changed
signal change_max_health(new_max_health: int)

## Emitted when damage has been taken
signal damaged(amount: int)

## Emitted after healing
signal healed

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
    health = max(health - amount, 0)
    change_health.emit(health)
    damaged.emit(amount)

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


func increase_max_health(amount: int) -> void:
    """
    Handles maximum health increment
    
    Emits: 
        - change_max_health
    """
    current_max_health += amount
    change_max_health.emit(current_max_health)
