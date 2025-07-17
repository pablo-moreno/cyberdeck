class_name DamageIndicator extends Control

@onready var damage_animation_player: AnimationPlayer = $DamageAnimationPlayer
@onready var shield_animation_player: AnimationPlayer = $ShieldAnimationPlayer

@onready var damage_label: Label = $DamageLabel
@onready var shield_label: Label = $ShieldLabel


func _ready():
    var _health: Health = owner.find_child("Health")
    damage_label.visible = false
    shield_label.visible = false

    if not _health:
        printerr("Health node not found")
        return

    _health.damaged.connect(_on_damaged)
    _health.shielded_damage.connect(_on_shielded)


func _on_damaged(amount: int):
    damage_label.text = str(amount)
    damage_animation_player.play("damage")


func _on_shielded(amount: int):
    shield_label.text = str(amount)
    shield_animation_player.play("shield")
