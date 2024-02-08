extends ParallaxBackground


var speed = 100



func _process(delta):
	scroll_offset.y += speed * delta
