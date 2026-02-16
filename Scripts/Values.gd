extends Control

@export var valueCircle: PackedScene
var numVals
var radius = 230
var valuesArray: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numVals = Global.values
	updateValueRing()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateValueRing();
	

func updateValueRing():
	#add in needed
	while numVals>valuesArray.size():
		var s = valueCircle.instantiate()
		add_child(s)
		valuesArray.append(s)
	
	#remove extras
	while numVals<valuesArray.size():
		var s = valuesArray.pop_back()
		s.queue_free()
	
	#update angle and color
	for i in range(numVals):
		var angle = i*TAU/numVals+PI
		var pos = get_viewport_rect().size/2 + Vector2(radius*sin(angle), radius*cos(angle))
		var val = valuesArray[i]
		val.position = pos
		set_color(i)
		
func set_color(i):
	valuesArray[i].get_node("Sprite2D").modulate = Color.from_hsv(0, 0, Global.get_lum(i,numVals))
	valuesArray[i].val = Global.get_lum(i,numVals)
