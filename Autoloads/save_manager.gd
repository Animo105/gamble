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
			if save_dic.has("money"): Global.money = save_dic["money"]
			if save_dic.has("bet amount"): Global.bet_ammount = save_dic["bet amount"]
			if save_dic.has("upgrades"):
				for upgrade in save_dic["upgrades"]:
					Global.upgrades_bought.append(int(upgrade))
				UpgradesData.update_array_to_buy()
				UpgradesData.apply_upgrades_by_id(Global.upgrades_bought)
			if save_dic.has("capsules"):
				for key in save_dic["capsules"]:
					Global.capsules[key] = int(save_dic["capsules"][key])

func reset_data():
	var save_dic : Dictionary = {}
	save_dic["money"] = 500
	save_dic["bet amount"] = 10
	save_dic["upgrades"] = []
	save_dic["capsules"] = {"blue":0, "green":0, "yellow":0}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_dic))
		file.close()
	print("data reseted")
