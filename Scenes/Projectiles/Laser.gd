class_name Laser extends Node2D

const maxrange = 5000000000

var based_width = 2
var widthy = based_width
var shoot = false
@onready var collision = $Line2D/DamageArea/CollisionShape2D

func _ready():
	pass # Replace with function body.


func _process(delta):
	$Line2D.width = widthy
	
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	var player_position = self.to_local(player.position)
	var max_cast_to = player_position.normalized() * maxrange
	$RayCast2D.target_position = max_cast_to

	if $RayCast2D.is_colliding():
		$Reference.global_position = $RayCast2D.get_collision_point()
		$Line2D.set_point_position(1,$Line2D.to_local($Reference.global_position))
	else:
		$Reference.global_position = $RayCast2D.target_position
		$Line2D.points[1] = $Reference.global_position
	#$Reference.global_position = $RayCast2D.target_position
	#$Line2D.points[1] = $Reference.global_position
	collision.shape.b = $Line2D.points[1]
