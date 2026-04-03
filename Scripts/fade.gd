extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fadeOut():
	$Effects.play()
	$Fade/AnimationPlayer.play("fadeOut")
	await get_tree().create_timer(.4).timeout
	$Effects.stop()
	
func fadeIn():
	$Fade/AnimationPlayer.play("fadeIn")

func fadeOutQuiet():
	$Fade/AnimationPlayer.play("fadeOut")
	
func heartBreak():
	$BreakSound.play(.29)
