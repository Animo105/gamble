extends Node

# #################### Méthodes pour increase valeurs ################# #
func increase_money(amount : int):
	Global.money += amount

func increase_flat_win_bonus(amount : int):
	Global.flat_win_bonus += amount

func increase_coin_value(amount : int):
	SlotsData.coins_bonus_value += amount

func increase_fruits_mult(amount : float):
	SlotsData.fruits_mult_bonus += amount

func increase_luck(amount : float):
	Global.luck_probability += amount

func allow_bet(allow : bool):
	Global.is_bet_allowed = allow

func increase_slot_speed(amount : float):
	Global.slot_wait_time -= amount

func increase_capsule(type : int, amount : int)->int:
	Global.capsules[type] += amount
	return 0

func decrease_base_gacha_price(amount : int):
	Global.base_capsule_price -= amount

func increase_weight_for_slot(slot_id : int, weight_increase : float):
	SlotsData.slots[slot_id].weight += weight_increase

# ################### Méthodes pour get des valeurs ################# #
func get_bet_amount()->int:
	return Global.bet_ammount

func get_coins_bonus_value()->int:
	return SlotsData.coins_bonus_value

func get_fruits_bonus_mult()->float:
	return SlotsData.fruits_mult_bonus
