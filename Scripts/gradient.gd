extends Node2D

var colors: PackedColorArray
var current = Global.color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initializeGradientColors()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextureRect.size.x = get_viewport_rect().size.y
	$TextureRect.size.y = get_viewport_rect().size.x
	$TextureRect.position.x = get_viewport_rect().size.x
	$TextureRect.position.y = 0
	
	if(Global.color != current):
		current = Global.color
		transition_gradient(getStart(current),getEnd(current))
	else:
		current = Global.color
	

func transition_gradient(new_color_start, new_color_end, duration = 1.5):
	var gradient = $TextureRect.texture.gradient
	var tween = create_tween()
	tween.tween_method(
		func(t):
			gradient.set_color(0, gradient.get_color(0).lerp(new_color_start, t))
			gradient.set_color(1, gradient.get_color(1).lerp(new_color_end, t)),
		0.0, 1.0, duration
)

func getStart(num):
	return colors[2*num];

func getEnd(num):
	return colors[2*num+1]

func initializeGradientColors():
	colors = PackedColorArray([
		Color(0.826, 1.0, 0.808, 1.0),
		Color(0.897, 0.932, 1.0, 1.0),
		
		Color(0.803, 0.998, 0.888, 1.0),
		Color(0.946, 0.913, 0.998, 1.0),
		
		Color(0.806, 0.972, 0.98, 1.0),
		Color(0.964, 0.878, 0.996, 1.0),
		
		Color(0.852, 0.961, 1.0, 1.0),
		Color(0.998, 0.841, 0.863, 1.0),
		
		Color(0.887, 0.935, 1.0, 1.0),
		Color(0.996, 0.839, 0.726, 1.0),
		
		Color(0.897, 1.0, 0.828, 1.0),
		Color(0.994, 0.902, 0.98, 1.0),
		
		Color(0.969, 0.983, 0.739, 1.0),
		Color(0.83, 0.999, 0.965, 1.0),
		
		Color(0.945, 1.0, 0.794, 1.0),
		Color(0.848, 0.975, 0.999, 1.0)
		]);
