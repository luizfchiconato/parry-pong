class_name BowlingBall extends Area2D

@export var speed = 150
var velocity = Vector2.ZERO
var target_pos = Vector2.ZERO

var converted = false
var previousConverted = false
var explodable = true
var can_deflect = false
var parryable = true

var explodingBowlingBallsQuantity = 10

var BowlingBall = load("res://Scenes/BowlingBall/BowlingBall.tscn")
var Player = load("res://Scenes/Player/Player.tscn")
@onready var arch_body = $Body

@onready var anim_sprite = $ShadowSprite
@onready var anim_sprite_2 = $Body/BallSprite
@onready var explosion_radius = $ExplosionRadius

@onready var anim_bomb = $ExplosionRadius/AnimatedSprite2D
@onready var radius_bomb = $ExplosionRadius/MeshInstance2D
@onready var radius_bomb_internal = $ExplosionRadius/InternalMesh
@export var bomb_animator : AnimationPlayer

var fake_gravity = 10
@export var ground_velocity : Vector2
@export var vertical_velocity : float

@export var parent_enemy : EnemyMain
@export_enum("Bowling:0", "Balloon:1") var type: int = 0

var arcHeight = RandomNumberGenerator.new().randf_range(225, 225)
var duration = RandomNumberGenerator.new().randf_range(1.00, 1.5)

var t = 0.0

var isGrounded = false

var initial_position
var end_position

const DAMAGE_BOWLING = 2

var PaintSlime = load("res://Scenes/Projectiles/PaintSlimeCircle.tscn")
var instantiated_paint

#@export var animator : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite.play("default")
	if (type == 0):
		anim_sprite_2.play("default")
	else:
		anim_sprite_2.play("balloon")
		anim_sprite_2.scale = Vector2(0.85, 0.85)
		radius_bomb.visible = false
		radius_bomb_internal.visible = false
	#bomb_animator.play("default")
	
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	
	
	if (velocity == Vector2.ZERO):
		var target_pos = player.global_position
		self.rotation = target_pos.angle()
		
		var x_entropy = RandomNumberGenerator.new().randf_range(-50, 50)
		var y_entropy = RandomNumberGenerator.new().randf_range(-50, 50)
		
		initial_position = self.global_position
		end_position = Vector2(target_pos.x + x_entropy, target_pos.y + y_entropy)
		speed = initial_position.distance_to(end_position) / duration
		
		velocity = self.global_position.direction_to(end_position)
		
		explosion_radius.global_position = end_position

func initialize(groundVelocity, verticalVelocity):
	self.groundVelocity = groundVelocity
	self.verticalVelocity = verticalVelocity

func _physics_process(delta):
	if !converted:
		arch_movement(delta)
	
	if converted:
		if !previousConverted:
			convert_ball(delta)
		reflect_movement(delta)

func convert_ball(delta):
	radius_bomb.visible = false
	radius_bomb_internal.visible = false
	anim_sprite.visible = false

	previousConverted = true
	$Body/CPUParticles2D.set_color("#4ed4c2")
	anim_sprite_2.play("converted")
	#$Sprite2D.texture = load("res://Art/Sprites/ball_converted.png")
	if (is_instance_valid(parent_enemy)):
		var target_pos = parent_enemy.global_position
		self.rotation = target_pos.angle()
		
		var x_entropy = RandomNumberGenerator.new().randf_range(-30, 30)
		var y_entropy = RandomNumberGenerator.new().randf_range(-30, 30)
		
		var end_position = Vector2(target_pos.x + x_entropy, target_pos.y + y_entropy)
		velocity = self.global_position.direction_to(end_position) * 2
	else:
		queue_free()

func reflect_movement(delta):
	self.global_position += velocity * 200 * delta

func arch_movement(delta):
	explosion_radius.global_position = end_position
	vertical_velocity += fake_gravity * delta
	self.global_position += velocity * speed * delta

	t += delta / duration
	arch_body.global_position = _quadratic_bezier(initial_position, Vector2(initial_position.x, initial_position.y - arcHeight), end_position, t)
	
	check_y_level()

func check_y_level():
	if (self.global_position.y < arch_body.global_position.y):
		if (type == 0):
			explode()
		else:
			explode_paint()
	elif (self.global_position.y - 70 < arch_body.global_position.y and self.global_position.distance_to(end_position) < 90):
		can_deflect = true
		$ExplosionRadius/InternalMesh.modulate = Color("00baba3f")
	else:
		can_deflect = false
		$ExplosionRadius/InternalMesh.modulate = Color("f82a2a11")

func explode_paint():
	can_deflect = false
	instantiated_paint = PaintSlime.instantiate() as PaintSlime
	instantiated_paint.start_timer()

	instantiated_paint.scale = Vector2(4, 4)
	var player = get_tree().get_first_node_in_group("Player") as PlayerMain

	Global.game_controller.add_2d_scene_child(instantiated_paint)
	instantiated_paint.global_position = anim_sprite.global_position
	queue_free()

func explode():
	can_deflect = false
	clearRadius()
	#AudioManager.play_sound(AudioManager.BOWLING_FALL, 0, 0)
	#AudioManager.play_sound(AudioManager.SMALL_EXPLOSION, 0, -5, 0.4)
	bomb_animator.play("exploding")
	await bomb_animator.animation_finished
	queue_free()

func clearRadius():
	radius_bomb.visible = false
	radius_bomb_internal.visible = false
	anim_sprite.visible = false
	anim_sprite_2.visible = false

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return Vector2(self.global_position.x, r.y)

#Connect and deal damage to the player
func deal_damage_to_player(player : PlayerMain):
	if !player.attacking:
		player._take_damage(DAMAGE_BOWLING)

func deal_damage_to_enemy(enemy : EnemyMain):
	AudioManager.play_sound(AudioManager.ENEMY_HIT_BOWLING, 0, -15)
	enemy._take_damage(DAMAGE_BOWLING, velocity * 2)

func createBowlingBalls():
	for i in range(explodingBowlingBallsQuantity):
		var angle = i * (360 / explodingBowlingBallsQuantity)
		createBowlingBall(angle)

func createBowlingBall(angle: float):
	angle = deg_to_rad(angle)
	
	var bowlingBall: BowlingBall = duplicate()
	bowlingBall.global_position = global_position
	bowlingBall.velocity = -self.velocity
	bowlingBall.velocity = bowlingBall.velocity.rotated(angle)
	bowlingBall.set_as_top_level(true)
	bowlingBall.explodable = false
	bowlingBall.scale.x = 0.2
	bowlingBall.scale.y = 0.2
	Global.game_controller.add_2d_scene_child(bowlingBall)

#func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	if !(body is TileMap):
#		return

#	#if (explodable and !converted):
#	#	createBowlingBalls()
#	queue_free()


func _on_explosion_radius_body_entered(body):
	if body.is_in_group("Player") and !converted:
		var player = get_tree().get_first_node_in_group("Player") as PlayerMain
		if player.is_dashing():
			return
		deal_damage_to_player(body)
	if body.is_in_group("Enemy") and converted:
		deal_damage_to_enemy(body)


func _on_body_entered(body):
	if body.is_in_group("Enemy") and converted:
		deal_damage_to_enemy(body)
		queue_free()
