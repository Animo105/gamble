extends Control

@onready var upgrade_container: GridContainer = $ScrollContainer/UpgradeContainer
const UPGRADE_BUTTON = preload("res://Shop/upgrade_button.tscn")

static func create_button(id : int, cost : int)->UpgradeButton:
	var button = UPGRADE_BUTTON.instantiate()
	button.upgrade_cost = cost
	button.upgrade_id = id
	return button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade in UpgradesData.upgrades:
		if Global.upgrades_bought.has(upgrade.id): continue
		var button := create_button(upgrade.id, upgrade.cost)
		print(button.upgrade_cost)
		upgrade_container.add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
