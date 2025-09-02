class_name Shockwave extends Area2D

var speed = 150
var second_count = 0
var frame_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var points : PackedVector2Array = $ShockwaveCollision.polygon
	#particles.emission_points = points
	#particles.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	second_count = second_count + delta
	frame_count = frame_count + 1
	
	if (frame_count >= 2):
		$ShockwaveCollision.radius = $ShockwaveCollision.radius + speed * second_count
		$GPUParticles2D.process_material.emission_ring_radius = round($ShockwaveCollision.radius + $ShockwaveCollision.width / 2)
		$GPUParticles2D.process_material.emission_ring_inner_radius = round($ShockwaveCollision.radius - $ShockwaveCollision.width / 2)
		$GPUParticles2D.amount = round($ShockwaveCollision.radius * 300)
		second_count = 0
		frame_count = 0
	
	var points : PackedVector2Array = $ShockwaveCollision.polygon
	#particles.emission_points = points
	#particles.emitting = true
	
	if ($ShockwaveCollision.radius > 500):
		queue_free()

func _on_body_entered(body):
	print("entrouuuuuuuu")
	if body.is_in_group("Player"):
		var player = get_tree().get_first_node_in_group("Player") as PlayerMain
		if player.is_dashing():
			return
		deal_damage_to_player(body)
		#queue_free()

#Connect and deal damage to the player
func deal_damage_to_player(player : PlayerMain):
	#var damage = DAMAGE_SMALL_BULLET if !explodable else DAMAGE_LARGE_BULLET
	player._take_damage(2)


func _on_mouse_entered():
	print("entrouuuuuuuu")
