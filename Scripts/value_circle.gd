extends Node2D

var id
var num
var inside=false
var hover = preload("res://Assets/audio/beep.wav")
var click = preload("res://Assets/audio/Menu Selection Click.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Outline.visible = false
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Left_Click")&&Global.canGuess == true&&inside==true):
		$Effects.stream = click
		$Effects.volume_db = -2
		$Effects.play()
		Global.canGuess = false
		Global.check_answer(num, $"../Timer".time_left)
		Global.guessed.emit(id)


func _on_area_2d_mouse_entered() -> void:
	$Effects.stream = hover
	$Effects.volume_db = -12
	$Effects.play()
	$Outline.visible = true
	inside=true;


func _on_area_2d_mouse_exited() -> void:
	$Outline.visible = false
	inside=false;

func set_color(i:float, numVals:float):
	$Sprite2D.modulate = Color.from_hsv(0, 0, Global.get_lum(i,numVals))
	num = i

func setColor(c: Color, i:float):
	$Sprite2D.modulate = c
	num = i
