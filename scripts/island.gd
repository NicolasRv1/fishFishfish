extends Node2D

@onready 
var fishing_window: Control = $fishing_window
@onready 
var bullet_time: Timer = $fishing_window/bullet_time

var rarity = randf()

func _ready() -> void:
	if Global.game_1st_loading:
		$player.position.x = 404.0
		$player.position.y = 503.0
	else:
		$player.position.x = 179.0
		$player.position.y = 332.0

func _process(_delta: float) -> void:
	if fishing_window.visible == true:
		if bullet_time.is_stopped() == true:
			bullet_time.start()
		else:
			pass
	else:
		pass
	
	
	if rarity <= 0.8:
		bullet_time.wait_time = 2.0

	else:
		bullet_time.wait_time = 10.0



func _on_bullet_time_timeout() -> void:
	if rarity <= 0.8:
		print ("bass")
	else:
		print ("crazy fish")

	fishing_window.visible = false
	Global.lock_player = false
