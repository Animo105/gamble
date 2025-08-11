extends Control

@onready var blue_capsules: Button = $"CenterContainer/VBoxContainer/blue capsules"
@onready var pink_capsules: Button = $"CenterContainer/VBoxContainer/pink capsules"

@onready var yellow_capsules: Button = $"CenterContainer/VBoxContainer/yellow capsules"

func _ready() -> void:
	update_buttons()

func update_buttons():
	# blue capsule text
	if Global.capsules[1] > 0:
		blue_capsules.text = "%d Free Rolls" % Global.capsules[1]
	else:
		blue_capsules.text = "%d$ / Rolls" % Global.base_capsule_price
	# green capsule text
	if Global.capsules[2] > 0:
		pink_capsules.text = "%d Free Rolls" % Global.capsules[2]
	else:
		pink_capsules.text = "%d$ / Rolls" % (Global.base_capsule_price * 5)
	# yellow capsule text
	if Global.capsules[3] > 0:
		yellow_capsules.text = "%d Free Rolls" % Global.capsules[3]
	else:
		yellow_capsules.text = "%d$ / Rolls" % (Global.base_capsule_price * 10)


func _on_blue_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules[1] > 0:
		Global.capsules[1]-=1
	elif Global.money >= Global.base_capsule_price:
		Global.money -= Global.base_capsule_price
	else:
		return
	
	# GACHA TIME!!!
	print("GACHA!")
	update_buttons()


func _on_pink_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules[2] > 0:
		Global.capsules[2]-=1
	elif Global.money >= (Global.base_capsule_price * 5):
		Global.money -= (Global.base_capsule_price * 5)
	else:
		return
	
	# GACHA TIME!!!
	print("GACHA!")
	update_buttons()


func _on_yellow_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules[3] > 0:
		Global.capsules[3]-=1
	elif Global.money >= (Global.base_capsule_price*10):
		Global.money -= (Global.base_capsule_price*10)
	else:
		return
	
	# GACHA TIME!!!
	print("GACHA!")
	update_buttons()
