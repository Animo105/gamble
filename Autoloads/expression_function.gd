extends Node

#variable accessible par les Expression
static func get_expression_access()->Dictionary:
	return  {
		"money" : Global.money,
		"luck" : Global.luck_probability,
		"can_bet" : Global.is_bet_allowed,
		"slot_wait_time" : Global.slot_wait_time,
		"amount" : Global.bet_ammount,
		"blue_capsule" : Global.capsules["blue"],
		"green_capsule" : Global.capsules["green"],
		"yellow_capsule" : Global.capsules["yellow"],
		"base_gacha_price" : Global.base_capsule_price,
		"coin_value_bonus" : SlotsData.coins_bonus_value,
	}

func increase_coin_value(amount : int):
	SlotsData.coins_bonus_value += amount
	print("incrase coin value")
