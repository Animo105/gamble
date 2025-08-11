extends Node

var gachas : Array[Gacha] = [
	
]

class Gacha:
	enum Rarity {
		COMMON,
		UNCOMMON,
		RARE,
		EPIC,
		LEGENDARY
	}
	
	var id: int
	var texture : Texture2D
	var rarity : Rarity
	var bonus : Callable
