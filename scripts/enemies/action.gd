class_name Action extends Control


enum TYPE {
    ATTACK,
    SKILL,
    POWER,
}

@export var type: TYPE = TYPE.ATTACK
@onready var icon: Sprite2D = $Icon


func run(player: Character, enemy: Enemy):
    pass
