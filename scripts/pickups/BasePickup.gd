extends Area2D

func _ready():
	connect("body_entered", self, "on_body_entered")
	connect("body_exited", self, "on_body_exited")
	
func on_body_entered(body):
	pickup(body)
	
func on_body_exited(body):
	post_pickup(body)

func pickup(body):
	push_error("Need pickup implementation in file %s" % filename)
	
func post_pickup(body):
	push_error("Need post-pickup implementation in file %s" % filename)
