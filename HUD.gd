extends CanvasLayer


onready var score_text = $Control/ScoreText
var score = 0

func _on_ScoreTimer_timeout():
	score += 1
	score_text.text = str(score)
	GlobalVars.current_score = score
