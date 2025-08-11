extends Node2D

@onready var lever_sprite: AnimatedSprite2D = $"Slot Lever/Lever Sprite"
@onready var lever_button: TextureButton = $"Slot Lever/Lever Button"
@onready var bet_text: LineEdit = $"bet text"


var slots : Array[MachineSlot] = []
var weights : PackedFloat32Array


func _ready() -> void:
	var main_music = $mainMusic
	main_music.play()
	slots.append($Slot)
	slots.append($Slot2)
	slots.append($Slot3)
	lever_sprite.play("default")
	bet_text.text = "%d$" % Global.bet_ammount
	bet_text.editable = Global.is_bet_allowed
	# fait les weights
	for possibility in Global.slot_possibility:
		weights.append(SlotsData.slots[possibility].weight)

func _on_lever_button_pressed() -> void:
	# check si tu peux pull le lever, animation + take money
	if Global.money >= Global.bet_ammount:
		var gambling = $gambling
		gambling.play()
		lever_sprite.play("lever_down")
		lever_button.disabled = true
		Global.money += -Global.bet_ammount
	
		# pull le levier
		Hud.disable_button(true)
		var random = RandomNumberGenerator.new()
		# choisis le slot vers le quelle la machine vas tirer
		var wanted_slot = random.rand_weighted(weights)
		# crer des weight selon le slot wanted
		var modified_weigts : PackedFloat32Array = weights.duplicate()
		modified_weigts[wanted_slot] *= Global.luck_probability
		# roll les slates
		slots[0].selected = Global.slot_possibility[wanted_slot]
		for i in range(1, 3):
			await get_tree().create_timer(Global.slot_wait_time).timeout
			slots[i].selected = Global.slot_possibility[random.rand_weighted(modified_weigts)]
		# check pour la win
		await get_tree().create_timer(1).timeout
		if slots[0].selected == slots[1].selected && slots[1].selected == slots[2].selected:
			Global.money += SlotsData.slots[slots[0].selected].action.call(Global.bet_ammount)
			var winSound = $winSound
			winSound.play()
		lever_sprite.play("lever_up")
		lever_button.disabled = false
		for slot in slots:
			slot.state = MachineSlot.State.ROLLING
		Hud.disable_button(false)
		# pu d'argent a gamble, la game est perdu?
		if Global.money == 0:
			pass


func _on_bet_text_focus_exited() -> void:
	var number = int(bet_text.text)
	number = clamp(number, 10, Global.money)
	bet_text.text = "%d$" % number
	Global.bet_ammount = number

func _on_bet_text_focus_entered() -> void:
	if Global.is_bet_allowed:
		bet_text.text = str(Global.bet_ammount)


func _on_bet_text_text_submitted(_new_text: String) -> void:
	bet_text.release_focus()
