extends Node

var coins_bonus_value :int= 0

var slots : Array[Slot] = [
	# id, weight, action
	Slot.new(0, 0, func(_amount): return 0), # blank
	Slot.new(1, 2, coin), # single coin
	Slot.new(2, 0.5, coins), # pile of coins
	Slot.new(3, 1, blue_capsule), # blue capsule
	Slot.new(4, 1, green_capsule), # green capsule
	Slot.new(5, 1, yellow_capsule), # yellow capsule
	Slot.new(6, 2, lemon), # lemon
	Slot.new(7, 1, cherry), # cherry
	Slot.new(8, 1, water_melon), # water melon
	Slot.new(9, 1, grapes), # grapes
	Slot.new(10, 0.5, clover), # clover
	Slot.new(11, 0.5, horse_shoe), # horse shoe
	Slot.new(12, 0.01, jackpot) # 777
]

class Slot:
	var id : int
	var weight : float
	var action : Callable
	
	func _init(slot_id : int, slot_weight : float, slot_action : Callable) -> void:
		id = slot_id
		weight = slot_weight
		action = slot_action

func coin(_amount : int)->int:
	return 100 + coins_bonus_value

func coins(_amount : int)->int:
	return 500 + coins_bonus_value

func blue_capsule(_amount : int)->int:
	Global.capsules["blue"] += 1
	return 0

func green_capsule(_amount : int)->int:
	Global.capsules["green"] += 1
	return 0

func yellow_capsule(_amount : int)->int:
	Global.capsules["yellow"] += 1
	return 0

func lemon(amount)->int:
	return amount * 2

func cherry(amount)->int:
	return amount * 3

func water_melon(amount)->int:
	return amount * 4

func grapes(amount)->int:
	return amount * 5

func clover(_amount)->int:
	return 0

func horse_shoe(_amount)->int:
	return 0

func jackpot(_amount)->int:
	return 0
