extends Control

@export var valueCircle: PackedScene
var radius = 230
var valuesArray: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateValueRing()
	Global.guessed.connect(update);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateValueRing();
	$Time.text = str(snappedf($Timer.time_left, 0.1))
	
func update():
	$Timer.stop()
	if(Global.round == 1):
		$Timer.start(3)
	pass

func updateValueRing():
	#add in needed
	while Global.values>valuesArray.size():
		var s = valueCircle.instantiate()
		add_child(s)
		valuesArray.append(s)
	
	#remove extras
	while Global.values<valuesArray.size():
		var s = valuesArray.pop_back()
		s.queue_free()
	
	#update angle and color
	for i in range(Global.values):
		var angle = i*TAU/Global.values+PI
		var pos = get_viewport_rect().size/2 + Vector2(radius*sin(angle), radius*cos(angle))
		var val = valuesArray[i]
		val.position = pos
		valuesArray[i].set_color(i, Global.values)
		
