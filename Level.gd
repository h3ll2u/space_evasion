extends Node2D

var preload_bonus = preload("res://Bonus.tscn")
var preload_mob = preload("res://Enemy.tscn")
onready var mob_timer = $MobTimer
onready var clear_stage = $ClearStage
onready var player = $Player

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	if Signals.hit == true:
		get_tree().reload_current_scene()
	all_dead_func()
	
func all_dead_func():
	if Signals.all_dead == true:
		mob_timer.stop()
		clear_stage.start()
	print(Signals.all_dead)
	print(clear_stage.time_left)


func _on_MobTimer_timeout():
	var mob = preload_mob.instance()
	mob.position = Vector2(rng.randi_range(0, 280), -30)
	
	var direction = Vector2.DOWN
	
	
	add_child(mob)


func _on_BonusTimer_timeout():
	var bonus = preload_bonus.instance()
	bonus.position = Vector2(rng.randi_range(0, 280), -30)
	var direction = Vector2.DOWN
	
	add_child(bonus)



func _on_ClearStage_timeout():
	Signals.all_dead = false
	mob_timer.start()
