class_name AllTargetsDropableArea extends DropableCardArea


@export var modulate_color: Color = Color(Color.WHITE, 0.3)
var _targets: Array[Variant] = []


func _ready() -> void:
    super()
    target_type = Globals.TargetType.ALL_ENEMIES
    _hide()


func set_targets(new_targets: Array[Variant]):
    _targets = new_targets


func get_targets() -> Array[Variant]:
    return _targets


func _hide():
    modulate = Color(Color.WHITE, 0)
    mouse_filter = Control.MOUSE_FILTER_IGNORE


func remove_target(target: Variant):
    var current_targets: Array[Node] = get_targets()
    var enemy_index = current_targets.find(target)
    current_targets.remove_at(enemy_index)
    set_targets(current_targets)


func _on_dragging_over():
    modulate = modulate_color
    mouse_filter = Control.MOUSE_FILTER_STOP


func _on_mouse_exited():
    super()
    _hide()


func _on_end_dragging():
    super()
    _hide()
