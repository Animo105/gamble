extends Node


var upgrades : Array[Upgrade] = [
	Upgrade.new(0, "Monetary Deflation 1", "Coins slot give more money.", 200, coin_value_upgrade),
	Upgrade.new(1, "Monetary Deflation 2", "Coins slot give more money.", 400, coin_value_upgrade),
	Upgrade.new(2, "Monetary Deflation 3", "Coins slot give more money.", 600, coin_value_upgrade),
	Upgrade.new(3, "Monetary Deflation 4", "Coins slot give more money.", 800, coin_value_upgrade),
	Upgrade.new(4, "Monetary Deflation 5", "Coins slot give more money.", 1000, coin_value_upgrade),
	Upgrade.new(5, "Coins UP 1!", "Probability to have coins whent up.", 100, coin_probability_upgrade),
]

var upgrades_to_buy : Array[UpgradeButton] = []

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

func coin_value_upgrade():
	SlotsData.coins_bonus_value += 100
