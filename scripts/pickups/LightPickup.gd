extends "res://scripts/pickups/BasePickup.gd"

func pickup(body):
	get_tree().call_group("player", "increase_light")
	queue_free()
