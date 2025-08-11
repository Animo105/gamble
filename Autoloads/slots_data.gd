extends Node

var coins_bonus_value : int = 0
var fruits_mult_bonus : float = 0

var slots : Array[Slot] = []

func _ready() -> void:
	var file = FileAccess.open("res://Assets/JSON/slots.json", FileAccess.READ)
	if file:
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if !data is Array:
			push_error("slots are not organized into an array")
		for slot in data:
			if !slot.has("id") : push_error("slot without id : ", slot); continue
			if !slot.has("weight") : push_error("slot without weight : ", slot); continue
			if !slot.has("expression") : push_error("slot without expression : ", slot); continue
			var new_slot : Slot = Slot.new(slot["id"], slot["weight"], slot["expression"])
			if slot.has("exp"): new_slot.exp_gain = slot["exp"]
			slots.append(new_slot)

class Slot:
	var id : int
	var weight : float
	var expression : String
	var exp_gain : int = 100
	
	func _init(slot_id : int, slot_weight : float, slot_expression : String) -> void:
		id = slot_id
		weight = slot_weight
		expression = slot_expression
	
	func get_reward(bet_amount : int)->int:
		var ex : Expression = Expression.new()
		var err = ex.parse(expression, ["func", "amount"])
		if err == OK:
			var result : int = ex.execute([ExpressionFunction, bet_amount])
			if ex.has_execute_failed():
				push_error("Execution failed in slot ", id, " : ", ex.get_error_text())
				return 0
			else:
				Global.experience += exp_gain
				return result
		else:
			push_error("Error in slot ", id, " : ", ex.get_error_text())
			return 0
