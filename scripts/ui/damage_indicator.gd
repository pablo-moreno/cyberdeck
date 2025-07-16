class_name DamageIndicator extends Control


@onready var damage_label: Label = $Path2D/DamagePathFollow2D/DamageLabel
@onready var shield_label: Label = $Path2D2/ShieldPathFollow2D/ShieldLabel

@onready var damage_path_follow: PathFollow2D = $Path2D/DamagePathFollow2D
@onready var shield_path_follow: PathFollow2D = $Path2D2/ShieldPathFollow2D

@export_range(0.1, 2) var animation_time: float = 0.25


func _ready():
    var _health: Health = owner.find_child("Health")
    
    if not _health:
        printerr("Health node not found")
        return
    
    _health.damaged.connect(_on_damaged)
    _health.shielded_damage.connect(_on_shielded)
    damage_label.text = ''
    shield_label.text = ''


func _reset_damage_label():
    damage_label.text = ''
    damage_path_follow.progress_ratio = 0


func _on_damaged(amount: int):
    damage_label.text = str(amount)
    var _tween = create_tween()
    _tween.tween_property(damage_path_follow, "progress_ratio", 1, animation_time).set_ease(Tween.EASE_IN)
    await _tween.finished
    
    _reset_damage_label()

func _reset_shield_label():
    shield_label.text = ''
    shield_path_follow.progress_ratio = 0


func _on_shielded(amount: int):
    shield_label.text = str(amount)
    
    var _tween = create_tween()
    _tween.tween_property(shield_path_follow, "progress_ratio", 1, animation_time)
    _tween.finished.connect(_reset_shield_label)
