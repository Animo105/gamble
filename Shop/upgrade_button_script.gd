extends Control
class_name UpgradeButton

var upgrade_id : int = 0
var upgrade_cost : int = 0

func _ready() -> void:
	$"upgrade desc".text = UpgradesData.upgrades[upgrade_id].description
	update()

func update():
	if UpgradesData.upgrades[upgrade_id].level == UpgradesData.upgrades[upgrade_id].max_upgrade:
		queue_free()
	
	if UpgradesData.upgrades[upgrade_id].max_upgrade > 1:
		$"upgrade name".text = "%s %d" % [UpgradesData.upgrades[upgrade_id].nom, (UpgradesData.upgrades[upgrade_id].level+1)]
	else:
		$"upgrade name".text = UpgradesData.upgrades[upgrade_id].nom
	# update le cost
	upgrade_cost = UpgradesData.upgrades[upgrade_id].cost
	$cost.text = "%d$" % upgrade_cost

func _on_button_pressed() -> void:
	if Global.money >= upgrade_cost:
		Global.money-= upgrade_cost
		if Global.upgrades_bought.has(upgrade_id):
			Global.upgrades_bought[upgrade_id] += 1
		else:
			Global.upgrades_bought[upgrade_id] = 1
		UpgradesData.upgrades[upgrade_id].apply()
		update()
