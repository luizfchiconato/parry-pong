extends Sprite2D
class_name LifeRacket

var parent_death_number: int = 0
@export var value = 5

#Movement
var time_passed = 0
var initial_position := Vector2.ZERO
@export var amplitude := 3.0
@export var frequency := 4.0
@export var wait_for_deaths := 0
var activated = true

func _ready():
	initial_position = position
	if (wait_for_deaths > 0):
		deactivateRacket()

func _process(_delta):
	body_hover(_delta)

#Gently bob up and down with 'amplitude' where 'frequency' is speed
func body_hover(delta):
	time_passed += delta
	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
	position.y = new_y

#Get picked up by our player
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and activated:
		if body.health < body.max_health:
			body._regenerate(2)
			AudioManager.play_sound(AudioManager.COIN_PICK, 0, -10)
			queue_free()

func increment_death_number():
	parent_death_number = parent_death_number + 1
	if (isAvailable()):
		activateRacket()

func deactivateRacket():
	#self.visible = false
	activated = false
	self.modulate.a = 0.2
	$PointLight2D.visible = false
	$GPUParticles2D.visible = false

func activateRacket():
	#self.visible = true
	activated = true
	self.modulate.a = 1
	$PointLight2D.visible = true
	$GPUParticles2D.visible = true

func isAvailable():
	return parent_death_number >= wait_for_deaths
