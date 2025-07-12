class_name Dice extends Node


@export var sides: int = 20


func _ready() -> void:
    pass


func roll(modifier: int = 0):
    """
    Roll a die with a modifier
    :param modifier: Amount to add to the value of the dice
    :return:
        - Value
        - Value with modifier
        - Is critical success
        - Is critical failure
    """
    var value = randi_range(1, sides)

    # Critical failure
    if value == 1:
        return [value, value, false, true]

    # Critical success
    if value == self.sides:
        return [value, (value + modifier) * 2, true, false]

    return [value, value + modifier, false, false]
