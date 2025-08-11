extends Node

signal _money_update
signal experience_update

var level : int = 0:
	set(value):
		level = value

var levelUpAmmount : int = 100
var experience : int = 0:
	set(value):
		experience = value
		if experience >= levelUpAmmount:
			experience -= levelUpAmmount
			level += 1
			levelUpAmmount *= 1.2
		experience_update.emit()

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
var slot_possibility : Array[int] = [1, 2 ,3 ,4, 7 ,13]
var slot_wait_time : float = 1.25
var luck_probability : float = 2
