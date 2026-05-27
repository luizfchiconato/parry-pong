class_name Treinador extends Node2D

var ShockwaveScene = load("res://Scenes/Projectiles/Shockwave.tscn")
@export var health = 120
signal damage

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _take_damage(amount, deathVelocity : Vector2):
	health -= amount
	print("damage", health)
	emit_signal("damage", health)

func _on_shockwave_timer_timeout():
	var shockwave = ShockwaveScene.instantiate() as Shockwave
	shockwave.global_position = $ShockwaveLocation.global_position
	shockwave.set_as_top_level(true)
	Global.game_controller.add_2d_scene_child(shockwave)
