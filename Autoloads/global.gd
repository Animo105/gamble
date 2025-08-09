extends Node

signal money_change

var money : int = 1000:
	set(value):
		money = value
		money_change.emit()
var capsules : Dictionary[String, int] = {
	"blue":0,
	"green":0,
	"yellow":0
}

# Slot machine global
var slot_possibility : Array[int] = [1, 2 ,3 ,6 ,7]
var slot_wait_time : float = 1
var slot_cost : int = 100
