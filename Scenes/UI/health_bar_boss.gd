class_name HealthBarBoss extends Node2D

@export var max_health = 120
@export var health = 120
var health_parts = 20

var HeartRacketBoss = load("res://Scenes/UI/HeartRacketBoss.tscn")

var heartsArray = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	setHealthBar()
	
func setHealthBar():
	var hearts_number = ceil(max_health / health_parts)
	health = clamp(health, 0, max_health)
	
	for x in hearts_number:
		#print('teste', x)
		var heart := HeartRacketBoss.instantiate() as HeartRacketBoss
		#heart.global_position.x = self.global_position.x + 30 * x
		#heart.global_position.y = self.global_position.y
		#heart.position.x = heart.position.x + 30 * x
		#heart.scale.x = 2
		#heart.scale.y = 2
		$CenterContainer/HBoxContainer.add_child(heart)
		heartsArray.push_back(heart)
	
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
	var hearts_number = ceil(max_health / health_parts)
	#print("setHealth", hearts_number)
	
	for x in hearts_number:
		var heart = heartsArray[x]
		var containerNumber = x + 1
		#print("updateHearts", hearts_number, " ", health, " ", health_parts, " ", max_health / health_parts, " ", containerNumber)
		
		var healthContainer = health - health_parts * (hearts_number - containerNumber)
		#print("heart ", containerNumber, " is ", healthContainer, " and frame ", 20 - healthContainer)
		heart.change_sprite(20 - healthContainer)
		
		#if ceil(health / 2.0) <= (containerNumber - 1):
		#	heart.change_sprite("empty")
		#elif health / 2.0  >= containerNumber:		
		#	heart.change_sprite("full")
		#else:
		#	heart.change_sprite("half")
