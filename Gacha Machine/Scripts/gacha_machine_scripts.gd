extends Control

@onready var blue_capsules: Button = $"CenterContainer/VBoxContainer/blue capsules"
@onready var green_capsules: Button = $"CenterContainer/VBoxContainer/green capsules"
@onready var yellow_capsules: Button = $"CenterContainer/VBoxContainer/yellow capsules"

func _ready() -> void:
	update_buttons()

func update_buttons():
	# blue capsule text
	if Global.capsules["blue"] > 0:
		blue_capsules.text = "%d Free Rolls" % Global.capsules["blue"]
	else:
		blue_capsules.text = "%d$ / Rolls" % Global.base_capsule_price
	# green capsule text
	if Global.capsules["green"] > 0:
		green_capsules.text = "%d Free Rolls" % Global.capsules["green"]
	else:
		green_capsules.text = "%d$ / Rolls" % (Global.base_capsule_price * 5)
	# yellow capsule text
	if Global.capsules["yellow"] > 0:
		yellow_capsules.text = "%d Free Rolls" % Global.capsules["yellow"]
	else:
		yellow_capsules.text = "%d$ / Rolls" % (Global.base_capsule_price * 10)


func _on_blue_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules["blue"] > 0:
		Global.capsules["blue"]-=1
	elif Global.money >= Global.base_capsule_price:
		Global.money -= Global.base_capsule_price
	else:
		return
	
	# GACHA TIME!!!
	print("GACHA!")
	update_buttons()


func _on_green_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules["green"] > 0:
		Global.capsules["green"]-=1
	elif Global.money >= (Global.base_capsule_price * 5):
		Global.money -= (Global.base_capsule_price * 5)
	else:
		return
	
	# GACHA TIME!!!
	print("GACHA!")
	update_buttons()


func _on_yellow_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules["yellow"] > 0:
		Global.capsules["yellow"]-=1
	elif Global.money >= (Global.base_capsule_price*10):
		Global.money -= (Global.base_capsule_price*10)
	else:
		return
	
	# GACHA TIME!!!
	print("GACHA!")
	update_buttons()
