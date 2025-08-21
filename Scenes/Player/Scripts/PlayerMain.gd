extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine
@onready var moving = $FSM/Moving as State
@onready var animatedSprite = $AnimatedSprite2D as AnimatedSprite2D
@onready var racketPivot = $AnimatedSprite2D/RacketPivot as Node2D
@onready var trail = $AnimatedSprite2D/RacketPivot/Racket/Marker2D/Trail2D as Line2D
#@onready var racketParticles = $AnimatedSprite2D/RacketPivot/Racket/Particles as CPUParticles2D
@onready var hitbox = $AnimatedSprite2D/Hitboxes/Racket_Hitbox as Node2D
@onready var hitboxShape = $AnimatedSprite2D/Hitboxes/Racket_Hitbox/hitboxShape as CollisionShape2D
@onready var racketAnimator = $AnimatedSprite2D/RacketPivot/Racket/Animation as AnimatedSprite2D

const DEATH_SCREEN = preload("res://Scenes/UI/LevelFail.tscn")

var attacking = false
var attackFrame = 0
const attackFrames = 10

var hitInAttack = false
var canAttack = true
var reverted_attack = false

var original_modulate
var paint_tween

var DAMAGE_PAINT = 2

func _ready():
	$HealthBar.setHealthBar()

func _physics_process(delta: float) -> void:
	turn()

	if (attackFrame > attackFrames):
		deactivateAttack()
		attackFrame = 0
		hitboxShape.disabled = true
	elif (attacking):
		attackFrame += 1
	elif (Input.is_action_just_pressed("MouseLeft") or Input.is_action_just_pressed("MouseRight")) and (canAttack or hitInAttack):
		reverted_attack = Input.is_action_just_pressed("MouseRight")
		attack()
	
	if attacking == true:
		racketPivot.rotation += 20 * delta
		#trail.visible = true
		#if racketParticles.amount != 1200:
		#	racketParticles.amount = 1200
		#	racketParticles.spread = 50
	else:
		hitbox.rotation = getRacketAngle() - 90
		racketPivot.rotation = getRacketAngle()
		#trail.visible = false
		#if racketParticles.amount != 30:
		#	racketParticles.amount = 30
		#	racketParticles.spread = 23

func turn():
	#var direction = -1 if flipped_horizontal == true else 1
	if(getAngleDegrees() > -90 and getAngleDegrees() < 90):
		sprite.scale.x = 1
	else:
		sprite.scale.x = -1

func getAngle():
	var player_pos = self.global_position
	var mouse_pos = getMousePos()
	var angle = player_pos.angle_to_point(mouse_pos)
	return angle

func isToLeft():
	var angleLeft = getAngleDegrees() > -90 and getAngleDegrees() < 90
	return angleLeft

func getMousePos():
	var player_pos = self.global_position
	var mouse_pos = get_global_mouse_position()
	if (attackingReverted()):
		mouse_pos = Vector2(player_pos.x - (mouse_pos.x - player_pos.x), player_pos.y - (mouse_pos.y - player_pos.y))
	return mouse_pos

func attackingReverted():
	return reverted_attack

func getAngleDegrees():
	return rad_to_deg(getAngle())

func getRacketAngle():
	if (isToLeft()):
		return getAngle() + 90
	return -(getAngle() + 90)

func attack():
	#var rotation_subtract = 270 if reverted_attack else 90
	racketPivot.rotation = getRacketAngle() - 90
	
	hitbox.rotation = getRacketAngle() - 90
	hitboxShape.disabled = false
	
	attacking = true
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, 1)
	
func _on_hitbox_body_entered(body):
	if (!attacking):
		return

	if body is HockeyDisc:
		hitInAttack = true
		reflectDisk(body)
	
	if body is Bullet:
		if (!body.parryable):
			return
		#$Camera2D.set_trauma(0.2)
		hitInAttack = true
		reflectBullet(body)
	
	if body is BowlingBall:
		#$Camera2D.set_trauma(0.3)
		hitInAttack = true
		reflectBowlingBall(body)

func set_trauma(amount):
	$Camera2D.set_trauma(amount)

func reflectBullet(body):
	if (!body.converted):
		var mouseVelocity = body.global_position.direction_to(getMousePos())
		body.velocity = (3 * mouseVelocity + (-body.velocity))
		body.converted = true
		#frameFeeze(0.05, 0.5)
		AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 4, 5, 0.7)

func reflectDisk(body):
	var mouseVelocity = body.global_position.direction_to(getMousePos())
	body.velocity = (1.5 * mouseVelocity + (-1 * 0.6 * body.velocity))
	body.converted = true
	#frameFeeze(0.05, 0.5)
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 4, 5, 0.7)

func reflectBowlingBall(body):
	if (!body.converted and body.can_deflect):
		body.converted = true
		#frameFeeze(0.05, 0.5)
		AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 4, 5, 0.4)

	#if body.is_in_group("Enemy"):
	#	#frameFeeze(0.05, 0.9)
	#	deal_damage(body)a
	#	print("blaa")
		

func _take_damage(amount):
	if(is_dashing() || invincible == true || is_dead == true):
		return
		
	health -= amount
	healthbar.value = health;
	damage_effects()
	
	$HealthBar.removeHealth(amount)
	
	AudioManager.play_sound(AudioManager.PLAYER_HURT, 0, 0)
	
	if(health <= 0):
		_die()

func is_dashing():
	return moving.is_dashing

func deal_damage(enemy : EnemyMain):
	hit_particles.emitting = true
	# enemy._take_damage(50)

func _die():
	super() #calls _die() on base-class CharacterBase
	
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)
	
	#Global.game_controller.change_gui_scene(DEATH_SCREEN)

func frameFeeze(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration * timeScale).timeout
	Engine.time_scale = 1

func activateAttack():
	canAttack = true
	#racketParticles.visible = true
	trail.visible = true
	racketAnimator.play("Default")
	
func deactivateAttack():
	reverted_attack = false
	attacking = false
	if (!hitInAttack):
		canAttack = false
		$AttackTimeout.start()
		#racketParticles.visible = false
		racketAnimator.play("Deactivated")
		trail.visible = false
	hitInAttack = false

func _on_attack_timeout_timeout():
	activateAttack()

var active_paint_instances_number = 0

func entered_paint(paint_instance : PaintSlime):
	active_paint_instances_number = active_paint_instances_number + 1
	if (active_paint_instances_number == 1):
		startHitTimeout()

func startHitTimeout():
	original_modulate = self.modulate
	$PaintHitTimer.start()
	print($PaintHitTimer.is_stopped())
	paint_tween = create_tween()
	paint_tween.tween_property(self, "modulate", Color.RED, $PaintHitTimer.wait_time)

func exited_paint(paint_instance):
	active_paint_instances_number = active_paint_instances_number - 1
	if (active_paint_instances_number == 0):
		stopHitTimeout()

func stopHitTimeout():
	self.modulate = original_modulate
	$PaintHitTimer.stop()
	if (paint_tween != null):
		paint_tween.stop()

func _on_hit_timeout_timeout():
	_take_damage(DAMAGE_PAINT)
	stopHitTimeout()
	startHitTimeout()
