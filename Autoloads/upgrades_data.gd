extends Node


var upgrades : Array = [
	Upgrade.new(1, "Coins UP!", "Probability to have coins whent up.", 100, coin_probability_upgrade) 
	
]

class Upgrade:
	
	var id : int
	var nom : String
	var description : String
	var cost : int
	var apply : Callable
	
	func _init(upgrade_id: int, upgrade_name : String, upgrade_description : String, upgrade_cost : int, upgrade_apply : Callable) -> void:
		id = upgrade_id
		nom = upgrade_name
		description = upgrade_description
		cost = upgrade_cost
		apply = upgrade_apply

func coin_probability_upgrade():
	SlotsData.slots[1].weight += 5
