extends Node2D

var num
var inside=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Outline.visible = false
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Left_Click")&&Global.canGuess == true&&inside==true):
		Global.canGuess = false
		check_answer()
		Global.guessed.emit()


func _on_area_2d_mouse_entered() -> void:
	$Outline.visible = true
	inside=true;


func _on_area_2d_mouse_exited() -> void:
	$Outline.visible = false
	inside=false;

func set_color(i:float, numVals:float):
	$Sprite2D.modulate = Color.from_hsv(0, 0, Global.get_lum(i,numVals))
	num = i

func check_answer():
	var dist = abs(Global.currentColor-num);
	if(dist==0):
		Global.score+=50;#replace with timer-based score system
		#do any updates (visible/color) to this item if necessary for given events in play
	elif(dist==1&&Global.difficulty==1):
		Global.lives-=.5;
		Global.score = 25;#replace with timer based calc
	else:
		Global.lives-=1;
	if(Global.lives<=0):
		Global.game_over();
