extends Control
@export var first_scene : PackedScene
@export var selector_scene : PackedScene
@onready var anim_sprite = $CenterContainer/VBoxContainer/Skeleton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_pressed():
	LevelManager.load_first_level()
	#Global.game_controller.change_2d_scene(first_scene)


func _on_load_game_pressed():
	#Global.game_controller.deload_current_gui_scene()
	Global.game_controller.change_gui_scene(selector_scene)


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_splash_screen_finished():
	$MusicSplashScreen.playing = false
	$MusicSplashScreen.autoplay = false
	$MusicTitleScreen.playing = true
	$MusicTitleScreen.autoplay = true
	anim_sprite.play("default")
	pass # Replace with function body.


func _on_music_title_screen_finished():
	$MusicTitleScreen2.playing = true

func _on_slide_disclaimer_finished():
	$MusicSplashScreen.playing = true
	$MusicSplashScreen.autoplay = true
