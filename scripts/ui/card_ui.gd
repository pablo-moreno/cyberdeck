class_name CardUI extends Draggable


@export var _card: Card = null
@export_range(1.0, 1.5) var hover_transform = 1.25
@export_range(0, 8) var hover_up_pixels = 4
@export var read_only: bool = false

@export var base_texture: Texture2D = null
@export var purple_texture: Texture2D = null
@export var gold_texture: Texture2D = null

@onready var ui: Control = $UI
@onready var title_label: Label = $UI/MarginContainer/VBoxContainer/TitleLabel
@onready var description_label: Label = $UI/MarginContainer/VBoxContainer/DescriptionLabel
@onready var energy: Label = $UI/EnergyLabel
@onready var card_texture: TextureRect = $CardTexture


func _ready() -> void:
    render_card()
    dragging.connect(_on_dragging)


func set_card(card: Card):
    _card = card
    _attach_signals()


func get_card() -> Card:
    return _card


func remove_card(card: Card):
    if card != _card:
        return

    _card = null
    GlobalSignals.remove_from_hand.emit(self)


func _attach_signals():
    GlobalSignals.discard_card.connect(remove_card)
    GlobalSignals.exhaust_card.connect(remove_card)


func render_card():
    if read_only:
        mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
    else:
        mouse_default_cursor_shape = Control.CURSOR_DRAG

    if not _card:
        return

    title_label.text = _card.card_name
    description_label.text = _card.get_description()
    energy.text = str(_card.energy)

    if _card.type == Card.CARD_TYPE.BASE:
        card_texture.texture = base_texture
    elif _card.type == Card.CARD_TYPE.PURPLE:
        card_texture.texture = purple_texture
    elif _card.type == Card.CARD_TYPE.GOLD:
        card_texture.texture = gold_texture


func _on_mouse_entered() -> void:
    var up_pixels = hover_up_pixels
    if not read_only:
        up_pixels *= 3

    position.y = position.y - up_pixels
    size = size * hover_transform
    z_index = 100


func _on_mouse_exited() -> void:
    var up_pixels = hover_up_pixels
    if not read_only:
        up_pixels *= 3
    
    position.y = position.y + up_pixels
    size = size / hover_transform
    z_index = 0


func _edit_preview_node(node: Draggable):
    node.z_index = 100
