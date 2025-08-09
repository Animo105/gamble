extends Control

var upgrade_id : int = 0
var upgrade_cost : int = 0

func _init(id : int, cost : int) -> void:
	upgrade_id = id
	upgrade_cost = cost

func _ready() -> void:
	$cost.text = "%d$" % upgrade_cost

func _on_button_pressed() -> void:
	print("pressed")
