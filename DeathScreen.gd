extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var record_text = $Control/Panel/RecordText


# Called when the node enters the scene tree for the first time.
func _ready():
	record_text.text = str(GlobalVars.record_score)
	
func _physics_process(delta):
	if GlobalVars.record_score < GlobalVars.current_score or 0:
		GlobalVars.record_score = GlobalVars.current_score
	else:
		GlobalVars.record_score = GlobalVars.record_score
