class_name Player
extends CharacterBody2D

const walk_speed = 250.0
const run_speed = 420.0
var running = false
var speed := 0.0

var locked = false
var fishing = false

@onready 
var animations: AnimatedSprite2D = $AnimatedSprite2D

@onready 
var fish_time: Timer = $fishing


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("fish") and !locked:
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
				else:
					animations.flip_h = true
					animations.animation = "runRight"
			else:
				if input_vector.x > 0:
					animations.flip_h = false
					animations.animation = "walkRight"
				else:
					animations.flip_h = true
					animations.animation = "walkRight"

		
		else:
			if running:
				if input_vector.y > 0:
					animations.animation = "run"
				else:
					animations.animation = "runUp"
			else:
				if input_vector.y > 0:
					animations.animation = "walk"
				else:
					animations.animation = "walkUp"


func _on_fishing_timeout() -> void:
	locked = false
	print("FISHED!")
	fishing = false
