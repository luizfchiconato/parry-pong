extends Node2D

@export var next_scene : PackedScene

var death_number = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("Esc")):
		if (!Global.game_controller.isPaused()):
			Global.game_controller.pause()


func _on_enemy_died():
	for child in get_children():
		for grandson in child.get_children():
			if grandson is EnemyMain:
				grandson.increment_death_number()
	
	var allDied = true
	for child in get_children():
		for grandson in child.get_children():
			if grandson is EnemyMain:
				if (grandson.health > 0):
					allDied = false
	
	if (allDied == true):
		LevelManager.load_next_level()
		# Global.game_controller.change_2d_scene(next_scene)
		
