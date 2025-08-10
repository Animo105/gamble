extends Node


var upgrades : Array[Upgrade] = [
	Upgrade.new(0, "Monetary Deflation 1", "Coins slot give more money.", 200, coin_value_upgrade),
	Upgrade.new(1, "Monetary Deflation 2", "Coins slot give more money.", 400, coin_value_upgrade),
	Upgrade.new(2, "Monetary Deflation 3", "Coins slot give more money.", 600, coin_value_upgrade),
	Upgrade.new(3, "Monetary Deflation 4", "Coins slot give more money.", 800, coin_value_upgrade),
	Upgrade.new(4, "Monetary Deflation 5", "Coins slot give more money.", 1000, coin_value_upgrade),
	Upgrade.new(5, "Coins UP 1!", "Probability to have coins whent up.", 100, coin_probability_upgrade),
	Upgrade.new(6, "Coins UP 2!", "Probability to have coins whent up.", 500, coin_probability_upgrade),
	Upgrade.new(7, "Coins UP 3!", "Probability to have coins whent up.", 1000, coin_probability_upgrade),
	Upgrade.new(8, "GOING ALL IN!", "Allow to bet larger sums of money.", 1000, func():Global.is_bet_allowed = true),
	Upgrade.new(9, "Lucky Timing", "Boost the chance of winning.", 1000, chance_up),
	Upgrade.new(10, "Pin-Point Accuracy", "Boost the chance of winning.", 1000, chance_up),
	Upgrade.new(11, "Daily Portion of Fruits", "Probability to have fruits goes up.", 300, fruits_probability_upgrade),
	Upgrade.new(12, "Cherry on the Sunday", "Probability to have fruits goes up.", 600, fruits_probability_upgrade),
	Upgrade.new(13, "Making Fruit Salad", "Probability to have fruits goes up.", 900, fruits_probability_upgrade),
	Upgrade.new(14, "Fruit Connoisseurs", "Probability to have fruits goes up.", 1500, fruits_probability_upgrade),
	Upgrade.new(15, "Time is Money 1", "Makes the slot machine roll faster.", 1000, speed_upgrade),
	Upgrade.new(15, "Time is Money 2", "Makes the slot machine roll faster.", 2000, speed_upgrade),
]

var upgrades_to_buy : Array[Upgrade] = []

func update_array_to_buy():
	upgrades_to_buy.clear()
	for upgrade in upgrades:
		if Global.upgrades_bought.has(upgrade.id):
			continue
		else:
			upgrades_to_buy.append(upgrade)
	upgrades_to_buy.sort_custom(func(a, b):return a.cost < b.cost)

func apply_upgrades_by_id(array : Array[int]):
	for i in array:
		upgrades[i].apply.call()

func _ready() -> void:
	for upgrade in upgrades:
		upgrades_to_buy.append(upgrade)
	upgrades_to_buy.sort_custom(func(a, b):return a.cost < b.cost)
	
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
	SlotsData.slots[1].weight += 1
	SlotsData.slots[2].weight += 0.5

func fruits_probability_upgrade():
	SlotsData.slots[6].weight += 0.25
	SlotsData.slots[7].weight += 0.5
	SlotsData.slots[8].weight += 0.75
	SlotsData.slots[9].weight += 0.75

func coin_value_upgrade():
	SlotsData.coins_bonus_value += 100

func chance_up():
	Global.luck_probability += 1

func speed_upgrade():
	Global.slot_wait_time -= 0.25
	print(Global.slot_wait_time)
