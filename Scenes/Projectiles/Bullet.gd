class_name Bullet extends Area2D

@export var speed = 180
var velocity = Vector2.ZERO
var target_pos = Vector2.ZERO

var converted = false
var previousConverted = false
var explodable = true
var angle = 0
var medium = false
var parryable = true

var explodingBulletsQuantity = RandomNumberGenerator.new().randf_range(10, 14)

@export_enum("Normal:0", "None:1", "Intermediary:2", "Extreme:3") var entropy: int

var Bullet = load("res://Scenes/Projectiles/Bullet.tscn")
var Player = load("res://Scenes/Player/Player.tscn")

const DAMAGE_LARGE_BULLET = 2
const DAMAGE_SMALL_BULLET = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	
	if (!parryable):
		#$CPUParticles2D.set_color("#000000")
		$Sprite2D.texture = load("res://Art/Sprites/ball_black.png")
		explodingBulletsQuantity = RandomNumberGenerator.new().randf_range(3, 8)
	
	if (velocity == Vector2.ZERO):
		var target_pos = player.global_position
		self.rotation = target_pos.angle()
		
		var x_entropy = 0
		var y_entropy = 0
		
		if (entropy == 0):
			x_entropy = RandomNumberGenerator.new().randf_range(-15, 15)
			y_entropy = RandomNumberGenerator.new().randf_range(-15, 15)
			
		if (entropy == 2):
			x_entropy = RandomNumberGenerator.new().randf_range(-50, 50)
			y_entropy = RandomNumberGenerator.new().randf_range(-50, 50)
			
		if (entropy == 3):
			x_entropy = RandomNumberGenerator.new().randf_range(-75, 75)
			y_entropy = RandomNumberGenerator.new().randf_range(-75, 75)
		
		var end_position = Vector2(target_pos.x + x_entropy, target_pos.y + y_entropy)
		velocity = self.global_position.direction_to(end_position)
		velocity = velocity.rotated(angle)

func _physics_process(delta):
	self.global_position += velocity * speed * delta
	
	if converted and !previousConverted:
		previousConverted = true
		$CPUParticles2D.set_color("#4ed4c2")
		$CPUParticles2D.amount = $CPUParticles2D.amount * 4
		$Sprite2D.texture = load("res://Art/Sprites/ball_converted.png")

func _on_body_entered(body):
	if body.is_in_group("Player") and !converted:
		var player = get_tree().get_first_node_in_group("Player") as PlayerMain
		if player.is_dashing():
			return
		deal_damage_to_player(body, !parryable)
		queue_free()		
	if body.is_in_group("Enemy") and converted:
		deal_damage_to_enemy(body)
		queue_free()

#Connect and deal damage to the player
func deal_damage_to_player(player : PlayerMain, forceDamage : bool = false):
	#if (!player.attacking or forceDamage):
	var damage = DAMAGE_SMALL_BULLET if !explodable else DAMAGE_LARGE_BULLET
	player._take_damage(damage)

func deal_damage_to_enemy(enemy : EnemyMain):
	AudioManager.play_sound(AudioManager.ENEMY_HIT_DEFAULT, 0, 0)
	var damage = DAMAGE_SMALL_BULLET if !explodable else DAMAGE_LARGE_BULLET
	enemy._take_damage(damage, velocity)

func createBullets():
	for i in range(explodingBulletsQuantity):
		var angle = i * (360 / explodingBulletsQuantity)
		createBullet(angle)

func createBullet(angle: float):
	angle = deg_to_rad(angle)
	var bullet: Bullet = duplicate()
	bullet.global_position = global_position
	bullet.velocity = -self.velocity
	bullet.velocity = bullet.velocity.rotated(angle)
	bullet.set_as_top_level(true)
	bullet.explodable = false
	bullet.scale.x = 0.2
	bullet.scale.y = 0.2
	bullet.parryable = parryable
	Global.game_controller.add_2d_scene_child(bullet)

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !(body is TileMap):
		return

	if (explodable and !converted):
		createBullets()
	queue_free()
	
func destroy():
	queue_free()
