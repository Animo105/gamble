extends Node

var upgrades : Array[Upgrade] = []

var upgrades_to_buy : Array[Upgrade] = []

func apply_upgrades_bought():
	for key in Global.upgrades_bought.keys():
		for i in range(Global.upgrades_bought[key]):
			upgrades[key].apply()

func _ready() -> void:
	# load upgrade
	var file = FileAccess.open("res://Assets/JSON/upgrades.json", FileAccess.READ)
	if file:
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if !data is Array:
			push_error("Upgrades are not organized into an array")
			return
		for upgrade in data:
			# crée l'upgrde
			if !upgrade.has("id") : push_error("Upgrade without id : ", upgrade); continue
			if !upgrade.has("name") : push_error("Upgrade without name : ", upgrade); continue
			if !upgrade.has("description") : push_error("Upgrade without description : ", upgrade); continue
			if !upgrade.has("cost") : push_error("Upgrade without cost : ", upgrade); continue
			if !upgrade.has("expression") : push_error("Upgrade without expression : ", upgrade); continue
			var new_upgrade : Upgrade = Upgrade.new(upgrade["id"], upgrade["name"], upgrade["description"], upgrade["cost"], upgrade["expression"])
			if upgrade.has("max_upgrade"):
				new_upgrade.max_upgrade = upgrade["max_upgrade"]
			if upgrade.has("price_mult"):
				new_upgrade.price_multiplayer = upgrade["price_mult"]
			upgrades.append(new_upgrade)
			upgrades_to_buy.append(new_upgrade)
			
		# a la fin sort l'array de to_buy
		upgrades_to_buy.sort_custom(func(a, b):return a.cost < b.cost)
	else:
		push_error("Can't find upgrades")
		return
	
	# update et trie l'array pour savoir quelles array afficher dans le shop
	
class Upgrade:
	
	var id : int
	var nom : String
	var description : String
	var max_upgrade : int = 1
	var level : int = 0
	var price_multiplayer : float = 1.5
	var cost : int
	var expression : String
	
	func _init(upgrade_id: int, upgrade_name : String, upgrade_description : String, upgrade_cost : int, upgrade_expression : String) -> void:
		id = upgrade_id
		nom = upgrade_name
		description = upgrade_description
		cost = upgrade_cost
		expression = upgrade_expression
	
	func apply():
		# create and execute expression
		var ex : Expression = Expression.new()
		var err = ex.parse(expression, ["func"])
		if err == OK:
			ex.execute([ExpressionFunction])
		else:
			push_error("Error in upgrade ", nom, " : ", ex.get_error_text())
		
		# update level
		level += 1
		if level == max_upgrade:
			UpgradesData.upgrades_to_buy.erase(self)
		else:
			@warning_ignore("narrowing_conversion")
			cost *= price_multiplayer
