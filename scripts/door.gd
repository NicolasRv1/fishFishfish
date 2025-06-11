extends Area2D

var canEnter = false

func _on_action_point_entered(area: Area2D) -> void:
	canEnter = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action") and canEnter:
		get_tree().change_scene_to_file("res://fishFishfish/scenes/insideHut.tscn")


func _on_area_exited(area: Area2D) -> void:
	canEnter = false
