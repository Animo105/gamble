extends Control

@onready var blue_capsules: Button = $"CenterContainer/VBoxContainer/blue capsules"
@onready var pink_capsules: Button = $"CenterContainer/VBoxContainer/pink capsules"
@onready var yellow_capsules: Button = $"CenterContainer/VBoxContainer/yellow capsules"
@onready var gacha_prize: GachaPrize = $"Gacha Prize"
@onready var exp_prize: Control = $"Exp Prize"

@onready var collection_panel: Panel = $"collection panel"
@onready var prize_container: GridContainer = $"collection panel/ScrollContainer/GridContainer"

const GACHA_PRIZE = preload("res://Gacha Machine/gacha_prize.tscn")

func _ready() -> void:
	update_buttons()
	collection_panel.visible = false
	exp_prize.visible = false
	gacha_prize.visible = false

func _update_collection():
	# empty container
	for child in prize_container.get_children():
		child.queue_free()
	# refil container
	for key in Global.items_won.keys():
		var prize_showcase_instance : GachaPrize = GACHA_PRIZE.instantiate()
		prize_container.add_child(prize_showcase_instance)
		prize_showcase_instance.update(GachasData.get_item_by_id(key))

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
	update_buttons()
	# GACHA TIME!!!
	roll(0)


func _on_pink_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules[2] > 0:
		Global.capsules[2]-=1
	elif Global.money >= (Global.base_capsule_price * 5):
		Global.money -= (Global.base_capsule_price * 5)
	else:
		return
	update_buttons()
	# GACHA TIME!!!
	roll(1)


func _on_yellow_capsules_pressed() -> void:
	# check si assez de rolls ou d'argent
	if Global.capsules[3] > 0:
		Global.capsules[3]-=1
	elif Global.money >= (Global.base_capsule_price*10):
		Global.money -= (Global.base_capsule_price*10)
	else:
		return
	update_buttons()
	# GACHA TIME!!!
	roll(2)

func roll(idx : int):
	collection_panel.visible = false
	var prize : GachasData.Prize = GachasData.gachas[idx].roll()
	if prize == null:
		gacha_prize.visible = false
		exp_prize.visible = true
		$"Exp Prize/Panel/Label".text = str(GachasData.gachas[idx].exp_prize)
		Global.experience += GachasData.gachas[idx].exp_prize
	else:
		exp_prize.visible = false
		gacha_prize.visible = true
		gacha_prize.update(prize)

func _on_collection_pressed() -> void:
	if collection_panel.visible:
		collection_panel.visible = false
	else:
		exp_prize.visible = false
		gacha_prize.visible = false
		collection_panel.visible = true
		_update_collection()
