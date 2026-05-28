extends State
class_name enemy_idle_state

@export var animator : AnimationPlayer
@export var boss_arm: bool = false

@onready var enemy = $"../.."
@onready var sprite = $"../../AnimatedSprite2D"
const TYPE_NORMAL = 0
const TYPE_BOWLING = 1

func Enter():
	if boss_arm:
		sprite.play("Arm")
	elif enemy.enemy_type == TYPE_BOWLING:
		sprite.play("IdleBowling")
	else:
		sprite.play("Idle")
	pass

func Update(_delta):
	pass
