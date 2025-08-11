extends Control
class_name UpgradeButton

var upgrade_id : int = 0
var upgrade_cost : int = 0

func _ready() -> void:
	$"upgrade desc".text = UpgradesData.upgrades[upgrade_id].description
	update()

func update():
	if UpgradesData.upgrades[upgrade_id].max_upgrade > 1:
		if Global.upgrades_bought.has(upgrade_id):
			# si a buy toute les upgrades, enleve le boutton
			if Global.upgrades_bought[upgrade_id] >= UpgradesData.upgrades[upgrade_id].max_upgrade:
				queue_free()
				return
			$"upgrade name".text = "%s %d" % [UpgradesData.upgrades[upgrade_id].nom, (Global.upgrades_bought[upgrade_id]+1)]
		else:
			$"upgrade name".text = "%s %d" % [UpgradesData.upgrades[upgrade_id].nom, 1]
	else:
		$"upgrade name".text = UpgradesData.upgrades[upgrade_id].nom
	
	# update le cost
	upgrade_cost = UpgradesData.upgrades[upgrade_id].cost
	$cost.text = "%d$" % upgrade_cost

func _on_button_pressed() -> void:
	if Global.money >= upgrade_cost:
		Global.money-= upgrade_cost
		UpgradesData.upgrades[upgrade_id].apply()
		update()
