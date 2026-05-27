class_name HeartRacketBoss extends Control

@onready var anim_sprite = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#anim_sprite.play("racket")
	pass # Replace with function body.

func change_sprite(index):
	if (index > 20):
		anim_sprite.frame = 24
	elif (index < 0):
		anim_sprite.frame = 0
	else:
		anim_sprite.frame = index
	# anim_sprite.play(anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
