extends "res://Scenes/Levels/LevelScript.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/Control/Label.text = str(int($Timer.time_left))

func process_finish_level():
	if $Player.health > 0:
		finish_level()
