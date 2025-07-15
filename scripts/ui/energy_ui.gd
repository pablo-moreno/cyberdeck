class_name EnergyUI extends Control

@onready var current_energy_label: Label = $CurrentEnergyLabel
@onready var max_energy_label: Label = $MaxEnergyLabel


func _ready() -> void:
    pass


func set_current_energy(amount: int):
    current_energy_label.text = str(amount)


func set_max_energy(amount: int):
    max_energy_label.text = str(amount)
