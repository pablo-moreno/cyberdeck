class_name ExtraEnergyTrait extends Trait


func _set_initial_values():
    type = Trait.TYPE.BATTLE


func apply(target: Character):
    super(target)
    target.set_max_energy(target.default_max_energy + 1)


func get_description():
    return tr("Gana 1 de energía al principio del turno")
