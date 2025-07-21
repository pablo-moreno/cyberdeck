class_name MainMenu extends PanelContainer


var BATTLE_SCENE = preload("res://scenes/battle.tscn")

@onready var scene_transition: SceneTransition = $SceneTransition

func _ready() -> void:
    scene_transition.visible = true
    scene_transition.init_transition()
    await scene_transition.animation_player.animation_finished
    scene_transition.visible = false


func _on_new_game_button_pressed() -> void:
    scene_transition.visible = true
    scene_transition.finish_transition()
    await scene_transition.animation_player.animation_finished
    scene_transition.visible = false
    get_tree().change_scene_to_file("res://scenes/battle.tscn")


func _on_exit_button_pressed() -> void:
    get_tree().quit()
