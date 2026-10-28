class_name Treinador extends CharacterBody2D

var ShockwaveScene = load("res://Scenes/Projectiles/Shockwave.tscn")
var GiantBulletScene = load("res://Scenes/Projectiles/GiantBullet.tscn")
@export var health = 96
@export var allow_giant_ball = false
signal damage

@export var move_speed := float(18)

var bullet_interval = 1

var is_phase_1 = true
var original_modulate = self.modulate

var initial_shockwaves = 0

const SHOCKWAVE_TIMER = 5
const INITIAL_SHOCKWAVE_TIMER = 1.5
const GIANT_BULLET_TIMER = 10
const FINAL_GIANT_BULLET_TIMER = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	
	$ShockwaveTimer.autostart = true
	$ShockwaveTimer.wait_time = INITIAL_SHOCKWAVE_TIMER


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
	var paint_tween = create_tween()
	await paint_tween.tween_property(self, "modulate", Color.RED, 0.2).finished
	AudioManager.play_sound(AudioManager.BOSS_STOMP, 0)
	var shockwave = ShockwaveScene.instantiate() as Shockwave
	shockwave.set_as_top_level(true)
	shockwave.global_position = $ShockwaveLocation.global_position
	Global.game_controller.add_2d_scene_child(shockwave)
	var return_tween = create_tween()
	return_tween.tween_property(self, "modulate", original_modulate, 0.1)
	
	initial_shockwaves = initial_shockwaves + 1
	if (initial_shockwaves == 3):
		$BulletTimer.autostart = true
		$BulletTimer.start()
		$ShockwaveTimer.wait_time = SHOCKWAVE_TIMER

func _on_giant_bullet_timer_timeout():
	print("TIMEOUT")
	var paint_tween = create_tween()
	var player = AudioManager.play_sound(AudioManager.BOSS_SWOOSH, 0)
	await paint_tween.tween_property(self, "modulate", Color.RED, player.stream.get_length()).finished
	var ball = createBall()
	Global.game_controller.add_2d_scene_child(ball)
	var return_tween = create_tween()
	return_tween.tween_property(self, "modulate", original_modulate, 0.1)
	

func createBall() -> GiantBullet:
	AudioManager.play_sound(AudioManager.BOSS_SPIT, 0)
	var bullet := GiantBulletScene.instantiate() as GiantBullet
	bullet.global_position = $BulletLocation.global_position
	bullet.set_as_top_level(true)
	return bullet

func allow_giant_balls():
	_on_giant_bullet_timer_timeout()
	$GiantBulletTimer.autostart = true
	$GiantBulletTimer.start()

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
