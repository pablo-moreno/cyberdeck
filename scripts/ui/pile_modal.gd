class_name PileModal extends PanelContainer


@export var pile_name: String = 'hand'
@export var pile_ref: Pile = null
@onready var scale_vector: Vector2 = Vector2(3, 3)

@onready var grid_container: GridContainer = %GridContainer
@onready var pile_name_label: Label = %PileNameLabel


signal close


const CARD_UI = preload("res://scenes/ui/card_ui.tscn")


func _ready() -> void:
    pass


func update():
    pile_name_label.text = pile_name
    
    for child in grid_container.get_children():
        grid_container.remove_child(child)

    var cards = pile_ref.get_all_cards(false)

    for card in cards:
        var card_ui: CardUI = CARD_UI.instantiate()
        card_ui.set_card(card)
        card_ui.set_not_draggable()
        card_ui.read_only = true
        card_ui.scale = scale_vector
        grid_container.add_child(card_ui)


func _on_close_button_pressed() -> void:
    close.emit()
