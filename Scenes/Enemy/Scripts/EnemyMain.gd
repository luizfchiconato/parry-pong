extends CharacterBase
class_name EnemyMain

@onready var fsm = $FSM as FiniteStateMachine
var player_in_range = false
var rng = RandomNumberGenerator.new()

@export var attack_node : Node
@export var chase_node : Node

@export var bullet_interval: float = 2

@export var wait_for_deaths: int = 0
@export var unparriableChance: int = 0
@export var max_health: int = 6
@export var stationary: bool = false

#@onready var animator = $AnimationPlayer

@export_enum("Normal:0", "Bowling:1", "Volley:2", "Hockey:3") var enemy_type: int
@export_enum("Normal:0", "None:1", "Intermediary:2", "Extreme:3") var entropy: int

@export_enum("1", "3", "5") var min_balls_per_shot: int
@export_enum("1", "3", "5") var max_balls_per_shot: int

@export var throw_balloon: bool = false

var parent_death_number: int = 0
var dying = false


signal died

const TYPE_NORMAL = 0
const TYPE_BOWLING = 1
const TYPE_VOLLEY = 2
const TYPE_HOCKEY = 3
const speed = 200
var death_velocity : Vector2

var disc_active = true
var active_disc : HockeyDisc

var BulletScene = load("res://Scenes/Projectiles/Bullet.tscn")
var HockeyDiscScene = load("res://Scenes/Projectiles/HockeyDisc.tscn")
var BowlingBall = load("res://Scenes/Projectiles/BowlingBall.tscn")
var Laser = load("res://Scenes/Projectiles/Laser.tscn")

#func _physics_process(_delta):
	#if (dying):
		#self.global_position += velocity * speed * _delta


#After finishing an attack, we return here to determine our next action based on the players proximity
func finished_attacking():
	if(player_in_range == true and !stationary):
		fsm.change_state(attack_node, "enemy_chase_state")
	else: 
		fsm.change_state(attack_node, "enemy_idle_state")

#Register player proximity, start chasing if we are idling when the player gets close
func _on_detection_area_body_entered(body):
	if (!isAvailable()):
		return
	
	if body.is_in_group("Player"):
		player_in_range = true
		print(is_instance_valid(fsm), is_instance_valid(chase_node))
		
		#We don't want this to happen from the death state, only from idle
		if fsm.current_state.name == "enemy_idle_state" and !stationary: 
			fsm.force_change_state("enemy_chase_state")

#Return to idle when player leaves our proximity
func _on_detection_area_body_exited(body):
	if (!isAvailable()):
		return
	
	if body.is_in_group("Player"):
		player_in_range = false
		if (is_instance_valid(fsm) and is_instance_valid(chase_node) and fsm.current_state.name != "enemy_death_state"):
			fsm.force_change_state("enemy_idle_state")
		

func increment_death_number():
	print(parent_death_number)
	parent_death_number = parent_death_number + 1
	if (isAvailable()):
		activateEnemy()

func activateEnemy():
	if enemy_type == TYPE_BOWLING:
		$AnimatedSprite2D.play("IdleBowling")
	else:
		$AnimatedSprite2D.play("Idle")
	#animator.play("Idle")
	self.z_index = 5
	$AnimatedSprite2D.modulate.a = 1
	$AnimatedSprite2D.scale.x = 1
	$AnimatedSprite2D.scale.y = 1
	$HealthBar.visible = true
	$BodyCollider.set_deferred("disabled", false)

func die(newVelocity):
	print("die")
	AudioManager.play_sound(AudioManager.ENEMY_SPUN, 0, -5)
	fsm.force_change_state("enemy_death_state")
	death_velocity = newVelocity
	$BodyCollider.set_deferred("disabled", true)
	$AnimatedSprite2D.play("Thrown")
	
	if (active_disc != null):
		active_disc.destroy()
		active_disc = null
	
	print("dying", dying)
	if (!dying):
		print("signal")
		emit_signal("died")
	dying = true
	
	#super()
	#dying = true
	#self.velocity = velocity

func kill():
	queue_free()

#func _die():
	#dying = true
	#self.velocity = velocity
	#super()
	#super() #calls _die() on base-class CharacterBase
	#fsm.force_change_state("enemy_death_state")
	#emit_signal("died")
#	pass

func _take_damage(amount, deathVelocity : Vector2):
	if (!isAvailable()):
		return
		
	if(invincible == true || is_dead == true):
		return
		
	health -= amount
	#healthbar.value = health;
	
	damage_effects()
	
	$HealthBar.removeHealth(amount)
	
	var player = get_tree().get_first_node_in_group("Player") as PlayerMain
	player.set_trauma(amount * 0.12)
	
	if(health <= 0):
		die(deathVelocity)
	
