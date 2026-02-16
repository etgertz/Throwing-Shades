extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size/2
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_viewport_rect().size/2
	modulate = Color.from_hsv(.02, .85, Global.get_lum(5,Global.values))
	pass

func animate(location):
	#transform towards location at given speed
	#upon arrival:
	visible = false
	Global.active=2
