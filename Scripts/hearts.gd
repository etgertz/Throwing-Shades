extends Container


var pastLives

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Heart1.visible = true
	$Heart1.texture = preload("res://Assets/GemHeartTrans.png")
	if(Global.lives>2):
		$Heart2.visible = true
		$Heart2.texture = preload("res://Assets/GemHeartTrans.png")
		$Heart3.visible = true
		$Heart3.texture = preload("res://Assets/GemHeartTrans.png")
	pastLives = Global.lives


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.lives == 2.5):
		$Heart3.texture = preload("res://Assets/GemHeartHalfTrans.png")
	elif(Global.lives<=2):
		$Heart3.visible = false
		if(Global.lives == 1.5):
			$Heart2.texture = preload("res://Assets/GemHeartHalfTrans.png")
		if(Global.lives<=1):
			$Heart2.visible = false
			if(Global.lives==.5):
				$Heart1.texture = preload("res://Assets/GemHeartHalfTrans.png")
