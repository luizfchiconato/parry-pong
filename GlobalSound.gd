extends Node

func _enter_tree() -> void:
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node) -> void:
	if node is BaseButton:
		node.pressed.connect(_play_click)
		node.mouse_entered.connect(_play_hover)

func _play_click() -> void:
	AudioManager.play_sound(AudioManager.CLICK_UI, 4, -25)

func _play_hover() -> void:
	AudioManager.play_sound(AudioManager.SELECT_UI, 4, -25)
