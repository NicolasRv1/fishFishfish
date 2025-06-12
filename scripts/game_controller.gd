class_name GameController extends Node 

#@export var world2D : Node2D
#@export var world3D : Node3D
#@export var UI : Control
#
#
#var current_2d_scene
#var current_3d_scene
#var current_gui_scene
#
#
#func _ready() -> void:
	#Global.game_controller = self
	#current_2d_scene = $world2D/main
#
#func change_2d_scene(new_scene: Node2D, delete: bool = false, keep_running: bool = false) -> void:
	#if current_2d_scene != null:
		#if delete:
			#current_2d_scene.queue_free() #removes node entirely
		#elif keep_running:
			#current_2d_scene.visible != false #keeps in memory and running
		#else:
			#world2D.remove_child(current_2d_scene) #keeps in memory, does not run
	#
	#var new = load(str(new_scene)).instantiate()
	#world2D.add_child(new)
	#current_2d_scene = new
#
#func change_ui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	#if current_gui_scene != null:
		#if delete:
			#current_gui_scene.queue_free() #removes node entirely
		#elif keep_running:
			#current_gui_scene.visible != false #keeps in memory and running
		#else:
			#UI.remove_child(current_gui_scene) #keeps in memory, does not run
	#
	#var new = load(new_scene).instantiate()
	#UI.add_child(new)
	#current_gui_scene = new
#
#func change_3d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	#if current_3d_scene != null:
		#if delete:
			#current_3d_scene.queue_free() #removes node entirely
		#elif keep_running:
			#current_3d_scene.visible != false #keeps in memory and running
		#else:
			#world3D.remove_child(current_3d_scene) #keeps in memory, does not run
	#
	#var new = load(new_scene).instantiate()
	#world3D.add_child(new)
	#current_3d_scene = new
