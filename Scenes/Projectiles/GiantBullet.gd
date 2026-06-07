class_name GiantBullet extends Area2D

@export var speed = 250
#@export var speed = 200000
var velocity := Vector2.ZERO
var target_pos = Vector2.ZERO
var ExplosionAreaGroupScene = load("res://Scenes/Projectiles/ExplosionAreaGroup.tscn")

var converted = false
var previousConverted = false
var explodable = true
var angle = 0
var medium = false
var parryable = true

var acceleration = Vector2.ZERO

var steer_force = 100.0

#var explodingBulletsQuantity = RandomNumberGenerator.new().randf_range(10, 14)
var explodingBulletsQuantity = RandomNumberGenerator.new().randf_range(6, 10)


@export_enum("Normal:0", "None:1", "Intermediary:2", "Extreme:3") var entropy: int

var BulletScene = load("res://Scenes/Projectiles/Bullet.tscn")
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
		velocity = velocity.rotated(angle) * speed

func _physics_process(delta):
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	var desired = (player.position - position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	acceleration = steer
	velocity += acceleration * delta
	#velocity = velocity.clamp(Vector2(speed, speed), Vector2(speed, speed))
	self.global_position += velocity * delta
	
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
	if (body.is_in_group("Enemy") or body is Treinador) and converted:
		deal_damage_to_enemy(body)
		queue_free()

#Connect and deal damage to the player
func deal_damage_to_player(player : PlayerMain, forceDamage : bool = false):
	#if (!player.attacking or forceDamage):
	var damage = DAMAGE_SMALL_BULLET if !explodable else DAMAGE_LARGE_BULLET
	player._take_damage(damage)

func deal_damage_to_enemy(enemy):
	AudioManager.play_sound(AudioManager.ENEMY_HIT_DEFAULT, 0, 0)
	var damage = DAMAGE_SMALL_BULLET if !explodable else DAMAGE_LARGE_BULLET
	enemy._take_damage(damage, velocity)

func createExplosion(coords, invert):
	var explosionAreaGroup = ExplosionAreaGroupScene.instantiate() as ExplosionAreaGroup
	Global.game_controller.add_2d_scene_child(explosionAreaGroup)
	explosionAreaGroup.createExplosion(coords, invert)

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !(body is TileMap):
		return
		
	var local_pos = body.to_local(global_position)
	var tile_coords = body.local_to_map(local_pos)
	var tile_world_pos = body.map_to_local(tile_coords)
	
	var invert = false
	# GAMBIARRA :)
	if (tile_coords.y == 11 or tile_coords.x == -14):
		invert = false
	else:
		invert = true
	
	if (explodable and !converted):
		createExplosion(tile_world_pos, invert)
	queue_free()

func destroy():
	queue_free()
