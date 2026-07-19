class_name LevelStart extends Control

@onready var level : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_level(level):
	self.level = level
	$CanvasLayer/LevelNumber.text = "Ginásio " + str(level.index)
	$CanvasLayer/LevelName.text = level.name
	if (level.get("description") != null):
		$CanvasLayer/LevelDescription.text = level.get("description")
	$Timer.start()

func load_level():
	Global.game_controller.change_2d_scene(level.scene)
