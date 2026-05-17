class_name Explosion extends Node2D

var Player = load("res://Scenes/Player/Player.tscn")

@onready var explosion_radius = $ExplosionRadius
@onready var anim_bomb = $ExplosionRadius/AnimatedSprite2D
@onready var radius_bomb = $ExplosionRadius/MeshInstance2D
@onready var radius_bomb_internal = $ExplosionRadius/InternalMesh
@export var bomb_animator : AnimationPlayer

const DAMAGE_BOWLING = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	bomb_animator.stop()
	$ExplosionRadius/CollisionShape2D.disabled = true

func showPaint():
	$ExplosionRadius/CirclePaint.visible = true

func explode():
	$ExplosionRadius/CirclePaint.visible = false
	explosion_radius.visible = true
	bomb_animator.play("exploding")
	await bomb_animator.animation_finished
	explosion_radius.visible = false
	queue_free()

#Connect and deal damage to the player
func deal_damage_to_player(player : PlayerMain):
	if !player.attacking:
		player._take_damage(DAMAGE_BOWLING)

func _on_explosion_radius_body_entered(body):
	# TODO: LIDAR COM GAMBIARRA
	if body.is_in_group("Player") and !$ExplosionRadius/CollisionShape2D.disabled:
		var player = get_tree().get_first_node_in_group("Player") as PlayerMain
		if player.is_dashing():
			return
		deal_damage_to_player(body)
