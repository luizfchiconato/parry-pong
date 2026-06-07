class_name ExplosionAreaGroup extends Node2D

var canvasgroup : CanvasGroup

var ExplosionAreaScene = load("res://Scenes/Projectiles/ExplosionArea.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createExplosion(coords, invert):
	var canvasgroup = CanvasGroup.new()
	Global.game_controller.add_2d_scene_child(canvasgroup)
	
	var defaultRotate = 180 if invert else 0
	
	var explosionArea = ExplosionAreaScene.instantiate() as ExplosionArea
	explosionArea.rotate(deg_to_rad(defaultRotate))
	
	var explosionArea2 = ExplosionAreaScene.instantiate() as ExplosionArea
	explosionArea2.rotate(deg_to_rad(defaultRotate + 45.0))
	
	var explosionArea3 = ExplosionAreaScene.instantiate() as ExplosionArea
	explosionArea3.rotate(deg_to_rad(defaultRotate + 90.0))
	
	var explosionArea4 = ExplosionAreaScene.instantiate() as ExplosionArea
	explosionArea4.rotate(deg_to_rad(defaultRotate + 135.0))
	
	canvasgroup.add_child(explosionArea)
	canvasgroup.add_child(explosionArea2)
	canvasgroup.add_child(explosionArea3)
	canvasgroup.add_child(explosionArea4)
	
	explosionArea.global_position = coords
	explosionArea2.global_position = coords
	explosionArea3.global_position = coords
	explosionArea4.global_position = coords
	
	canvasgroup.self_modulate.a = 0.0
	var paint_tween = create_tween()
	await paint_tween.tween_property(canvasgroup, "self_modulate:a", 0.6, 1.2).finished
	
	var player = get_tree().get_first_node_in_group("Player") as PlayerMain
	player.set_trauma(0.36)
