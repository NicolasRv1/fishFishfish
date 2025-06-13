class_name Player
extends CharacterBody2D

const walk_speed = 250.0
const run_speed = 420.0
var running = false
var speed := 0.0

var locked = false
var fishing := false


@onready 
var animations: AnimatedSprite2D = $AnimatedSprite2D

@onready 
var fish_time: Timer = $fishing

@onready 
var action_point: Node2D = $action_point
var canFish = false

func _physics_process(delta: float) -> void:
	
	if Global.current_scene != "island":
		animations.animation = "idleUp"
	
	if Input.is_action_just_pressed("fish") and !locked and canFish:
		match animations.animation:
			"walkUp", "runUp", "idleUp": animations.animation = "fishUp"
			"walk", "run", "idle": animations.animation = "fish"
			"walkRight", "runRight", "idleRight": animations.animation = "fishRight"

		print ("fishing...")
		fish_time.wait_time = randf_range(4.0, 10.0)
		fish_time.start()
		locked = true
		fishing = true

	if Input.is_action_pressed("run"):
		speed = run_speed
		running = true
	else:
		speed = walk_speed
		running = false

	if Input.is_action_pressed("quit"):
		get_tree().quit()

	var input_vector = Vector2.ZERO * delta
	
	if !locked:
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	input_vector = input_vector.normalized()
	
	
	velocity = input_vector * speed
	
	if !locked:
		move_and_slide()
	
	update_animations(input_vector)


func update_animations(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:

		#idle
		match animations.animation:
			"walkUp", "runUp": animations.animation = "idleUp"
			"walk", "run": animations.animation = "idle"
			"walkRight", "runRight": animations.animation = "idleRight"




	else:
		#walking
		if abs(input_vector.x) > abs(input_vector.y):
			if running:
				if input_vector.x > 0:
					animations.flip_h = false
					animations.animation = "runRight"
					action_point.position = Vector2 (57.0, 0)
					Global.game_1st_loading = false
				else:
					animations.flip_h = true
					animations.animation = "runRight"
					action_point.position = Vector2 (-57.0, 0)
					Global.game_1st_loading = false
			else:
				if input_vector.x > 0:
					animations.flip_h = false
					animations.animation = "walkRight"
					action_point.position = Vector2 (57.0, 0)
					Global.game_1st_loading = false
				else:
					animations.flip_h = true
					animations.animation = "walkRight"
					action_point.position = Vector2 (-57.0, 0)
					Global.game_1st_loading = false

		
		else:
			if running:
				if input_vector.y > 0:
					animations.animation = "run"
					action_point.position = action_point.position
					Global.game_1st_loading = false
				else:
					animations.animation = "runUp"
					action_point.position = Vector2(0.0, -57.0)
					Global.game_1st_loading = false
			else:
				if input_vector.y > 0:
					animations.animation = "walk"
					action_point.position = Vector2(0.0, 57.0)
					Global.game_1st_loading = false
				else:
					animations.animation = "walkUp"
					action_point.position = Vector2(0.0, -57.0)
					Global.game_1st_loading = false


func _on_fishing_timeout() -> void:
	locked = false
	print("FISHED!")
	fishing = false
	
	match animations.animation:
		"fishUp" : animations.animation = "idleUp"
		"fish" : animations.animation = "idle"
		"fishRight" : animations.animation = "idleRight"







func _on_action_finder_body_entered(body: Node2D) -> void:
	canFish = true


func _on_action_finder_body_exited(body: Node2D) -> void:
	canFish = false
