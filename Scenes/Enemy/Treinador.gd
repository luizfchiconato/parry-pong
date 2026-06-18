class_name Treinador extends CharacterBody2D

var ShockwaveScene = load("res://Scenes/Projectiles/Shockwave.tscn")
var GiantBulletScene = load("res://Scenes/Projectiles/GiantBullet.tscn")
@export var health = 120
@export var allow_giant_ball = false
signal damage

@export var move_speed := float(18)

var bullet_interval = 1

var is_phase_1 = true
var original_modulate = self.modulate

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return
	var player = get_tree().get_nodes_in_group("Player")[0]  as CharacterBody2D
	if (self.position.distance_to(player.position) > 110.0):
		var chase_direction = player.position - self.position as Vector2

		self.velocity = chase_direction.normalized() * move_speed
		self.move_and_slide()
		
func change_to_phase_2():
	is_phase_1 = false
	$AnimatedSprite2D.play("no_arm")

func _take_damage(amount, deathVelocity : Vector2):
	health -= amount
	emit_signal("damage", health)

func _on_shockwave_timer_timeout():
	var shockwave = ShockwaveScene.instantiate() as Shockwave
	shockwave.set_as_top_level(true)
	shockwave.global_position = $ShockwaveLocation.global_position
	Global.game_controller.add_2d_scene_child(shockwave)

func _on_giant_bullet_timer_timeout():
	if allow_giant_ball:
		var ball = createBall()
		Global.game_controller.add_2d_scene_child(ball)

func createBall() -> GiantBullet:
	var bullet := GiantBulletScene.instantiate() as GiantBullet
	bullet.global_position = $BulletLocation.global_position
	bullet.set_as_top_level(true)
	return bullet

func allow_giant_balls():
	$GiantBulletTimer.autostart = true
	$GiantBulletTimer.start()
	allow_giant_ball = true

func _on_bullet_timer_timeout():
	if (!is_phase_1):
		return
	var EnemyAttack = $AnimatedSprite2D/EnemyAttack
	EnemyAttack.start_sprite()
	var paint_tween = create_tween()
	await paint_tween.tween_property(self, "modulate", Color.RED, 0.2).finished
	EnemyAttack.create_bullet()
	EnemyAttack.stop_sprite()
	var return_tween = create_tween()
	return_tween.tween_property(self, "modulate", original_modulate, 0.1)
	restartBulletTimer()

func restartBulletTimer():
	#var my_random_number
	#my_random_number = rng.randf_range(bullet_interval - bullet_interval * 0.2, bullet_interval + bullet_interval * 0.2)
#	# $BulletTimer.wait_time = my_random_number
	# TODO: GAMBIARRA PRA TIRAR VARIANCIA QUE ANIMAÇAO DE ATIRAR TRAS
	$BulletTimer.wait_time = bullet_interval - 0.2
	$BulletTimer.autostart = true
	$BulletTimer.start()
	return true
