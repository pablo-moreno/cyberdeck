class_name Draggable extends Control

signal dragging


func _notification(notification_type):
    match notification_type:
        NOTIFICATION_DRAG_END:
            visible = true


func _on_dragging():
    visible = false


func _edit_preview_node(node: Draggable):
    pass


func _get_drag_data(_at_position: Vector2) -> Variant:
    var prev = duplicate()
    _edit_preview_node(prev)
    set_drag_preview(prev)
    dragging.emit()
    return self
