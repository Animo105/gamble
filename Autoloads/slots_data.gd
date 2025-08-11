extends Node

var coins_bonus_value : int = 0
var fruits_mult_bonus : float = 1

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
			slots.append(new_slot)
			print(slot)
			print(new_slot)


class Slot:
	var id : int
	var weight : float
	var expression : String
	
	func _init(slot_id : int, slot_weight : float, slot_expression : String) -> void:
		id = slot_id
		weight = slot_weight
		expression = slot_expression
	
	func get_reward()->int:
		var ex : Expression = Expression.new()
		var err = ex.parse(expression, ["func"])
		if err == OK:
			var result : int = ex.execute([ExpressionFunction])
			if ex.has_execute_failed():
				push_error("Execution failed in slot ", id, " : ", ex.get_error_text())
				return 0
			else:
				return result
		else:
			push_error("Error in slot ", id, " : ", ex.get_error_text())
			return 0


func coin(_amount : int)->int:
	return 100 + coins_bonus_value

func coins(_amount : int)->int:
	return 1000 + coins_bonus_value

func blue_capsule(_amount : int)->int:
	Global.capsules[1] += 1
	return 0

func green_capsule(_amount : int)->int:
	Global.capsules[2] += 1
	return 0

func yellow_capsule(_amount : int)->int:
	Global.capsules[3] += 1
	return 0

func lemon(amount)->int:
	return amount * 3 * fruits_mult_bonus

func cherry(amount)->int:
	return amount * 4 * fruits_mult_bonus

func water_melon(amount)->int:
	return amount * 5 * fruits_mult_bonus

func grapes(amount)->int:
	return amount * 6 * fruits_mult_bonus

func clover(_amount)->int:
	return 0

func horse_shoe(_amount)->int:
	return 0

func jackpot(_amount)->int:
	return 0
