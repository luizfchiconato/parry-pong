extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print("uuuuu")
	get_tree().paused = true
 

func _process(delta):
	if(Input.is_action_just_pressed("Enter")):
		unpause()
		
	if(Input.is_action_just_pressed("Q")):
		unpause()
		_load_main_menu()

func unpause():
	get_tree().paused = false
	Global.game_controller.unpause()

func _load_main_menu():
	Global.game_controller.load_main_menu()
