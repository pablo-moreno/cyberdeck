class_name SceneTransition extends ColorRect


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func init_transition() -> void:
    animation_player.play("dissolve")


func finish_transition():
    animation_player.play_backwards("dissolve")
