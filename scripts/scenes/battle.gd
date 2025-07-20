extends Node2D

#region Nodes
@onready var player: Character = $Player
@onready var hand: Hand = $Hand
@onready var turn_manager: TurnManager = $TurnManager
@onready var discard_counter: Label = $UI/DiscardPileIcon/DiscardCounter
@onready var draw_counter: Label = $UI/DrawPileIcon/DrawCounter
@onready var energy_ui: EnergyUI = $UI/EnergyUI
@onready var enemies_parent: Node = $Enemies
@onready var victory_ui: VictoryUI = $VictoryUI
@onready var end_turn_button: Button = $UI/EndTurnButton
@onready var pile_modal_animation_player: AnimationPlayer = $PileModalAnimationPlayer
@onready var pile_modal: PileModal = $UI/PileModal
#endregion

const CARD_UI = preload("res://scenes/ui/card_ui.tscn")


func _ready() -> void:
    _setup()
    Globals.discard_card.connect(_on_card_discarded)
    Globals.drawn_card.connect(_on_drawn_card)
    draw_counter.text = str(player.draw_pile.get_child_count())
    discard_counter.text = str(player.discard_pile.get_child_count())
    energy_ui.set_current_energy(player.current_energy)
    energy_ui.set_max_energy(player.max_energy)


func _setup():
    for child in enemies_parent.get_children():
        if child is Enemy:
            turn_manager.add_enemy(child)
            child.set_player(player)

    turn_manager.init()


#region Signals
func _on_round_started():
    player.start_turn()


func _on_round_ended():
    end_turn_button.disabled = false


func _on_no_enemies_left():
    victory_ui.set_victory()


func _on_turn_manager_turn_start(_character: Character) -> void:
    player.start_turn()


func _on_player_ended_player_turn() -> void:
    player.discard_all_hand()


func _on_end_turn_pressed() -> void:
    turn_manager.player_turn_ended.emit()
    end_turn_button.disabled = true


func _on_card_discarded(_card: Card):
    draw_counter.text = str(player.draw_pile.get_child_count())
    discard_counter.text = str(player.discard_pile.get_child_count())

func _on_drawn_card(_card: Card):
    draw_counter.text = str(player.draw_pile.get_child_count())
    discard_counter.text = str(player.discard_pile.get_child_count())


func _on_player_current_energy_changed(value: int) -> void:
    energy_ui.set_current_energy(value)


func _on_player_max_energy_changed(value: int) -> void:
    energy_ui.set_max_energy(value)


func _on_player_dead() -> void:
    victory_ui.set_defeat()


func _on_discard_button_pressed() -> void:
    pile_modal.pile_ref = player.discard_pile
    pile_modal.pile_name = tr('Descarte')
    pile_modal.update()
    pile_modal_animation_player.play("display")


func _on_pile_modal_close() -> void:
    pile_modal_animation_player.play("hide")


func _on_draw_button_pressed() -> void:
    pile_modal.pile_ref = player.draw_pile
    pile_modal.pile_name = tr('Robo')
    pile_modal.update()
    pile_modal_animation_player.play("display")

#endregion


func _on_button_pressed() -> void:
    hand._update_cards()
