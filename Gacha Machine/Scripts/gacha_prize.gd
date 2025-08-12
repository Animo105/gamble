extends Control
class_name GachaPrize

const TEXTURE_DIR : String = "res://Assets/Gacha/Items/"
@onready var texture_rect: TextureRect = $Panel/TextureRect
@onready var label_name: Label = $"Panel/Label name"
@onready var label_description: Label = $"Panel/Label description"
@onready var stars: Sprite2D = $stars


func update(prize : GachasData.Prize):
	var texture_path  = TEXTURE_DIR + prize.texture
	if FileAccess.file_exists(texture_path):
		texture_rect.texture = load(texture_path)
	label_name.text = prize.nom
	label_description.text = prize.description
	if prize is GachasData.Item:
		stars.visible = true
		stars.frame = Global.items_won[prize.id]-1
	else:
		stars.visible = false
