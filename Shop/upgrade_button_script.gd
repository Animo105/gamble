extends Control
class_name UpgradeButton

var upgrade_id : int = 0
var upgrade_cost : int = 0

func _ready() -> void:
	$cost.text = "%d$" % upgrade_cost
	$"upgrade name".text = UpgradesData.upgrades[upgrade_id].nom
	$"upgrade desc".text = UpgradesData.upgrades[upgrade_id].description
	pass

func _on_button_pressed() -> void:
	if Global.money < upgrade_cost:
		return
	
	Global.money -= upgrade_cost
	Global.upgrades_bought.append(upgrade_id)
	UpgradesData.upgrades_to_buy.erase(UpgradesData.upgrades[upgrade_id])
	UpgradesData.upgrades[upgrade_id].apply.call()
	queue_free()
