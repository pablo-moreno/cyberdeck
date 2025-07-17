class_name DamageIndicator extends Control

@onready var damage_animation_player: AnimationPlayer = $DamageAnimationPlayer
@onready var shield_animation_player: AnimationPlayer = $ShieldAnimationPlayer
@onready var heal_animation_player: AnimationPlayer = $HealAnimationPlayer

@onready var damage_label: Label = $DamageLabel
@onready var shield_label: Label = $ShieldLabel
@onready var heal_label: Label = $HealLabel


func _ready():
    var _health: Health = owner.find_child("Health")
    damage_label.visible = false
    shield_label.visible = false
    heal_label.visible = false

    if not _health:
        printerr("Health node not found")
        return

    _health.damaged.connect(_on_damaged)
    _health.shielded_damage.connect(_on_shielded)
    _health.healed.connect(_on_healed)


func _on_damaged(amount: int):
    damage_label.text = str(amount)
    damage_animation_player.play("damage")


func _on_shielded(amount: int):
    shield_label.text = str(amount)
    shield_animation_player.play("shield")

func _on_healed(amount: int):
    heal_label.text = str(amount)
    heal_animation_player.play("heal")
