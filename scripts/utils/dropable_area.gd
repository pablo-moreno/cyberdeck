class_name DropableCardArea extends Control



func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
    if data is Card:
        if data.energy > GlobalSignals.energy_remaining:
            return false
        
        return true
    return false

func _drop_data(at_position: Vector2, card: Variant) -> void:
    var parent = get_parent()
    
    if card is Card:
        card.play_card.emit([parent])
