
extends CanvasLayer

# member variables here, example:
# var a=2
# var b="textvar"

var energy
var health

var current_ammmo
var current_health
var max_ammo
var max_health


func _ready():
	# Initialization here
	set_process(true)

func _process(delta):
	current_ammmo = get_tree().get_root().get_node("World/Player/Cannons").get_ammo()
	max_ammo = get_tree().get_root().get_node("World/Player/Cannons").get_max_ammo()
	get_node("Energy").set_scale(Vector2(current_ammmo/max_ammo,1.0))