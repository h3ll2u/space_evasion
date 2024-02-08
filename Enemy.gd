extends KinematicBody2D
onready var animation_player = $AnimationPlayer

onready var animated_sprite = $AnimatedSprite
var rng = RandomNumberGenerator.new()
var speed = rng.randf_range(300.0, 600.0)
var velocity : Vector2
var direction : Vector2
var alive = true
func _ready():
	animation_player.play("idle")


func _physics_process(delta):
	velocity.y = speed 
	position += velocity * delta
	move_and_slide(Vector2.ZERO)
	if Signals.all_dead == true:
		animation_player.play("death")
		speed = 0
		if alive == false:
			queue_free()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _death_state():
	alive = false


func _alive_state():
	alive = true
