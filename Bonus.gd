extends Area2D
var velocity : Vector2
var direction : Vector2
var speed = 200
onready var timer = $Timer

func _ready():
	pass # Replace with function body.


func _process(delta):
	velocity.y = speed 
	position += velocity * delta



func _on_Bonus_body_entered(body):
	Signals.all_dead = true
	timer.start()
	self.modulate.a = 0


func _on_Timer_timeout():
	Signals.all_dead = false



