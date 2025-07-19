class_name Draggable extends Panel

var _is_draggable = true

signal dragging


func set_not_draggable():
    _is_draggable = false
    mouse_default_cursor_shape = Control.CURSOR_ARROW


func _notification(notification_type):
    if not _is_draggable:
        return false
    
    match notification_type:
        NOTIFICATION_DRAG_END:
            visible = true


func _on_dragging():
    visible = false


func _edit_preview_node(_node: Draggable):
    pass


func _get_drag_data(_at_position: Vector2) -> Variant:
    if not _is_draggable:
        return

    var prev = duplicate()
    _edit_preview_node(prev)
    set_drag_preview(prev)
    dragging.emit()
    return self
