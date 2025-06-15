extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print("uuuuu")
	get_tree().paused = true


func _process(delta):
	print("fffff")
	if(Input.is_action_just_pressed("Enter")):
		print("sadgsadghashasdgsapgnbsadgisadubhgnasd")
		get_tree().paused = false
		Global.game_controller.unpause()
