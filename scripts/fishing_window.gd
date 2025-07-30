extends Node2D

@export
var enemy_scene : PackedScene

@onready 
var bullet_time: Timer = $bullet_time

var rarity = randf()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_timer()
	
	Input.warp_mouse(Vector2(931.0, 710.0))
	
	spawn_fish()
	

func _process(_delta: float) -> void:
	if Global.isDead:
		get_tree().change_scene_to_file("res://fishFishfish/scenes/island.tscn")
		
		bullet_time.stop()






func spawn_fish():
	if rarity <= 0.6:
		enemy_scene = preload("res://fishFishfish/scenes/blue_fish.tscn")
	else:
		enemy_scene = preload("res://fishFishfish/scenes/purple_fish.tscn")


	var enemy_instance = enemy_scene.instantiate()
	add_child(enemy_instance)
	
	enemy_instance.global_position = Vector2(920.0, 186.0)
	

func _on_bullet_time_timeout() -> void:
	if rarity <= 0.6:
		print ("bass")
		Global.gain_coins(2)
	else:
		print ("crazy fish")
		Global.gain_coins(8)
	
	get_tree().change_scene_to_file("res://fishFishfish/scenes/island.tscn")

func bullet_timer():
	if rarity <= 0.6:
		bullet_time.wait_time = 2.0
	else:
		bullet_time.wait_time = 10.0
	
	bullet_time.start()
	
