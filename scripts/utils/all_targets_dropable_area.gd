class_name AllTargetsDropableArea extends DropableCardArea

@export var modulate_color: Color = Color(Color.WHITE, 0.3)
var _targets: Array[Variant] = []

func _ready() -> void:
    super()
    target_type = Globals.TargetType.ALL_ENEMIES
    mouse_filter = Control.MOUSE_FILTER_IGNORE


func set_targets(new_targets: Array[Variant]):
    _targets = new_targets


func get_targets() -> Array[Variant]:
    return _targets


func _on_dragging_over():
    modulate = modulate_color
    mouse_filter = Control.MOUSE_FILTER_STOP


func _on_mouse_exited():
    super()
    modulate = Color(Color.WHITE, 0)
    mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_end_dragging():
    super()
    modulate = Color(Color.WHITE, 0)
    mouse_filter = Control.MOUSE_FILTER_IGNORE
