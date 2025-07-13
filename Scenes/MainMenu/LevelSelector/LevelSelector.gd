extends Control

var LevelSelect = load("res://Scenes/MainMenu/LevelSelector/LevelSelect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_level_buttons():
	var levels : Array = LevelManager.GINASIOS
	print(levels)
	for i in range(levels.size()):
		add_level_button(levels[i], i)

func add_level_button(level : PackedScene, level_index: int):
	var button = LevelSelect.instantiate() as LevelSelect
	button.text = str("Ginásio ", level_index + 1)
	button.level_index = level_index
	button.custom_minimum_size.y = 40
	if (level_index <= 9):
		$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer1.add_child(button)
	else:
		$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer2.add_child(button)		
