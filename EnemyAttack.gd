class_name EnemyAttack extends Node2D

@export_enum("Normal:0", "Bowling:1", "Volley:2", "Hockey:3", "Basket:4") var enemy_type: int
@export_enum("Normal:0", "None:1", "Intermediary:2", "Extreme:3") var entropy: int

@export_enum("1", "3", "5") var min_balls_per_shot: int
@export_enum("1", "3", "5") var max_balls_per_shot: int

@export var throw_balloon: bool = false
@export var random: bool = false
@export var unparriableChance: int = 0
@export var bullet_interval: float = 2
@export var wait_to_attack: float = 0

var parent : EnemyMain

var rng = RandomNumberGenerator.new()

const TYPE_NORMAL = 0
const TYPE_BOWLING = 1
const TYPE_VOLLEY = 2
const TYPE_HOCKEY = 3
const TYPE_BASKET = 4

var disc_active = true
var active_disc : HockeyDisc
var original_modulate = self.modulate

var BulletScene = load("res://Scenes/Projectiles/Bullet.tscn")
var HockeyDiscScene = load("res://Scenes/Projectiles/HockeyDisc.tscn")
var BowlingBall = load("res://Scenes/Projectiles/BowlingBall.tscn")
var BasketBall = load("res://Scenes/Projectiles/BasketBall.tscn")
var Laser = load("res://Scenes/Projectiles/Laser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	stop_sprite()
	# TODO: GAMBIARRA PRA TIRAR VARIANCIA QUE ANIMAÇAO DE ATIRAR TRAS
	#$BulletTimer.wait_time = bullet_interval - 0.2 + wait_to_attack

func stop_sprite():
	$AnimatedSprite2D.visible = false

func start_sprite():
	$AnimatedSprite2D.visible = true
	match enemy_type:
		TYPE_NORMAL:
			$AnimatedSprite2D.scale.x = 0.35
			$AnimatedSprite2D.scale.y = 0.35
			$AnimatedSprite2D.play("ball")
		TYPE_BOWLING:
			$AnimatedSprite2D.scale.x = 0.35
			$AnimatedSprite2D.scale.y = 0.35
			if !throw_balloon:
				$AnimatedSprite2D.play("bowling")
			else:
				$AnimatedSprite2D.play("balloon")
		TYPE_BASKET:
			$AnimatedSprite2D.scale.x = 1
			$AnimatedSprite2D.scale.y = 1
			$AnimatedSprite2D.play("basket")

func create_bullet():
	createBullet()
	stop_sprite()

func createBullet():
	if (random == true):
		var randomResult = rng.randf_range(1,100)
		if (randomResult >= 1 and randomResult < 85):
			throw_balloon = false
			var isTriple = rng.randf_range(1,16) > 15
			if (isTriple):
				min_balls_per_shot = 1
				max_balls_per_shot = 1
			else:
				min_balls_per_shot = 0
				max_balls_per_shot = 0
			generateBullet(TYPE_NORMAL)
			return
		if (randomResult >= 85 and randomResult < 90):
			throw_balloon = false
			min_balls_per_shot = 0
			max_balls_per_shot = 0
			generateBullet(TYPE_BASKET)
			return
		if (randomResult >= 90 and randomResult < 95):
			throw_balloon = false
			min_balls_per_shot = 0
			max_balls_per_shot = 0
			generateBullet(TYPE_BOWLING)
			return
		
		throw_balloon = true
		min_balls_per_shot = 0
		max_balls_per_shot = 0
		generateBullet(TYPE_BOWLING)
	else:
		generateBullet(enemy_type)
		

func generateBullet(enemy_type2):
	if (enemy_type2 == TYPE_BOWLING):
		generateBowlingBall()
	elif (enemy_type2 == TYPE_HOCKEY):
		generateDisc()
	elif (enemy_type2 == TYPE_BASKET):
		generateBasketBall()
	else:
		generateDefaultBall()

func generateBasketBall():
	var bullet = createBasketBall()
	Global.game_controller.add_2d_scene_child(bullet)

func createBasketBall() -> BasketBall:
	var basketBall := BasketBall.instantiate() as BasketBall
	if (throw_balloon == true):
		basketBall.type = 1
	basketBall.global_position = global_position
	# basketBall.ground_velocity = Vector2(100, 120)
	basketBall.vertical_velocity = 10
	basketBall.set_as_top_level(true)
	basketBall.parent_enemy = parent
	return basketBall

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
	bowlingBall.parent_enemy = parent
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
