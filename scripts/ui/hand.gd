class_name Hand extends ColorRect

@export var hand_curve: Curve
@export var rotation_curve: Curve

@export var max_rotation_degrees := 10
@export var x_sep := 5
@export var y_min := 5
@export var y_max := -5

@export var hand_pile: Pile = null
const CARD_UI = preload("res://scenes/ui/card_ui.tscn")

var _current_cards: int = 0


func _ready() -> void:
    Globals.remove_from_hand.connect(_on_remove_from_hand)
    Globals.drawn_card.connect(_on_drawn_card)


func draw(new_card: CardUI) -> void:
    _current_cards += 1
    add_child(new_card)
    update_cards()


func update_cards() -> void:
    var cards := _current_cards
    var all_cards_size := Card.SIZE.x * cards + x_sep * (cards - 1)
    var final_x_sep = x_sep

    if all_cards_size > size.x:
        final_x_sep = (size.x - Card.SIZE.x * cards) / (cards - 1)
        all_cards_size = size.x

    var offset := (size.x - all_cards_size) / 2

    for i in cards:
        var card: CardUI = get_child(i)
        
        var y_multiplier := hand_curve.sample(1.0 / (cards - 1) * i)
        var rot_multiplier := rotation_curve.sample(1.0 / (cards - 1) * i)

        if cards == 1:
            y_multiplier = 0.0
            rot_multiplier = 0.0

        var final_x: float = offset + Card.SIZE.x * i + final_x_sep * i
        var final_y: float = y_min + y_max * y_multiplier
        
        card.position = Vector2(final_x, final_y)
        card.rotation_degrees = max_rotation_degrees * rot_multiplier


#region Signal handlers
func _on_drawn_card(card: Card):
    var card_ui = CARD_UI.instantiate()
    card_ui.set_card(card)
    draw(card_ui)


func _on_remove_from_hand(card: CardUI) -> void:
    _current_cards -= 1
    if get_child_count() < 1:
        return

    var parent := card.get_parent()

    if parent == null:
        card.queue_free()
    else:
        card.reparent(get_tree().root)

    card.queue_free()
    update_cards()

#endregion
