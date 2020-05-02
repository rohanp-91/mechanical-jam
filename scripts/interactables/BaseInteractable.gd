extends Area2D

func _ready():
	connect("body_entered", self, "on_body_entered")
	connect("body_exited", self, "on_body_exited")
	
func on_body_entered(body):
	print("body entered")
	interact(body)

func on_body_exited(body):
	post_interact(body)
	
func interact(body):
	push_error("Need interact implementation in file %s" % filename)
	
func post_interact(body):
	push_error("Need post-interact implementation in file %s" % filename)
