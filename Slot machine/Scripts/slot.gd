extends Node2D
class_name MachineSlot
@onready var slots: Sprite2D = $Slots

var selected : int :
	set(value):
		state = State.SELECTED
		slots.frame = value
	get():
		return slots.frame

enum State {
	ROLLING,
	SELECTED
}
var state : State = State.ROLLING
var time_passed : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == State.ROLLING:
		time_passed += delta
		if time_passed >= 0.1:
			time_passed -= 0.1
			var rand = Global.slot_possibility.pick_random()
			if rand > 0 && rand < slots.hframes:
				slots.frame = rand
