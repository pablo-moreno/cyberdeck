class_name FiniteStateMachine extends Node

signal state_changed(new_state: State)
@export var state: State = null

func _ready():
    change_state(state)

func change_state(new_state: State):
    if state is State:
        state._exit_state()
    new_state._enter_state()
    state = new_state
    state_changed.emit(new_state)
