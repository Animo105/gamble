extends CanvasLayer


func _ready() -> void:
	Global.money_change.connect(_money_update)
	_money_update()

func _money_update():
	$money/Label.text = "%d$" % Global.money
