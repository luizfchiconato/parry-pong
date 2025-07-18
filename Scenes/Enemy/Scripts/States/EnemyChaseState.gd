extends State
class_name enemy_chase_state

@export var attack_range := float(50)
@export var move_speed := float(40)

@export var animator : AnimationPlayer
@onready var body = $"../.."
@onready var enemy = $"../.."
@onready var sprite = $"../../AnimatedSprite2D"
const TYPE_NORMAL = 0
const TYPE_BOWLING = 1

func Enter():
	#sanimator.play("Chasing")
	print("WALK")
	if enemy.enemy_type == TYPE_BOWLING:
		sprite.play("WalkBowling")
		#sprite.play("BossTest")
	else:
		sprite.play("Walk")
		#sprite.play("BossTest")

func Update(_delta):
	var player = get_tree().get_nodes_in_group("Player")[0]  as CharacterBody2D
	var chase_direction = player.position - body.position as Vector2

	body.velocity = -chase_direction.normalized() * move_speed
	body.move_and_slide()
	
	#if(chase_direction.length() <= attack_range):
	#	state_transition.emit(self, "enemy_attack_state")
		
