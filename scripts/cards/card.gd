class_name Card extends Node


enum CARD_TYPE {
    BASE,
    PURPLE,
    GOLD,
}

@export var card_name: String = ''
@export var is_exhaust: bool = false
@export_range(0, 9) var energy: int = 3

@export var type: CARD_TYPE = CARD_TYPE.BASE
@export var target_type: Globals.TargetType = Globals.TargetType.ENEMY
@export var animation_name: String = 'attack'
@export var sound_effect: AudioStreamMP3 = null


const SIZE: Vector2 = Vector2(48, 64)

var _player: Character = null

signal play_card(targets: Variant)
signal cannot_play_card(card: Card)


func _ready() -> void:
    play_card.connect(play)


func set_player(player: Character):
    _player = player


func discard():
    Globals.discard_card.emit(self)


func get_effects() -> Array[CardEffect]:
    var effects: Array[CardEffect] = []
    var children = get_children()
    
    for child in children:
        if child is CardEffect:
            effects.append(child)

    return effects


func play(targets: Array[Variant]) -> bool:
    if energy > _player.current_energy:
        cannot_play_card.emit(self)
        return false

    _player.sprite.play(animation_name)
    _player.spend_energy(energy)
    _player.play_sound_effect(sound_effect)

    for effect in get_effects():
        effect.apply(self, _player, targets)
    
    if is_exhaust:
        Globals.exhaust_card.emit(self)
    else:
        Globals.discard_card.emit(self)

    return is_exhaust


func move_to(target: Pile, copy: bool = false):
    if copy:
        var new_card = duplicate()
        new_card.set_player(_player)
        add_child(new_card)
        new_card.reparent(target)
    else:
        reparent(target)

    Globals.card_changed_pile.emit(self, target)


func get_card_name():
    return tr(card_name)


func get_description():
    var description: String = ''

    for effect in get_effects():
        description += effect.get_description() + "\n"

    return description
