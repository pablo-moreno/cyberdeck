class_name MainMenu extends PanelContainer


var BATTLE_SCENE = preload("res://scenes/battle.tscn")


func _on_new_game_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/battle.tscn")


func _on_exit_button_pressed() -> void:
    get_tree().quit()
