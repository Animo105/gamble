extends Node

signal _money_update

var money : int = 500:
	set(value):
		money = value
		_money_update.emit()
var upgrades_bought : Dictionary[int, int] = {}


# Gacha machine global
var base_capsule_price: int = 1000
var capsules : Dictionary[int, int] = {
	1:0,
	2:0,
	3:0
}

# Slot machine global
var bet_ammount : int = 10
var is_bet_allowed : bool = false
var slot_possibility : Array[int] = [1, 2 ,3 ,6 ,7]
var slot_wait_time : float = 1.25
var luck_probability : float = 2
