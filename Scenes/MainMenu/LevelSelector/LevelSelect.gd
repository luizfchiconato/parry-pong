extends Button

@export var level_scene : PackedScene
@export var reload_scene = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	if (reload_scene):
		Global.game_controller.reload_current_2d_scene()
	else:
		Global.game_controller.change_2d_scene(level_scene)
