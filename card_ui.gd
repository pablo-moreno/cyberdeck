class_name CardUI extends Panel


@export var _card: Card = null
@export_range(1.0, 1.5) var hover_transform = 1.25
@export_range(0, 24) var hover_up_pixels = 12

@onready var base_sprite: Sprite2D = $BaseCard
@onready var purple_sprite: Sprite2D = $PurpleCard
@onready var gold_sprite: Sprite2D = $GoldCard

@onready var title: Label = $TitleLabel
@onready var energy: Label = $EnergyLabel


func _ready() -> void:
    render_card()
    title.text = _card.card_name
    energy.text = str(_card.energy)


func render_card():
    if not _card:
        return

    if _card.type == Card.CARD_TYPE.BASE:
        base_sprite.visible = true
        purple_sprite.visible = false
        gold_sprite.visible = false
    elif _card.type == Card.CARD_TYPE.PURPLE:
        base_sprite.visible = false
        purple_sprite.visible = true
        gold_sprite.visible = false
    elif _card.type == Card.CARD_TYPE.GOLD:
        base_sprite.visible = false
        purple_sprite.visible = false
        gold_sprite.visible = true


func set_card(card: Card):
    _card = card
    _attach_signals()

func remove_card(card: Card):
    _card = null


func _attach_signals():
    _card.discarded.connect(remove_card)
    _card.exhausted.connect(remove_card)


func _on_mouse_entered() -> void:
    position.y = position.y - hover_up_pixels
    size = size * hover_transform
    z_index = 100


func _on_mouse_exited() -> void:
    position.y = position.y + hover_up_pixels
    size = size / hover_transform
    z_index = 0
