extends CharacterBody2D
class_name CharacterBase

@export var sprite : AnimatedSprite2D
@export var healthbar : ProgressBar
@export var health : int
@export var flipped_horizontal : bool
@export var hit_particles : GPUParticles2D
@export var block_turn : bool
var invincible : bool = false
var is_dead : bool = false

func _ready():
	init_character()
	
func _process(_delta):
	Turn()
	
#Add anything here that needs to be initialized on the character
func init_character():
	healthbar.max_value = health
	healthbar.value = health

#Flip charater sprites based on their current velocity
func Turn():
	if (block_turn):
		return

	#This ternary lets us flip a sprite if its drawn the wrong way
	var direction = -1 if flipped_horizontal == true else 1
	
	if not is_instance_valid(sprite):  
		return
	
	if(velocity.x < 0):
		sprite.scale.x = -direction
	elif(velocity.x > 0):
		sprite.scale.x = direction

#region Taking Damage

#Play universal damage sound effect for any character taking damage and flashing red
func damage_effects():
	#AudioManager.play_sound(audio, 0, pitch)
	#AudioManager.play_sound(AudioManager.BLOODY_HIT, 0, -3)
	after_damage_iframes()
	if(is_instance_valid(hit_particles) and hit_particles):
		hit_particles.emitting = true

#After we are done flashing red, we can take damage again
func after_damage_iframes():
	
	var tween = create_tween()
	if is_instance_valid(self) and not is_in_group("Player"):
		tween.tween_property(self, "modulate", Color.DARK_RED, 0.1)
		tween.tween_property(self, "modulate", Color.WHITE, 0.1)
		tween.tween_property(self, "modulate", Color.RED, 0.1)
		tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	elif is_instance_valid(self):
		invincible = true
		tween.tween_property(self, "modulate", Color.DARK_RED, 0.1)
		tween.tween_property(self, "modulate", Color.WHITE, 0.1)
		tween.tween_property(self, "modulate", Color.RED, 0.1)
		tween.tween_property(self, "modulate", Color.WHITE, 0.1)
		tween.tween_property(self, "modulate", Color.DARK_RED, 0.1)
		tween.tween_property(self, "modulate", Color.WHITE, 0.1)
		tween.tween_property(self, "modulate", Color.RED, 0.1)
		tween.tween_property(self, "modulate", Color.WHITE, 0.1)
		await tween.finished
		invincible = false
	
#func _take_damage(amount):
	#if(invincible == true || is_dead == true):
		#return
		#
	#health -= amount
	#healthbar.value = health;
	#damage_effects()
	#
	#if(health <= 0):
		#_die()
		
func _die():
	if(is_dead):
		return
		
	is_dead = true
	#Remove/destroy this character once it's able to do so unless its the player
	await get_tree().create_timer(1.0).timeout
	if is_instance_valid(self) and not is_in_group("Player"):
		queue_free()

#endregion

