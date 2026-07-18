extends CharacterBase
class_name EnemyMain

@onready var fsm = $FSM as FiniteStateMachine
var player_in_range = false
var rng = RandomNumberGenerator.new()

@export var attack_node : Node
@export var chase_node : Node

@export var bullet_interval: float = 2
@export var wait_to_attack: float = 0

@export var wait_for_deaths: int = 0

@export var unparriableChance: int = 0
@export var max_health: int = 6
@export var stationary: bool = false

@export var random: bool = false
@export var boss_arm: bool = false

var original_modulate = self.modulate

#@onready var animator = $AnimationPlayer

@export_enum("Normal:0", "Bowling:1", "Volley:2", "Hockey:3", "Basket:4") var enemy_type: int
@export_enum("Normal:0", "None:1", "Intermediary:2", "Extreme:3") var entropy: int

@export_enum("1", "3", "5") var min_balls_per_shot: int
@export_enum("1", "3", "5") var max_balls_per_shot: int

@export var throw_balloon: bool = false

var parent_death_number: int = 0
var dying = false

const TYPE_NORMAL = 0
const TYPE_BOWLING = 1
const TYPE_VOLLEY = 2
const TYPE_HOCKEY = 3
const TYPE_BASKET = 4

signal died
signal damage

const speed = 200
var death_velocity : Vector2

@onready var EnemyAttack = $AnimatedSprite2D/EnemyAttack
#var EnemyAttack = load("res://Scenes/MainMenu/LevelSelector/LevelSelect.tscn")

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

func _on_bullet_timer_timeout():
	if (!isAvailable()):
		return
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

#Return to idle when player leaves our proximity
func _on_detection_area_body_exited(body):
	if (!isAvailable()):
		return
	
	if body.is_in_group("Player"):
		player_in_range = false
		if (is_instance_valid(fsm) and is_instance_valid(chase_node) and fsm.current_state.name != "enemy_death_state"):
			fsm.force_change_state("enemy_idle_state")
		

func increment_death_number():
	parent_death_number = parent_death_number + 1
	if (isAvailable()):
		activateEnemy()

func activateEnemy():
	if boss_arm:
		$AnimatedSprite2D.play("Arm")
	elif enemy_type == TYPE_BOWLING:
		$AnimatedSprite2D.play("IdleBowling")
	else:
		$AnimatedSprite2D.play("Idle")
	#animator.play("Idle")
	self.z_index = 5
	$AnimatedSprite2D.modulate.a = 1
	$AnimatedSprite2D.scale.x = 1
	$AnimatedSprite2D.scale.y = 1
	$HealthBar.visible = true
	
	if($BodyCollider.disabled == true):
		$BodyCollider.set_deferred("disabled", false)
		# TODO: VERIFICAR
		$BulletTimer.wait_time = bullet_interval - 0.2 + wait_to_attack
		$BulletTimer.start()
	
	

func die(newVelocity):
	AudioManager.play_sound(AudioManager.ENEMY_SPUN, 0, -5)
	fsm.force_change_state("enemy_death_state")
	death_velocity = newVelocity
	$BodyCollider.set_deferred("disabled", true)
	$AnimatedSprite2D.play("Thrown")
	
	if (!dying):
		emit_signal("died")
	dying = true
	# TODO: VERIFICAR O QUE
	kill()

func kill():
	print("die ", EnemyAttack.uid)
	EnemyAttack.queue_free()
	queue_free()


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
	emit_signal("damage", amount, Vector2(0, 0))
	if(health <= 0 and !boss_arm):
		die(deathVelocity)
	
func _ready():
	# TODO: isso é um lixo mas provavelmente nunca vou mudar
	EnemyAttack.enemy_type = enemy_type
	EnemyAttack.entropy = entropy
	EnemyAttack.min_balls_per_shot = min_balls_per_shot
	EnemyAttack.max_balls_per_shot = max_balls_per_shot
	EnemyAttack.throw_balloon = throw_balloon
	EnemyAttack.random = random
	EnemyAttack.unparriableChance = unparriableChance
	EnemyAttack.bullet_interval = bullet_interval
	EnemyAttack.parent = self
	EnemyAttack.uid = RandomNumberGenerator.new().randf_range(0, 1000000000)
	
	if boss_arm:
		$AnimatedSprite2D.play("Arm")
	$FSM/enemy_idle_state.boss_arm = boss_arm
	$FSM/enemy_chase_state.boss_arm = boss_arm
	if (boss_arm):
		$HealthBar.visible = false

	$HealthBar.max_health = max_health
	$HealthBar.health = max_health
	$HealthBar.setHealthBar()
	health = max_health
	
	# TODO: GAMBIARRA PRA TIRAR VARIANCIA QUE ANIMAÇAO DE ATIRAR TRAS
	$BulletTimer.wait_time = bullet_interval - 0.2 + wait_to_attack

	if wait_for_deaths > 0:
		self.z_index = 0
		deactivateEnemy()
	else:
		self.z_index = 5
		$BulletTimer.autostart = true
		$BulletTimer.start()
		#EnemyAttack.activateAttack()




func deactivateEnemy():
	$AnimatedSprite2D.play("Hidden")
	#animator.play("Hidden")
	$AnimatedSprite2D.modulate.a = 0.7
	$AnimatedSprite2D.scale.x = 0.7
	$AnimatedSprite2D.scale.y = 0.7
	$HealthBar.visible = false
	$BodyCollider.set_deferred("disabled", true)

func isAvailable():
	return parent_death_number >= wait_for_deaths
