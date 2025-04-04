extends Node2D

var DAMAGE_PAINT = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	if body is PlayerMain:
		$HitTimeout.start()

func _on_area_2d_body_exited(body):
	if body is PlayerMain:
		$HitTimeout.stop()


func _on_hit_timeout_timeout():
	var player = get_tree().get_first_node_in_group("Player") as PlayerMain
	player._take_damage(DAMAGE_PAINT)
