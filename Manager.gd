extends Node

onready var player = $"../Player"
onready var position_2d = $"../Position2D"
onready var death_screen = $"../DeathScreen"
onready var level = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	death_screen.hide()

func _physics_process(delta):
	if Signals.hit == true:
		death_screen.show()
		get_tree().paused = true
		player.score_text.visible = false
	elif Signals.hit == false:
		death_screen.hide()
		get_tree().paused = false
		player.score_text.visible = true
	




func _on_TryAgainForAdd_pressed():
	Signals.hit = false
	get_tree().reload_current_scene()
	
func _on_TryAgain_pressed():
	Signals.hit = false
	get_tree().change_scene("res://MainMenu.tscn")
	
