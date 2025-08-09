extends Node2D

@onready var lever_sprite: AnimatedSprite2D = $"Slot Lever/Lever Sprite"
@onready var lever_button: TextureButton = $"Slot Lever/Lever Button"

var slots : Array[MachineSlot] = []
var weights : PackedFloat32Array

func _ready() -> void:
	slots.append($Slot)
	slots.append($Slot2)
	slots.append($Slot3)
	lever_sprite.play("default")
	for possibility in Global.slot_possibility:
		weights.append(SlotsData.slots[possibility].weight)

func _on_lever_button_pressed() -> void:
	if Global.money >= Global.bet_ammount:
		lever_sprite.play("lever_down")
		lever_button.disabled = true
		Global.money += -Global.bet_ammount
		var random = RandomNumberGenerator.new()
		for slot in slots:
			var slot_id = Global.slot_possibility[random.rand_weighted(weights)]
			slot.selected = slot_id
			await get_tree().create_timer(Global.slot_wait_time).timeout
		if slots[0].selected == slots[1].selected && slots[1].selected == slots[2].selected:
			Global.money += SlotsData.slots[slots[0].selected].action.call(Global.bet_ammount)
		
		lever_sprite.play("lever_up")
		lever_button.disabled = false
		for slot in slots:
			slot.state = MachineSlot.State.ROLLING
