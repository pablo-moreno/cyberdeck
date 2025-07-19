class_name DrawCardEffect extends CardEffect


@export var amount_to_draw: int = 1


func apply(card: Card, origin: Character, targets: Array[Variant]):
    origin.draw_cards(amount_to_draw)


func get_description() -> String:
    return tr_n("Roba %d carta", "Roba %d cartas", amount_to_draw) % amount_to_draw
