extends Node2D

var colors = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size/2
	new_Color(0);
	Global.guessed.connect(new_Color);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_viewport_rect().size/2
	pass

func new_Color(n:float):#update to not allow same color in a row!
	modulate = Global.getRandomColor();
	Global.canGuess=true;
	
