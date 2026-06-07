class_name ExplosionArea extends Node2D

var ShockwaveTres = load('res://Scenes/Projectiles/Shockwave.tres')

var exploding = false

func _ready():
	$Timer.start()
	# var points : PackedVector2Array = $ShockwaveCollision.polygon
	create_particles_node($GPUParticles2DBlack)
	$GPUParticles2DBlack.process_material.color = Color('#141101')
	create_particles_node($GPUParticles2D)
	$GPUParticles2D.process_material.color = Color('#e5d143')
	#particles.emission_points = points
	#particles.emitting = true

func create_particles_node(particles_node : GPUParticles2D):
	particles_node.process_material = ShockwaveTres.duplicate()
	particles_node.process_material.emission_shape_scale.y = 2.28
	particles_node.process_material.emission_box_extents.y = 40
	particles_node.process_material.emission_shape_offset.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Ensure the collision shape matches the ColorRect's global size
	# var rect_size = color_rect.size * color_rect.scale
	
	# Update the RectangleShape2D extents (extents are half the total size)
	# if collision_shape.shape is RectangleShape2D:
	#	collision_shape.shape.extents = rect_size / 2
	
	# Center the collision shape to the middle of the ColorRect
	# collision_shape.position = color_rect.position + (rect_size / 2)
	
	if (exploding):
		var scale = 40 * ($ExplodingTimer.wait_time - $ExplodingTimer.time_left)
		adjust_particles($GPUParticles2DBlack, 1000, scale)
		adjust_particles($GPUParticles2D, 4000, scale)
		
		# var points : PackedVector2Array = $ShockwaveCollision.polygon
		#particles.emission_points = points
		#particles.emitting = true

func adjust_particles(particles_node : GPUParticles2D, particles_amount_per_radius_size, scale):
	particles_node.amount = round(scale * particles_amount_per_radius_size)
	#particles_node.process_material.emission_shape_scale.x = scale
	particles_node.scale.x = scale
	$Area2D/CollisionShape2D.scale.x = particles_node.scale.x * 2.28
	# particles_node.process_material.emission_shape_scale = round($ShockwaveCollision.radius + $ShockwaveCollision.width / 2)

func _on_timer_timeout():
	exploding = true
	$ExplodingTimer.start()

func _on_exploding_timer_timeout():
	queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("Player") and exploding:
		var player = get_tree().get_first_node_in_group("Player") as PlayerMain
		if player.is_dashing():
			return
		deal_damage_to_player(body)

#Connect and deal damage to the player
func deal_damage_to_player(player : PlayerMain):
	player._take_damage(2)
