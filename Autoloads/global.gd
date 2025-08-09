extends Node

signal _money_update

var money : int = 500:
	set(value):
		money = value
		_money_update.emit()

var bet_ammount : int = 10

var capsules : Dictionary[String, int] = {
	"blue":0,
	"green":0,
	"yellow":0
}

# Slot machine global
var slot_possibility : Array[int] = [1, 2 ,3 ,6 ,7]
var luck_probability : int = 2
var slot_wait_time : float = 1
var slot_cost : int = 100
var is_bet_allowed : bool = false
