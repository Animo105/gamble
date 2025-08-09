extends CanvasLayer


func _ready() -> void:
	Global._money_update.connect(_money_update)
	_money_update()
	$"bet text".text = "%d$" % Global.bet_ammount

func _money_update():
	$money/Label.text = "%d$" % Global.money

func _bet_update():
	var number = int($"bet text".text)
	number = clamp(number, 100, Global.money)
	$"bet text".text = "%d$" % number
	Global.bet_ammount = number

func _on_text_edit_focus_exited():
	_bet_update()
