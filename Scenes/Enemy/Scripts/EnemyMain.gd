extends CharacterBase
class_name EnemyMain

@onready var fsm = $FSM as FiniteStateMachine
var player_in_range = false
var rng = RandomNumberGenerator.new()

@export var attack_node : Node
@export var chase_node : Node

@export var bullet_interval: float = 2

@export var wait_for_deaths: int = 0

@onready var animator = $AnimationPlayer

@export_enum("Normal:0", "Bowling:1", "Volley:2") var enemy_type: int
@export_enum("Normal:0", "None:1", "Intermediary:2", "Extreme:3") var entropy: int

@export_enum("1", "3", "5") var min_balls_per_shot: int
@export_enum("1", "3", "5") var max_balls_per_shot: int

var parent_death_number: int = 0

signal died

const TYPE_NORMAL = 0
const TYPE_BOWLING = 1
const TYPE_VOLLEY = 2

var Bullet = load("res://Scenes/Projectiles/Bullet.tscn")
var BowlingBall = load("res://Scenes/BowlingBall/BowlingBall.tscn")
var Laser = load("res://Scenes/Projectiles/Laser.tscn")

#After finishing an attack, we return here to determine our next action based on the players proximity
func finished_attacking():
	if(player_in_range == true):
		fsm.change_state(attack_node, "enemy_chase_state")
	else:
		fsm.change_state(attack_node, "enemy_idle_state")

#Register player proximity, start chasing if we are idling when the player gets close
func _on_detection_area_body_entered(body):
	if (!isAvailable()):
		return
	
	print("entrou")
	if body.is_in_group("Player"):
		player_in_range = true
		print(is_instance_valid(fsm), is_instance_valid(chase_node))
		
		#We don't want this to happen from the death state, only from idle
		#if fsm.current_state.name == "enemy_idle_state": 
		print("entrando chase")
			
		fsm.force_change_state("enemy_chase_state")

#Return to idle when player leaves our proximity
func _on_detection_area_body_exited(body):
	if (!isAvailable()):
		return
	
	print("saiu")	
	if body.is_in_group("Player"):
		player_in_range = false
		print(is_instance_valid(fsm), is_instance_valid(chase_node))
		if (is_instance_valid(fsm) and is_instance_valid(chase_node)):
			print("entrando idle")
			fsm.force_change_state("enemy_idle_state")
		

func increment_death_number():
	parent_death_number = parent_death_number + 1
	if (isAvailable()):
		activateEnemy()

func activateEnemy():
	if enemy_type == TYPE_BOWLING:
		$AnimatedSprite2D.play("IdleBowling")
	else:
		$AnimatedSprite2D.play("Idle")
	#animator.play("Idle")
	$AnimatedSprite2D.modulate.a = 1
	$AnimatedSprite2D.scale.x = 1
	$AnimatedSprite2D.scale.y = 1
	$HealthBar.visible = true
	$BodyCollider.set_deferred("disabled", false)

func _die():
	super() #calls _die() on base-class CharacterBase
	fsm.force_change_state("enemy_death_state")
	emit_signal("died")

func _take_damage(amount):
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
		_die()
	
func _ready():
	if wait_for_deaths > 0:
		deactivateEnemy()
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
	var my_random_number

	#if (enemy_type == TYPE_BOWLING):
	#	my_random_number = rng.randf_range(1.5, 2.75)
	#else:
	#	my_random_number = rng.randf_range(1.5, 2)
		
	my_random_number = rng.randf_range(bullet_interval - bullet_interval * 0.2, bullet_interval + bullet_interval * 0.2)

	$BulletTimer.wait_time = my_random_number
	$BulletTimer.start()
	return true

func createBullet():
	if (!isAvailable()):
		return
	
	if (enemy_type == TYPE_BOWLING):
		createBowlingBall()
	elif (enemy_type == TYPE_VOLLEY):
		createLaser()
	else:
		createDefaultBall()

func createLaser():
	var laser := Laser.instantiate() as Laser
	self.add_child(laser)

func createBowlingBall():
	var bullet := BowlingBall.instantiate() as BowlingBall
	bullet.global_position = global_position
	# bullet.ground_velocity = Vector2(100, 120)
	bullet.vertical_velocity = 10
	bullet.set_as_top_level(true)
	bullet.parent_enemy = self
	self.add_child(bullet)
	
func createDefaultBall():
	var bullet := Bullet.instantiate() as Bullet
	bullet.global_position = global_position
	bullet.set_as_top_level(true)
	bullet.entropy = entropy
	self.add_child(bullet)
	
	print(min_balls_per_shot)
	
	if (min_balls_per_shot == 1):
		createAngleBullet(0.5)
		createAngleBullet(-0.5)
		
	if (min_balls_per_shot == 2):
		createAngleBullet(0.5)
		createAngleBullet(-0.5)
		createAngleBullet(1)
		createAngleBullet(-1)

func createAngleBullet(angle: float):
	var bullet := Bullet.instantiate() as Bullet
	bullet.global_position = global_position
	bullet.set_as_top_level(true)
	bullet.angle = angle
	bullet.explodingBulletsQuantity = 3
	bullet.scale.x = 0.3
	bullet.scale.y = 0.3
	self.add_child(bullet)

func isAvailable():
	return parent_death_number >= wait_for_deaths
