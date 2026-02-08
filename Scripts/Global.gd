extends Node

#var guessed = false
var lives = 3
var canGuess = false
var start = false
var paused = false
var score = 0
var highscores = []
var values = 6
var currentVal
var active = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start = false

func get_lum(i,num):
	var t = (i + 2.25) / (num+2)  # midpoint formula
	var gamma = 1.8;
	var luminance = pow(t,gamma);
	return luminance

func check_answer(value):
	print(value," = ",currentVal)
	if(value == currentVal):
		#score += time.round(.5)*25 or something
		return true
	lives-=1
	if(lives==0):
		game_over()
	return false
	
func game_over():
	pass
	
func set_val(newVal):
	currentVal = newVal
	canGuess = true
