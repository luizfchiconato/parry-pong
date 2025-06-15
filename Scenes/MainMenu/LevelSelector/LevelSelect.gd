class_name LevelSelect extends Control

@export var level_index : int
@export var reload_scene = false
@export var text : String = "teste"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	if (reload_scene):
		LevelManager.reload_current_level()
		# Global.game_controller.reload_current_2d_scene()
	else:
		LevelManager.load_level_by_index(level_index)
		#Global.game_controller.change_2d_scene(level_scene)
