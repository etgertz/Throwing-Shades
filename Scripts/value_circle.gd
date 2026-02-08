extends Node2D

var hue = 0
var sat = 0
var val

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Outline.visible = false
	visible = true
	hue = 0
	sat = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Left_Click")&&Global.canGuess == true):
		Global.canGuess = false
		if(Global.check_answer(val)):
			pass #do any updates to this item if necessary for given events in play


func _on_area_2d_mouse_entered() -> void:
	$Outline.visible = true


func _on_area_2d_mouse_exited() -> void:
	$Outline.visible = false
