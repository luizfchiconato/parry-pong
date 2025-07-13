class_name PaintSlime extends Node2D

var DAMAGE_PAINT = 2
var tween : Tween
var original_modulate

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	if body is PlayerMain:
		body.entered_paint(self)

#func startHitTimeout(body):
	#$HitTimeout.start()
	#tween = create_tween()
	#tween.tween_property(body, "modulate", Color.RED, $HitTimeout.wait_time)

func _on_area_2d_body_exited(body):
	if body is PlayerMain:
		body.exited_paint(self)
	#stopHitTimeout(body)
		

#func stopHitTimeout(body):
#	if body is PlayerMain:
#		body.modulate = original_modulate
#		$HitTimeout.stop()
#		if (tween != null):
#			tween.stop()

#func _on_hit_timeout_timeout():
#	var player = get_tree().get_first_node_in_group("Player") as PlayerMain
#	player._take_damage(DAMAGE_PAINT)
#	stopHitTimeout(player)
#	startHitTimeout(player)

func start_timer():
	#print("asxcfvgbhnjmk,l")
	$ClearTimer.start(1)
	#print($ClearTimer.is_stopped())

func _on_clear_timer_timeout():
	#print("hasdfg,l")
	destroy()

func destroy():
	#print("jjjjjj")
	queue_free()