func _ready():
	$HealthBar.max_health = max_health
	$HealthBar.health = max_health
	$HealthBar.setHealthBar()
	health = max_health

	if wait_for_deaths > 0:
		self.z_index = 0
		deactivateEnemy()
	else:
		self.z_index = 5
	$BulletTimer.wait_time = bullet_interval

func deactivateEnemy():
	$AnimatedSprite2D.play("Hidden")
	#animator.play("Hidden")
	$AnimatedSprite2D.modulate.a = 0.7
	$AnimatedSprite2D.scale.x = 0.7
	$AnimatedSprite2D.scale.y = 0.7
	$HealthBar.visible = false
	$BodyCollider.set_deferred("disabled", true)
	
func _on_bullet_timer_timeout():
	if (!isAvailable()):
		return
	createBullet()

func restartBulletTimer():
	var my_random_number
	my_random_number = rng.randf_range(bullet_interval - bullet_interval * 0.2, bullet_interval + bullet_interval * 0.2)
	$BulletTimer.wait_time = my_random_number
	$BulletTimer.start()
	return true

func createBullet():
	if (!isAvailable()):
		return
	
	if (enemy_type == TYPE_BOWLING):
		generateBowlingBall()
		restartBulletTimer()
	elif (enemy_type == TYPE_HOCKEY):
		generateDisc()
	elif (enemy_type == TYPE_VOLLEY):
		createLaser()
	else:
		generateDefaultBall()
		restartBulletTimer()

func createLaser():
	var laser := Laser.instantiate() as Laser
	Global.game_controller.add_2d_scene_child(laser)

func generateBowlingBall():
	var bullet = createBowlingBall()
	Global.game_controller.add_2d_scene_child(bullet)
	
	if (min_balls_per_shot == 1):
		createAngleBowling(0, 1)
		createAngleBowling(1, 1)
		
	if (min_balls_per_shot == 2):
		createAngleBowling(0, 0)
		createAngleBowling(1, 0)
		createAngleBowling(0, 1)
		createAngleBowling(1, 1)

func createBowlingBall() -> BowlingBall:
	var bowlingBall := BowlingBall.instantiate() as BowlingBall
	if (throw_balloon == true):
		bowlingBall.type = 1
	bowlingBall.global_position = global_position
	# bowlingBall.ground_velocity = Vector2(100, 120)
	bowlingBall.vertical_velocity = 10
	bowlingBall.set_as_top_level(true)
	bowlingBall.parent_enemy = self
	return bowlingBall

func createAngleBowling(left : int, up: int):
	var bowlingBall = createBowlingBall()
	bowlingBall.left = left
	bowlingBall.up = up
	bowlingBall.offset_from_player = true
	Global.game_controller.add_2d_scene_child(bowlingBall)

func generateDefaultBall():
	var bullet = createBall()
	bullet.entropy = entropy
	Global.game_controller.add_2d_scene_child(bullet)
	
	if (min_balls_per_shot == 1):
		createAngleBullet(0.5)
		createAngleBullet(-0.5)
		
	if (min_balls_per_shot == 2):
		createAngleBullet(0.5)
		createAngleBullet(-0.5)
		createAngleBullet(1)
		createAngleBullet(-1)
		
func generateDisc():
	if (disc_active):
		disc_active = false
		var disc = createDisc()
		disc.entropy = entropy
		Global.game_controller.add_2d_scene_child(disc)
		active_disc = disc

func createBall() -> Bullet:
	var bullet := BulletScene.instantiate() as Bullet
	bullet.parryable = rng.randf_range(1,100) > unparriableChance
	bullet.global_position = global_position
	bullet.set_as_top_level(true)
	return bullet

func createDefaultDisc():
	var disc = createBall()
	disc.entropy = entropy
	Global.game_controller.add_2d_scene_child(disc)

func createDisc() -> HockeyDisc:
	var hockeyDisc := HockeyDiscScene.instantiate() as HockeyDisc
	hockeyDisc.parryable = rng.randf_range(1,100) > unparriableChance
	hockeyDisc.global_position = global_position
	hockeyDisc.set_as_top_level(true)
	return hockeyDisc

func createAngleBullet(angle: float):
	var bullet = createBall()
	bullet.angle = angle
	bullet.explodingBulletsQuantity = 3
	bullet.scale.x = 0.3
	bullet.scale.y = 0.3
	Global.game_controller.add_2d_scene_child(bullet)

func isAvailable():
	return parent_death_number >= wait_for_deaths
