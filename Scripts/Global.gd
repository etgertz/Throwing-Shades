extends Node

#var guessed = false
var lives = 3
var canGuess
var start = false
var paused = false
var score = 0
var highscore = [0,0,0,0,0,0,0,0,0]
#var highscores = []
var values = 6
var difficulty = 1
var lastColor
var currentColor = 0;
var color = 4
var colors: PackedColorArray
var round = 1
var totGuess = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start = false
	initializeColors()

func get_lum(i,num):#update using normailsed values??
	var t = (values-i + 1.25) / (num+2)  # midpoint formula 2.25,2
	var gamma = 1.5;#1.8
	var luminance = pow(t,gamma);
	return luminance
	
func game_over():
	canGuess=false;
	Fade.fadeOutQuiet()
	addHighscore();
	get_tree().change_scene_to_file("res://Scenes/highscore.tscn")

func getRandomColor()->Color:
	#something to do with round to get start (aka what colors can be picked) => start hold color selected
	lastColor = currentColor
	while(lastColor == currentColor):
		currentColor = randi_range(0,values-1);
	return getColor(color, currentColor);

#restructure 
func getColor(x: int, y: int)->Color:
	var pos=80;
	if(values == 4):
		pos=0;
	elif(values == 6):
		pos=32;
	pos += (values*x)+y;
	return colors[pos]

func addHighscore():
	var temp = 3*(difficulty-1)+(values/2)-2
	if(score>highscore[temp]):
		highscore[temp] = score
	#if(highscores.is_empty()):
	#	highscores[0] = score

func replay():
	score = 0;
	lives = 3
	if(difficulty==3):
		lives=1
	round = 1
	totGuess = 0
	color = 4
	
func reset():
	lives = 3
	start = false
	paused = false
	score = 0
	values = 6
	difficulty = 1
	currentColor = 0;
	round = 1
	totGuess = 0
	color=4

signal guessed(guess)

func check_answer(guess, time):
	totGuess+=1
	if(totGuess%20==0):
		round+=1
	var dist = abs(currentColor-guess);
	if(dist==0):
		score+=20*snappedf(time,0.5);
	elif(dist==1&&difficulty==1):
		Fade.heartBreak()
		lives-=.5;
		score+=10*snappedf(time,0.5);
	else:
		Fade.heartBreak()
		lives-=1;
	if(lives<=0):
		game_over();
	
	if(totGuess%20==0 || (totGuess%5==0 && (round%15 == 0 || round%15 >= 11))):
		color+=1;
		color%=8
		if(color==2):#yellow not great
			color+=1

