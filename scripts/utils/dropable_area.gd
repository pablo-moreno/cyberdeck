class_name DropableCardArea extends Control


signal dragging_over
signal not_dragging

var _is_mouse_over: bool = false


func _ready() -> void:
    mouse_exited.connect(_on_mouse_exited)


func _get_targets():
    return [get_parent()]


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
    dragging_over.emit()
    if data is CardUI:
        return true
    return false


func _drop_data(at_position: Vector2, card: Variant) -> void:
    var targets = _get_targets()

    if card is CardUI:
        card._card.play_card.emit(targets)
    not_dragging.emit()


func _on_mouse_exited():
    not_dragging.emit()


func _gui_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if not event.pressed:
                not_dragging.emit()
