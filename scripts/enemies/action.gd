class_name Action extends Control


enum TYPE {
    ATTACK,
    SKILL,
    POWER,
}

@export var type: TYPE = TYPE.ATTACK
@export var texture: CompressedTexture2D = null

@export var animation: String = 'get_damage'

@onready var icon: Sprite2D = $Icon


func run(_player: Character, _enemy: Enemy):
    pass