func initializeColors():
	colors = PackedColorArray([
	Color.from_hsv(.019,.522,1),
	Color.from_hsv(.998,.768,.972),
	Color.from_hsv(.978,1,.718),
	Color.from_hsv(0,1,.511),
	
	Color.from_hsv(.046,.593,1),
	Color.from_hsv(.031,.849,.934),
	Color.from_hsv(.022,1,.683),
	Color.from_hsv(0,1,.484),
	
	Color.from_hsv(.119,.749,.915),
	Color.from_hsv(.128,1,.652),
	Color.from_hsv(.124,1,.44),
	Color.from_hsv(.115,1,.295),
	
	Color.from_hsv(.29,.59,.835),
	Color.from_hsv(.333,1,.612),
	Color.from_hsv(.333,1,.419),
	Color.from_hsv(.333,1,.274),
		
	Color.from_hsv(.433,.38,.808),
	Color.from_hsv(.457,.829,.587),
	Color.from_hsv(.457,1,.401),
	Color.from_hsv(.448,1,.261),
	
	Color.from_hsv(.544,.34,.857),
	Color.from_hsv(.536,.667,.654),
	Color.from_hsv(.531,1,.466),
	Color.from_hsv(.538,1,.32),
			
	Color.from_hsv(.813,.377,1),
	Color.from_hsv(.781,.569,.865),
	Color.from_hsv(.774,.688,.652),
	Color.from_hsv(.771,.82,.474),
	
	Color.from_hsv(.907,.434,1),
	Color.from_hsv(.913,.689,.893),
	Color.from_hsv(.899,.918,.657),
	Color.from_hsv(.9,1,.466),
		
	Color.from_hsv(.018,.454,1),
	Color.from_hsv(.004,.651,1),
	Color.from_hsv(.982,.886,.902),
	Color.from_hsv(.975,1,.703),
	Color.from_hsv(.989,1,.544),
	Color.from_hsv(0,1,.427),
		
	Color.from_hsv(.056,.544,1),
	Color.from_hsv(.041,.758,1),
	Color.from_hsv(.041,.949,.842),
	Color.from_hsv(.032,1,.651),
	Color.from_hsv(.001,1,.501),
	Color.from_hsv(0,1,.392),
		
	Color.from_hsv(.118,.713,.971),
	Color.from_hsv(.129,1,.763),
	Color.from_hsv(.127,1,.58),
	Color.from_hsv(.124,1,.431),
	Color.from_hsv(.117,1,.319),
	Color.from_hsv(.104,1,.245),
		
	Color.from_hsv(.293,.541,.882),
	Color.from_hsv(.320,.779,.704),
	Color.from_hsv(.333,1,.549),
	Color.from_hsv(.333,1,.409),
	Color.from_hsv(.333,1,.297),
	Color.from_hsv(.333,1,.215),
		
	Color.from_hsv(.431,.327,.854),
	Color.from_hsv(.447,.54,.677),
	Color.from_hsv(.463,1,.525),
	Color.from_hsv(.459,1,.39),
	Color.from_hsv(.453,1,.283),
	Color.from_hsv(.445,1,.204),
		
	Color.from_hsv(.542,.347,.913),
	Color.from_hsv(.537,.576,.751),
	Color.from_hsv(.529,1,.612),
	Color.from_hsv(.533,1,.468),
	Color.from_hsv(.539,1,.354),
	Color.from_hsv(.546,1,.27),
	
	Color.from_hsv(.833,.342,1),
	Color.from_hsv(.786,.538,.981),
	Color.from_hsv(.777,.68,.856),
	Color.from_hsv(.775,.76,.678),
	Color.from_hsv(.773,.878,.537),
	Color.from_hsv(.77,1,.431),
		
	Color.from_hsv(.9,.363,1),
	Color.from_hsv(.918,.559,.962),
	Color.from_hsv(.908,.72,.803),
	Color.from_hsv(.901,.835,.623),
	Color.from_hsv(.894,1,.479),
	Color.from_hsv(.889,1,.372),
		
	Color.from_hsv(.015,.366,1),
	Color.from_hsv(.006,.526,1),
	Color.from_hsv(.998,.65,.937),
	Color.from_hsv(.988,.764,.796),
	Color.from_hsv(.98,.861,.648),
	Color.from_hsv(.969,1,.526),
	Color.from_hsv(.98,1,.428),
	Color.from_hsv(0,1,.355),
		
	Color.from_hsv(.073,.545,1),
	Color.from_hsv(.059,.729,1),
	Color.from_hsv(.059,.9,.9),
	Color.from_hsv(.057,1,.755),
	Color.from_hsv(.047,1,.612),
	Color.from_hsv(.032,1,.494),
	Color.from_hsv(.01,1,.403),
	Color.from_hsv(0,1,.336),
		
	Color.from_hsv(.117,.678,1),
	Color.from_hsv(.128,.959,.833),
	Color.from_hsv(.128,1,.677),
	Color.from_hsv(.126,1,.539),
	Color.from_hsv(.123,1,.424),
	Color.from_hsv(.118,1,.333),
	Color.from_hsv(.109,1,.267),
	Color.from_hsv(.096,1,.222),
	
	Color.from_hsv(.288,.515,.91),
	Color.from_hsv(.307,.679,.764),
	Color.from_hsv(.333,1,.632),
	Color.from_hsv(.333,1,.511),
	Color.from_hsv(.333,1,.402),
	Color.from_hsv(.333,1,.312),
	Color.from_hsv(.333,1,.24),
	Color.from_hsv(.333,1,.19),
	
	Color.from_hsv(.436,.386,.894),
	Color.from_hsv(.449,.594,.748),
	Color.from_hsv(.463,1,.617),
	Color.from_hsv(.457,1,.498),
	Color.from_hsv(.453,1,.392),
	Color.from_hsv(.448,1,.304),
	Color.from_hsv(.442,1,.234),
	Color.from_hsv(.433,1,.183),
	
	Color.from_hsv(.542,.346,.947),
	Color.from_hsv(.538,.519,.814),
	Color.from_hsv(.53,.863,.696),
	Color.from_hsv(.531,1,.583),
	Color.from_hsv(.535,1,.47),
	Color.from_hsv(.539,1,.377),
	Color.from_hsv(.545,1,.303),
	Color.from_hsv(.551,1,.247),
	
	Color.from_hsv(.833,.316,1),
	Color.from_hsv(.799,.486,1),
	Color.from_hsv(.777,.622,.952),
	Color.from_hsv(.773,.772,.835),
	Color.from_hsv(.771,.739,.695),
	Color.from_hsv(.77,.893,.578),
	Color.from_hsv(.769,1,.484),
	Color.from_hsv(.76,1,.413),
	
	Color.from_hsv(.874,.316,1),
	Color.from_hsv(.904,.518,1),
	Color.from_hsv(.901,.653,.9),
	Color.from_hsv(.893,.787,.765),
	Color.from_hsv(.887,.925,.623),
	Color.from_hsv(.885,1,.506),
	Color.from_hsv(.888,1,.413),
	Color.from_hsv(.891,1,.342),
	]);
	
