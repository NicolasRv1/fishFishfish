extends Node2D


func _ready() -> void:
	$player.position.x = 410.0
	$player.position.y = 377.0
	$player.animations.animation = "idleUp"
