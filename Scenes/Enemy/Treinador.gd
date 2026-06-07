class_name Treinador extends CharacterBody2D

var ShockwaveScene = load("res://Scenes/Projectiles/Shockwave.tscn")
var GiantBulletScene = load("res://Scenes/Projectiles/GiantBullet.tscn")
@export var health = 120
signal damage

@export var move_speed := float(18)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("no_arm")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return
	var player = get_tree().get_nodes_in_group("Player")[0]  as CharacterBody2D
	if (self.position.distance_to(player.position) > 110.0):
		var chase_direction = player.position - self.position as Vector2

		self.velocity = chase_direction.normalized() * move_speed
		self.move_and_slide()

func _take_damage(amount, deathVelocity : Vector2):
	health -= amount
	emit_signal("damage", health)

func _on_shockwave_timer_timeout():
	var shockwave = ShockwaveScene.instantiate() as Shockwave
	shockwave.set_as_top_level(true)
	shockwave.global_position = $ShockwaveLocation.global_position
	Global.game_controller.add_2d_scene_child(shockwave)

func _on_giant_bullet_timer_timeout():
	var ball = createBall()
	Global.game_controller.add_2d_scene_child(ball)

func createBall() -> GiantBullet:
	var bullet := GiantBulletScene.instantiate() as GiantBullet
	bullet.global_position = $BulletLocation.global_position
	bullet.set_as_top_level(true)
	return bullet
