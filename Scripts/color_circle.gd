extends Node2D

var colors = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size/2
	new_Color();
	Global.guessed.connect(new_Color);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_viewport_rect().size/2
	pass

func animate(location):
	#transform towards location at given speed
	#upon arrival:
	visible = false
	Global.active=2

func new_Color():#update to not allow same color in a row!
	modulate = Global.getRandomColor();
	Global.canGuess=true;
	
