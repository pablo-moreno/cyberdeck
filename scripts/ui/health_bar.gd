class_name ProgressHealthBar
extends TextureProgressBar

@onready var shield_label: Label = $ShieldLabel
@onready var shield_sprite: Sprite2D = $ShieldSprite

@onready var health_label: Label = $HealthLabel

var _health: Health = null


func _ready():
    _health = owner.find_child("Health")
    
    if not _health:
        printerr("Health node not found")
        return
    
    _health.change_health.connect(_on_health_change_health)
    _health.change_max_health.connect(_on_health_change_max_health)
    _health.changed_current_shield.connect(_on_health_changed_current_shield)

    value = _health.health
    max_value = _health.current_max_health
    _change_label_value(value, max_value)
    
    shield_label.visible = false
    shield_sprite.visible = false


func _change_label_value(current_health: int, max_health: int):
    health_label.text = str(current_health) + '/' + str(max_health)


func _on_health_change_health(new_health: int):
    value = new_health
    _change_label_value(_health.health, _health.current_max_health)


func _on_health_change_max_health(new_max_health: int):
    max_value = new_max_health
    _change_label_value(_health.health, _health.current_max_health)


func _on_health_changed_current_shield(shield: int):
    if shield > 0:
        shield_label.visible = true
        shield_sprite.visible = true
    else:
        shield_label.visible = false
        shield_sprite.visible = false
        
    shield_label.text = str(shield)
