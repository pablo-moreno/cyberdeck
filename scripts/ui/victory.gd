class_name VictoryUI extends Container


@onready var lose_label = $Panel/LoseLabel
@onready var win_label = $Panel/WinLabel


func set_victory():
    mouse_filter = Control.MOUSE_FILTER_STOP
    visible = true
    win_label.visible = true
    lose_label.visible = false


func set_defeat():
    mouse_filter = Control.MOUSE_FILTER_STOP
    visible = true
    win_label.visible = false
    lose_label.visible = true
