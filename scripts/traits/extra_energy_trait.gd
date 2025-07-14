class_name ExtraEnergyTrait
extends Trait


func apply(target: Character):
    target.set_max_energy(target.default_max_energy + 1)
