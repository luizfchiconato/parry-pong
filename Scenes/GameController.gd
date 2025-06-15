class_name GameController extends Node2D

@export var world_2d : Node2D
@export var gui : Control
@export var first_gui_scene : PackedScene

const PAUSE_SCREEN = preload("res://Scenes/UI/Pause.tscn")

var current_gui_scene : Node
var current_2d_scene : Node
var current_2d_packed_scene

func _ready():
	Global.game_controller = self
	change_gui_scene(first_gui_scene)

func change_gui_scene(new_scene: PackedScene, delete: bool = true, keep_running: bool = false):
	if (current_gui_scene != null):
		if delete: 
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	var new = new_scene.instantiate()
	gui.add_child(new)
	current_gui_scene = new
	print(current_gui_scene)

func deload_current_gui_scene():
	if (current_gui_scene != null):
		print("limpou")
		current_gui_scene.queue_free()
	current_gui_scene = null

func change_2d_scene(new_scene: PackedScene, delete: bool = true, keep_running: bool = false):
	deload_current_gui_scene()
	if (current_2d_scene != null):
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			current_2d_scene.visible = false
		else:
			world_2d.remove_child(current_2d_scene)
	var new = new_scene.instantiate()
	world_2d.add_child(new)
	current_2d_scene = new
	current_2d_packed_scene = new_scene

func reload_current_2d_scene():
	change_2d_scene(current_2d_packed_scene)

func add_2d_scene_child(node):
	current_2d_scene.add_child(node)
	
func pause():
	change_gui_scene(PAUSE_SCREEN)

func unpause():
	deload_current_gui_scene()

func isPaused() -> bool:
	return get_tree().paused
