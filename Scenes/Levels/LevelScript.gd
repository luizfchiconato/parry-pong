extends Node2D

@export var next_scene : PackedScene

var death_number = 0

# Called whensss the node enters the scene tree for the first time.
func _ready():
	if ($Scene/TileMapBig != null):
		$Scene/TileMapBig.visible = false
	
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("Esc")):
		if (!Global.game_controller.isPaused()):
			Global.game_controller.pause()


func _on_enemy_died():
	for child in get_children():
		for grandson in child.get_children():
			# feio, eu sei. lógica criada antes do GameManager e preguiça de resolver
			if grandson is EnemyMain or grandson is LifeRacket or grandson is PaintSlime:
				grandson.increment_death_number()

	var allDied = true
	for child in get_children():
		for grandson in child.get_children():
			if grandson is EnemyMain:
				if (grandson.health > 0):
					allDied = false
	
	if (allDied == true):
		finish_level()
		# Global.game_controller.change_2d_scene(next_scene)

func finish_level():
	LevelManager.load_next_level()

func _on_boss_damage(health):
	if (health <= 100):
		change_to_phase_2()
	if (health <= 60):
		change_to_phase_3()
	for child in get_children():
		for grandson in child.get_children():
			if grandson is LifeRacket:
				grandson.boss_damage(health)

func change_to_phase_2():
	$Enemies/Treinador.change_to_phase_2()
	#$Scene/TileMapSmall.process_mode = Node.PROCESS_MODE_DISABLED
	$Scene/TileMapSmall.visible = false
	$Scene/TileMapSmall.tile_set.set_physics_layer_collision_layer(0, 0)
	$Scene/TileMapSmall.tile_set.set_physics_layer_collision_mask(0, 0)

	#$Scene/TileMapBig.process_mode = Node.PROCESS_MODE_INHERIT
	$Scene/TileMapBig.visible = true
	$Player.change_zoom(1.0)
	
	#TODO: GAMBIARRAAAAAA
	for child in get_children():
		for grandson in child.get_children():
			# feio, eu sei. lógica criada antes do GameManager e preguiça de resolver
			if grandson is EnemyMain:
				grandson.increment_death_number()

func change_to_phase_3():
	$Enemies/Treinador.allow_giant_balls()

func _on_treinador_damage(health):
	$Scene/CanvasLayer/Control/HealthBarBoss.setHealth(health)
