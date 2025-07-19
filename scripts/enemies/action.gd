class_name Action extends Control


enum TYPE {
    ATTACK,
    SKILL,
    POWER,
}

@export var type: TYPE = TYPE.ATTACK
@export var texture: CompressedTexture2D = null
@export var animation_name: String = 'shoot'
@export var sound_effect: AudioStreamMP3 = null


@onready var icon: Sprite2D = $Icon


func run(_player: Character, _enemy: Enemy):
    _enemy.play_sound_effect(sound_effect)
    _enemy.animate_action.emit(animation_name)
