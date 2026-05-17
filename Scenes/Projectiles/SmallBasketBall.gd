class_name SmallBasketBall extends Area2D



var velocity = Vector2.ZERO
var target_pos = Vector2.ZERO

var converted = false
var previousConverted = false
var explodable = true
var can_deflect = true
var parryable = true
var timeEllapsed = 0
var endlog = false

var explodingBowlingBallsQuantity = 10

var BasketBall = load("res://Scenes/Projectiles/BasketBall.tscn")
var Player = load("res://Scenes/Player/Player.tscn")
var Explosion = load("res://Scenes/Projectiles/Explosion.tscn")
@onready var arch_body = $Body

@onready var anim_sprite = $ShadowSprite
@onready var anim_sprite_2 = $Body/BallSprite
@export var bomb_animator : AnimationPlayer

var fake_gravity = 5
@export var ground_velocity : Vector2
@export var vertical_velocity : float

@export var parent_enemy : EnemyMain
@export_enum("Bowling:0", "Balloon:1") var type: int = 0

@export var speed = 200
var arcHeight = RandomNumberGenerator.new().randf_range(1200, 1200)
var duration = 2

var t = 0.0

var isGrounded = false

var initial_position
var end_position

const DAMAGE_BOWLING = 2

var offset_from_player = true
var left = 0
var up = 0


var explosion : Explosion
var instantiated_paint

#@export var animator : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#explosion_radius.visible = false
	anim_sprite.play("default")
	if (type == 0):
		anim_sprite_2.play("default")
	else:
		anim_sprite_2.play("balloon")
		anim_sprite_2.scale = Vector2(0.85, 0.85)
	#bomb_animator.play("default")
	
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	
	if (velocity == Vector2.ZERO):
		var x_player_entropy = RandomNumberGenerator.new().randf_range(0, 150)
		var y_player_entropy = RandomNumberGenerator.new().randf_range(0, 150)
		
		var target_pos
		if (!offset_from_player):
			target_pos = player.global_position
		else:
			if (left == 1 and up == 1):
				target_pos = Vector2(player.global_position.x - x_player_entropy, player.global_position.y - y_player_entropy)
			elif (left == 1 and up == 0):
				target_pos = Vector2(player.global_position.x - x_player_entropy, player.global_position.y + y_player_entropy)
			elif (left == 0 and up == 1):
				target_pos = Vector2(player.global_position.x + x_player_entropy, player.global_position.y - y_player_entropy)
			else:
				target_pos = Vector2(player.global_position.x + x_player_entropy, player.global_position.y + y_player_entropy)
		self.rotation = target_pos.angle()
		
		var x_entropy = RandomNumberGenerator.new().randf_range(-50, 50)
		var y_entropy = RandomNumberGenerator.new().randf_range(-50, 50)
		
		initial_position = self.global_position
		end_position = Vector2(target_pos.x + x_entropy, target_pos.y + y_entropy)
		velocity = self.global_position.direction_to(end_position)
		speed = initial_position.distance_to(end_position) / duration
		#speed = initial_position.distance_to(Vector2(initial_position.x + velocity.x, initial_position.y + velocity.y)) * 150 / duration

	explosion = Explosion.instantiate() as Explosion
	Global.game_controller.add_2d_scene_child(explosion)
	explosion.global_position = end_position
	explosion.showPaint()
	explosion.scale = self.scale

func _physics_process(delta):
	if !converted:
		arch_movement(delta)
	if converted:
		if !previousConverted:
			convert_ball(delta)
		reflect_movement(delta)

func convert_ball(delta):
	anim_sprite.visible = false

	previousConverted = true
	$Body/CPUParticles2D.set_color("#4ed4c2")
	if (type != 1):
		anim_sprite_2.play("converted")
	else:
		anim_sprite_2.play("balloon_converted")
	#$Sprite2D.texture = load("res://Art/Sprites/ball_converted.png")
	if (is_instance_valid(parent_enemy)):
		var target_pos = parent_enemy.global_position
		self.rotation = target_pos.angle()
		
		var x_entropy = RandomNumberGenerator.new().randf_range(-30, 30)
		var y_entropy = RandomNumberGenerator.new().randf_range(-30, 30)
		
		var end_position = Vector2(target_pos.x + x_entropy, target_pos.y + y_entropy)
		velocity = self.global_position.direction_to(end_position)
	else:
		queue_free()

func reflect_movement(delta):
	self.global_position += velocity * 200 * delta

func arch_movement(delta):
	timeEllapsed = timeEllapsed + delta
	#explosion_radius.global_position = end_position
	# vertical_velocity += fake_gravity * delta
	self.global_position += velocity * speed * delta

	t += delta / duration
	#arch_body.global_position = _quadratic_bezier(initial_position, Vector2(initial_position.x, initial_position.y - arcHeight), end_position, t)
	arch_body.global_position = _quadratic_bezier(
		initial_position, 
		Vector2(initial_position.x, initial_position.y - arcHeight),
		end_position,
		t)

	check_y_level()

func check_y_level():
	if (self.global_position.y < arch_body.global_position.y):
		initial_position = self.global_position 
		t = 0
		explode()
		queue_free()


func explode():
	# explosion.global_position = arch_body.global_position
	
	explosion.explode()
	

func clearRadius():
	anim_sprite.visible = false
	anim_sprite_2.visible = false

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return Vector2(self.global_position.x, r.y)


func createBowlingBalls():
	for i in range(explodingBowlingBallsQuantity):
		var angle = i * (360 / explodingBowlingBallsQuantity)
		createBowlingBall(angle)

func createBowlingBall(angle: float):
	angle = deg_to_rad(angle)
	
	var basketBall: BasketBall = duplicate()
	basketBall.global_position = global_position
	basketBall.velocity = -self.velocity
	basketBall.velocity = basketBall.velocity.rotated(angle)
	basketBall.set_as_top_level(true)
	basketBall.explodable = false
	basketBall.scale.x = 0.2
	basketBall.scale.y = 0.2
	Global.game_controller.add_2d_scene_child(basketBall)


