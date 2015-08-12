
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	var scene = load("res://gui.scn")
	var node = scene.instance()
	add_child(node)


