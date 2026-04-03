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
	$Time.text = str(snappedf($Timer.time_left, 0.1))
	
func update(n:float):
	$Timer.stop()
	if(Global.round%15 == 6 || Global.round%15 == 7):
		swap(n)
	elif(Global.round%15 == 4 || Global.round%15 == 5):
		rotate(1)
	elif(Global.round%15 == 8 || Global.round%15 == 9 || Global.round%15 == 10):
		swap(n)
		rotate(1)
	elif(Global.round%15 >= 11 || Global.round%15 == 0):####################################
		if(Global.lastColor == valuesArray[n].num):
			valuesArray[n].setColor(Global.getColor(Global.color, Global.lastColor),Global.lastColor)
	$Timer.start(3-int(Global.round/15))

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
		valuesArray[i].id=i

func swap(n:float):
	var temp = valuesArray[n].get_node("Sprite2D").modulate
	var n2 = int(n+Global.values/2)%int(Global.values)
	var number = valuesArray[n].num
	valuesArray[n].setColor(valuesArray[n2].get_node("Sprite2D").modulate, valuesArray[n2].num)##second value is num
	valuesArray[n2].setColor(temp,number)##second value is num

func rotate(n:float):
	var tempC = valuesArray[0].get_node("Sprite2D").modulate
	var tempNum = valuesArray[0].num
	for i in range(Global.values-1):
		valuesArray[i].setColor(valuesArray[i+n].get_node("Sprite2D").modulate,valuesArray[i+n].num)
	valuesArray[Global.values-1].setColor(tempC,tempNum)


func _on_timer_timeout() -> void:
	pass#######################################################
	Global.canGuess = false
	Global.check_answer(-1, 0)
	Global.guessed.emit(-1)
	$Timer.start(3-int(Global.round/10))
