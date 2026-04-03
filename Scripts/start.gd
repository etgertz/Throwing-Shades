extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NumberOfShades/InfoS/SInfoLabel.visible = false
	$Difficulty/InfoD/DInfoLabel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_button_pressed() -> void:
	Fade.fadeOut()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_number_of_shades_value_changed(value: float) -> void:
	Global.values = value


func _on_difficulty_value_changed(value: float) -> void:
	Global.difficulty = value
	if(value==3):
		Global.lives=1
	else:
		Global.lives=3


func _on_s_area_mouse_entered() -> void:
	$NumberOfShades/InfoS/SInfoLabel.visible = true

func _on_s_area_mouse_exited() -> void:
	$NumberOfShades/InfoS/SInfoLabel.visible = false

func _on_d_area_mouse_entered() -> void:
	$Difficulty/InfoD/DInfoLabel.visible = true
	
func _on_d_area_mouse_exited() -> void:
	$Difficulty/InfoD/DInfoLabel.visible = false


func _on_tree_entered() -> void:
	Fade.fadeIn()
