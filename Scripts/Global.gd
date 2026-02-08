extends Node

var guessed = false
var lives = 3
var canGuess = false
var start = false
var score = 0
var highscores = []
var values = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start = false

func get_lum(i,num):
	var t = (i + 2.25) / (num+2)  # midpoint formula
	var gamma = 1.8;
	var luminance = pow(t,gamma);
	return luminance
