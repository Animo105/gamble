extends Node

const SAVE_PATH : String = "user://data.json"
const TEMP_PATH : String = "user://data.tmp"
const BACKUP_PATH : String = "user://data.bak"

func _ready() -> void:
	load_data()

func save_data():
	var save_dic : Dictionary = {}
	save_dic["money"] = Global.money
	save_dic["bet amount"] = Global.bet_ammount
	save_dic["upgrades"] = Global.upgrades_bought
	save_dic["capsules"] = Global.capsules
	save_dic["level"] = Global.level
	save_dic["exp"] = Global.experience
	save_dic["items"] = Global.items_won
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_dic))
		file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		print("no data found, saving")
		# check for backup, is not, save
		save_data()
	else:
		var data : String
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			data = file.get_as_text()
			file.close()
			var save_dic : Dictionary= JSON.parse_string(data)
			print(save_dic)
			# load
			
			# load money
			if save_dic.has("money"): Global.money = save_dic["money"]
			# load le bet amount
			if save_dic.has("bet amount"): Global.bet_ammount = save_dic["bet amount"]
			# load les upgrades acheté
			if save_dic.has("upgrades"):
				if save_dic["upgrades"] is Dictionary:
					for upgrade in save_dic["upgrades"].keys():
						Global.upgrades_bought[int(upgrade)] = int(save_dic["upgrades"][upgrade])
					UpgradesData.apply_upgrades_bought()
			# load les objects gagné
			if save_dic.has("items"):
				for key in save_dic["items"].keys():
					Global.items_won[int(key)] = int(save_dic["items"][key])
					GachasData.apply_item_won()
			# load le nombre de capsules
			if save_dic.has("capsules"):
				if save_dic["capsules"] is Dictionary:
					for key in save_dic["capsules"]:
						Global.capsules[int(key)] = int(save_dic["capsules"][key])
			# laod les niveaux et l'exp
			if save_dic.has("level"):
				for i in range(save_dic["level"]):
					Global.level_up()
			if save_dic.has("exp"): Global.experience = save_dic["exp"]
			
			
func reset_data():
	if DirAccess.remove_absolute(SAVE_PATH) == OK:
		print("data reseted")
