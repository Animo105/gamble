extends Node

var gachas : Array[Gacha] = []

func _ready() -> void:
	var file = FileAccess.open("res://Assets/JSON/gachas.json", FileAccess.READ)
	if file:
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if !data is Array:
			push_error("Gacha are not organized into an array")
			return
		if data.size() != 3:
			push_error("Number of Gacha object is not 3. size :", data.size())
			return
		for gacha in data:
			# load structure d'un objet gacha
			if !gacha.has("items"):push_error("Gacha don't have items"); continue
			if !gacha.has("waifus"):push_error("Gacha don't have waifus"); continue
			var new_gacha = Gacha.new()
			if !gacha.has("exp"):push_warning("Gacha don't containe exp value, defaulting to 1000")
			else: new_gacha.exp_prize = int(gacha["exp"])
			
			for item in gacha["items"]:
				# load structure d'un objet Item
				if !item.has("id") : push_error("item without id : ", item); continue
				if !item.has("name") : push_error("item without name : ", item); continue
				if !item.has("description") : push_error("item without description : ", item); continue
				if !item.has("texture") : push_error("item without texture : ", item); continue
				if !item.has("expression") : push_error("item without expression : ", item); continue
				var new_item : Item = Item.new(item["id"], item["name"], item["description"], item["texture"], item["expression"])
				new_gacha.items.append(new_item)
				

			for waifu in gacha["waifus"]:
				if !waifu.has("id") : push_error("waifu without id : ", waifu); continue
				if !waifu.has("name") : push_error("waifu without name : ", waifu); continue
				if !waifu.has("description") : push_error("waifu without description : ", waifu); continue
				if !waifu.has("texture") : push_error("waifu without texture : ", waifu); continue
				var new_waifu : Waifu = Waifu.new(waifu["id"], waifu["name"], waifu["description"], waifu["texture"])
				new_gacha.waifus.append(new_waifu)
				
			gachas.append(new_gacha)

class Gacha:
	var exp_prize : int = 10000
	var items : Array[Item]
	var waifus : Array[Waifu]
	
	func roll()->Prize:
		var rng : RandomNumberGenerator = RandomNumberGenerator.new()
		var choosen_one : int = rng.rand_weighted([5, 1])
		var prize : Prize
		if choosen_one == 0: #pick item
			prize = items.pick_random()
		else: # pick waifu
			prize = waifus.pick_random()
		return prize

class Prize:
	var id : int
	var texture : String
	var nom : String
	var description : String
	
	func _init(new_id : int, new_name : String, new_description : String, texture_path : String) -> void:
		id = new_id
		nom = new_name
		description = new_description
		texture = texture_path

class Item extends  Prize:
	var expression : String
	
	func _init(new_id : int, new_name : String, new_description : String,  texture_path : String, new_expression : String) -> void:
		super._init(new_id, new_name, new_description, texture_path)
		expression = new_expression
	
	func apply():
		pass

class Waifu extends Prize:
	
	func _init(new_id : int, new_name : String, new_description : String,  texture_path : String) -> void:
		super._init(new_id, new_name, new_description, texture_path)
