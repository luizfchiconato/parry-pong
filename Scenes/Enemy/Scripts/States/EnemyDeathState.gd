extends State

@export var animator : AnimationPlayer
@onready var body = $"../.."
@onready var particles = $"../../AnimatedSprite2D/DeathParticles2D"
@onready var wallHitParticles = $"../../AnimatedSprite2D/HitWallParticles"

@export var move_speed := float(11000)
var smashing = false

func Enter():
	particles.emitting = true
	pass

func Update(_delta):
	if smashing:
		return
	body.velocity = body.death_velocity * move_speed * _delta
	body.move_and_slide()
	
	#if (body.is_on_wall()):
	#	smashing = true
	#	die()
	#particles.amount += 10
	#pass

func _on_wall_hit_detector_body_entered(body):
	if !(body is TileMap):
		return
	smashing = true
	die()

func die():
	body.velocity = Vector2.ZERO
	var soundEffect
	wallHitParticles.emitting = true
	await get_tree().create_timer(0.1).timeout
	if randf_range(1, 2) == 1:
		AudioManager.play_sound(AudioManager.WALL_SMASH_1, 0, -15)
	else:
		AudioManager.play_sound(AudioManager.WALL_SMASH_2, 0, -3)
	await get_tree().create_timer(0.3).timeout
	if is_instance_valid(self):
		body.kill()
