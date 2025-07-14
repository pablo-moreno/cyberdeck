class_name ProgressHealthBar
extends ProgressBar


func _ready():
    var _health: Health = owner.find_child("Health")
    
    if not _health:
        printerr("Health node not found")
        return
    
    _health.change_health.connect(_on_health_change_health)
    _health.change_max_health.connect(_on_health_change_max_health)

    value = _health.health
    max_value = _health.current_max_health


func _on_health_change_health(new_health: int):
    value = new_health


func _on_health_change_max_health(new_max_health: int):
    max_value = new_max_health
