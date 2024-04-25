extends Node2D

var level = preload("res://Level.tscn")


func _ready():
	get_tree().paused = false


func _on_Play_pressed():
	get_tree().change_scene_to(level)

