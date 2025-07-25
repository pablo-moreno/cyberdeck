class_name PopupIcon extends TextureRect

@onready var popup_panel: PopupPanel = $PopupPanel
@onready var label: Label = $PopupPanel/Label

@export var text: String = ''


func _ready():
    label.text = text


func _on_mouse_entered() -> void:
    popup_panel.visible = true


func _on_mouse_exited() -> void:
    popup_panel.visible = false
