extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.highscore[3*(Global.difficulty-1)+(Global.values/2-2)]<=Global.score):
		$NewHighscore.visible = true
	else:
		$NewHighscore.visible = false
	$Score.text = str("[wave freq=6.0 amp=40.0]",int(Global.score),"[/wave]")
	$HighScore.text = str("Highscore: ",int(Global.highscore[3*(Global.difficulty-1)+(Global.values/2-2)]))


func _on_play_again_pressed() -> void:
	Fade.fadeOut()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	Global.replay()


func _on_main_menu_pressed() -> void:
	Fade.fadeOut()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	Global.reset()


func _on_draw() -> void:
	pass # Replace with function body.


func _on_tree_entered() -> void:
	Fade.fadeIn()
