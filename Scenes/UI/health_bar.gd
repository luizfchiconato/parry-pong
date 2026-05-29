class_name HealthBar extends Node2D

@export var max_health = 6
@export var health = 6
var health_parts = 2
var HeartRacketBoss = load("res://Scenes/UI/HeartRacketBoss.tscn")

var heartsArray = Array()
var hearts_number

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func setHealthBar():
	hearts_number = ceil(max_health / health_parts)
	print(hearts_number)
	health = clamp(health, 0, max_health)
	
	for x in hearts_number:
		print("x ", x)
		var heart := HeartRacketBoss.instantiate() as HeartRacketBoss
		heart.anim_frame_duration = 0.04
		$CenterContainer/HBoxContainer.add_child(heart)
		heartsArray.push_back(heart)
	print("heartsArray ", heartsArray)
	updateHearts()

func removeHealth(amount):
	health = health - amount
	updateHearts()

func addHealth(amount):
	health = health + amount
	updateHearts()
	
func setHealth(health):
	#print("setHealth", health)
	self.health = health
	updateHearts()

func updateHearts():
	print("hearts_number", hearts_number)
	for x in hearts_number:
		var heart = heartsArray[x]
		var containerNumber = x + 1
		print("updateHearts", hearts_number, " ", health, " ", health_parts, " ", max_health / health_parts, " ", containerNumber)
		# 8 - 2 * (4 - 1)
		var healthContainer = health - health_parts * (hearts_number - containerNumber)
		print("heart ", containerNumber, " is ", healthContainer, " and frame ", 20 - (healthContainer * 5))
		heart.change_sprite(20 - (healthContainer * 10))
		
		#if ceil(health / 2.0) <= (containerNumber - 1):
		#	heart.change_sprite("empty")
		#elif health / 2.0  >= containerNumber:		
		#	heart.change_sprite("full")
		#else:
		#	heart.change_sprite("half")
