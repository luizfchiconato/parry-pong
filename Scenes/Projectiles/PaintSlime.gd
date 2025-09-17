class_name PaintSlime extends Node2D

@export var wait_for_deaths : int = 0
@export var disappear_after_deaths : bool = false
@export var number_of_deaths_to_disappear : int = 0
var DAMAGE_PAINT = 2
var tween : Tween
var original_modulate
var parent_death_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (!isAvailable()):
		deactivateSlime()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func increment_death_number():
	parent_death_number = parent_death_number + 1
	if (isAvailable()):
		activateSlime()
	if (disappear_after_deaths and parent_death_number >= number_of_deaths_to_disappear):
		#tirar dps execuçoes repetidas desse garoto
		deactivateSlime()

func deactivateSlime():
	self.visible = false

func activateSlime():
	self.visible = true

func isAvailable() -> bool:
	return parent_death_number >= wait_for_deaths and (!disappear_after_deaths or parent_death_number < number_of_deaths_to_disappear)

func _on_area_2d_body_entered(body):
	print("isAvailable", parent_death_number, wait_for_deaths, disappear_after_deaths, isAvailable())
	if body is PlayerMain and isAvailable():
		body.entered_paint(self)


func _on_area_2d_body_exited(body):
	if body is PlayerMain and isAvailable():
		body.exited_paint(self)


func start_timer():
	$ClearTimer.start(1)

func _on_clear_timer_timeout():
	destroy()

func destroy():
	queue_free()
