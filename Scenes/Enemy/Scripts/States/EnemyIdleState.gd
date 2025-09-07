extends State
class_name enemy_idle_state

@export var animator : AnimationPlayer

@onready var enemy = $"../.."
@onready var sprite = $"../../AnimatedSprite2D"
const TYPE_NORMAL = 0
const TYPE_BOWLING = 1

func Enter():
	if enemy.enemy_type == TYPE_BOWLING:
		sprite.play("IdleBowling")
	else:
		sprite.play("Idle")
	pass

func Update(_delta):
	pass
