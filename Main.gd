extends Control

@onready var scene_manager: Node = $SceneManager

func _on_button_pressed() -> void:
	scene_manager.load_scene('res://scene_with_instantiated.tscn')
