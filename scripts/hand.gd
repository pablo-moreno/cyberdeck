class_name Hand
extends ColorRect

@export var hand_curve: Curve
@export var rotation_curve: Curve

@export var max_rotation_degrees := 10
@export var x_sep := 5
@export var y_min := 10
@export var y_max := -10

@export var hand_pile: Pile = null


func draw(new_card: CardUI) -> void:
    add_child(new_card)
    _update_cards()


func discard() -> void:
    if get_child_count() < 1:
        return

    var child := get_child(-1)
    child.reparent(get_tree().root)
    child.queue_free()
    _update_cards()


func _update_cards() -> void:
    var cards := get_child_count()
    var all_cards_size := Card.SIZE.x * cards + x_sep * (cards - 1)
    var final_x_sep = x_sep

    if all_cards_size > size.x:
        final_x_sep = (size.x - Card.SIZE.x * cards) / (cards - 1)
        all_cards_size = size.x

    var offset := (size.x - all_cards_size) / 2
    
    for i in cards:
        var card := get_child(i)
        var y_multiplier := hand_curve.sample(1.0 / (cards - 1) * i)
        var rot_multiplier := rotation_curve.sample(1.0 / (cards - 1) * i)
        
        if cards == 1:
            y_multiplier = 0.0
            rot_multiplier = 0.0
        
        var final_x: float = offset + Card.SIZE.x * i + final_x_sep * i
        var final_y: float = y_min + y_max * y_multiplier
        
        card.position = Vector2(final_x, final_y)
        card.rotation_degrees = max_rotation_degrees * rot_multiplier
