extends Node2D


func _ready() -> void:
	if Global.game_1st_loading:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
	else:
		$player.position.x = Global.player_exit_posx
		$player.position.y = Global.player_exit_posy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
