extends CanvasLayer


func _ready() -> void:
	Global._bet_update.connect(_bet_update)
	Global._money_update.connect(_money_update)
	_money_update()

func _money_update():
	$money/Label.text = "%d$" % Global.money

func _bet_update():
	Global.bet_ammount = int($bet/TextEdit.text)

func _on_text_edit_focus_exited():
	_bet_update()
