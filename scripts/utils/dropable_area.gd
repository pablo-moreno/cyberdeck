class_name DropableCardArea extends Control

signal dragging_over
signal not_dragging


@export var target_type: Globals.TargetType = Globals.TargetType.ENEMY


func _ready() -> void:
    mouse_exited.connect(_on_mouse_exited)
    dragging_over.connect(_on_dragging_over)
    not_dragging.connect(_on_end_dragging)


func get_targets():
    return [get_parent()]


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
    if data is not CardUI:
        return false
    
    var card_ui: CardUI = data
    var _card: Card = card_ui.get_card()

    if _card.target_type != target_type:
        return false
    
    dragging_over.emit()
    return true


func _drop_data(_at_position: Vector2, card: Variant) -> void:
    var targets = get_targets()

    if card is CardUI:
        card.get_card().play_card.emit(targets)

    not_dragging.emit()


func _on_mouse_exited():
    not_dragging.emit()


func _on_dragging_over():
    pass


func _on_end_dragging():
    pass


func _gui_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if not event.pressed:
                not_dragging.emit()
