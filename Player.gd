extends KinematicBody2D
export var speed: float = 150
export var accel: float = 15
var direction : Vector2 = Vector2.ZERO
var screen_size
var velocity : Vector2 = Vector2.ZERO
onready var animsprite = $AnimatedSprite
onready var hud = $HUD
onready var player = $"."
onready var position_2d = $"../Position2D"
onready var score_timer = $HUD/ScoreTimer
onready var score_text = $HUD/Control/ScoreText
onready var animation_player = $AnimationPlayer
onready var explosion = $Explosion
onready var bust_animation_player = $BustAnimationPlayer
onready var mobile_buttons = $MobileButtons/Area2D
onready var mobile_buttons_canvas = $MobileButtons


func _ready():
	screen_size = get_viewport_rect().size
	mobile_buttons_canvas.hide()
	
func start(position_2d):
	position = position_2d
	GlobalVars.current_score = 0


func start_with_add(position_2d):
	position = position_2d
	GlobalVars.current_score = hud.score


func _physics_process(delta):
	var mobile_buttons_direction = mobile_buttons.small_circle.position.normalized()
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x or direction.y == 0 or mobile_buttons_direction.y == 0 or mobile_buttons_direction.x == 0:
		animation_player.play("idle")
	elif direction.y < 0 or mobile_buttons_direction.y < 0 and mobile_buttons_direction.x < mobile_buttons_direction.y:
		animation_player.play("fly_up")
	elif direction.y > 0 or mobile_buttons_direction.y > 0 and mobile_buttons_direction.x < mobile_buttons_direction.y:
		animation_player.play("fly_down")
	if direction.x > 0 or mobile_buttons_direction.x > 0:
		animation_player.play("fly_side")
		animsprite.flip_h = true
	elif direction.x < 0 or mobile_buttons_direction.x < 0:
		animation_player.play("fly_side")
		animsprite.flip_h = false
	if mobile_buttons_direction.y < 0 and mobile_buttons_direction.x > mobile_buttons_direction.y:
		animation_player.play("fly_up")
	elif  mobile_buttons_direction.y > 0 and mobile_buttons_direction.x < mobile_buttons_direction.y:
		animation_player.play("fly_down")
	velocity.x = move_toward( velocity.x, speed * direction.x, accel)
	velocity.y = move_toward( velocity.y, speed * direction.y, accel)
	position += velocity * delta
	
	if OS.has_feature("mobile"):
		mobile_buttons_canvas.show()
		velocity = $MobileButtons/Area2D.get_velo()
		move_and_slide(velocity * speed, Vector2.ZERO)
	else:
		move_and_slide(Vector2.ZERO)
	
		
	if Signals.hit == true:
		hide()
		
	if Signals.all_dead == true:
		bust_animation_player.play("shock_em")
	else:
		bust_animation_player.play("default")


#func _input(event):
#	var mobile_status : bool
#	var	mouse_position = get_viewport().get_mouse_position()
#	if event is InputEventScreenTouch:
#		mobile_buttons_canvas.show()
#		mobile_buttons.position = mouse_position
#		if mobile_buttons_canvas.hide():
#			mobile_status = false
#		elif mobile_buttons_canvas.show():
#			mobile_buttons = true
#	elif mobile_status == true:
#		event is InputEventScreenDrag and InputEventScreenTouch
#		mobile_buttons.small_circle.position = mouse_position
		
	
func _on_Trigger_body_entered(body):
	Signals.hit = true
	hud.score = 0
	hud.score_text.text = str(0)
	explosion.playing = true
