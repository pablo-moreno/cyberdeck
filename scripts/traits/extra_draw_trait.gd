class_name ExtraDrawCard extends Trait


func _set_initial_values():
    type = Trait.TYPE.START_TURN


func apply(target: Character):
    super(target)
    
    target.draw_cards(1)

func get_description():
    return tr("Roba una carta extra")
