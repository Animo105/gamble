extends CanvasLayer

@onready var slot_machine: Button = $"HBoxContainer/slot machine"
@onready var gacha_machine: Button = $"HBoxContainer/gacha machine"
@onready var upgrades: Button = $HBoxContainer/upgrades

const SLOT_MACHINE_SCENE = preload("res://Slot machine/slot_machine.tscn")
const UPGRADE_SHOP_SCENE = preload("res://Shop/upgrade_shop.tscn")
const GACHA_MACHINE = preload("res://Gacha Machine/gacha_machine.tscn")

var buttons : Array[Button] = []
var selected_button : Button = null

func disable_button(is_disabled : bool):
	for button in buttons:
		if button != selected_button:
			button.disabled = is_disabled

func _ready() -> void:
	buttons.append(slot_machine)
	buttons.append(gacha_machine)
	buttons.append(upgrades)
	Global._money_update.connect(_money_update)
	_money_update()

func _money_update():
	$money/Label.text = "%d$" % Global.money


func _on_slot_machine_pressed() -> void:
	for button in buttons:
		button.disabled = false
	slot_machine.disabled = true
	slot_machine.release_focus()
	get_tree().change_scene_to_packed(SLOT_MACHINE_SCENE)


func _on_gacha_machine_pressed() -> void:
	for button in buttons:
		button.disabled = false
	gacha_machine.disabled = true
	gacha_machine.release_focus()
	get_tree().change_scene_to_packed(GACHA_MACHINE)

func _process(delta: float) -> void:
	$Label.text = "%.2f MB de mémoire" % (Performance.get_monitor(Performance.MEMORY_STATIC)/ (1024.0 * 1024.0))

func _on_upgrades_pressed() -> void:
	for button in buttons:
		button.disabled = false
	upgrades.disabled = true
	upgrades.release_focus()
	get_tree().change_scene_to_packed(UPGRADE_SHOP_SCENE)


func _on_save_pressed() -> void:
	SaveManager.save_data()


func _on_clear_data_pressed() -> void:
	SaveManager.reset_data()
