extends Area2D

@onready var label = $Label
@export var basement_scene : PackedScene

func _ready():
	#label.visible = false
	pass

func _process(_delta):
	#if(Input.is_action_just_pressed("Enter") and label.visible == true):
	#	Global.game_controller.change_2d_scene(basement_scene)
	pass

func _on_body_entered(body):
	pass
	#if body.is_in_group("Player"):
		#label.visible = true

func _on_body_exited(body):
	pass
	#if body.is_in_group("Player"):
	#	label.visible = false
