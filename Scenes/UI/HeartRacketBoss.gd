class_name HeartRacketBoss extends Control

@onready var anim_sprite = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#anim_sprite.play("racket")
	pass # Replace with function body.

func change_sprite(index):
	var frame
	if (index > 19):
		frame = 25
	elif (index < 0):
		frame = 0
	else:
		frame = index
	var tween = create_tween()
	tween.tween_property(anim_sprite, "frame", frame, 0.05 * (frame - anim_sprite.frame))
	#anim_sprite.frame = frame
	# anim_sprite.play(anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
