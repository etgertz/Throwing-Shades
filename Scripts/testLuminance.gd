extends Control

@export var partitions := 8
@export var radius := 250

func _ready():
	draw_grayscale()

func draw_grayscale():
	# Clear old children
	for child in get_children():
		child.queue_free()

	var width_per_bar = size.x / partitions

	for i in range(partitions):
		var t = (i + 2.25) / (partitions+2)  # midpoint formula
		var gamma = 1.8;
		var luminance = pow(t,gamma);
		var rect := ColorRect.new()
		rect.color = Color.from_hsv(0, 0, luminance)
		rect.position = Vector2(size.x/2+(radius)*sin(i*2*PI/partitions+PI), size.y/2+(radius)*cos(i*2*PI/partitions+PI))
		rect.size = Vector2(width_per_bar/1.5,width_per_bar/1.5 )

		add_child(rect)
