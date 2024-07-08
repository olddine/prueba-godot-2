extends CharacterBody3D

@export var speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target = get_parent().get_node("player").global_tranform.origin
	look_at(target, Vector3.UP)
	var move = (target - global_transform.origin).normalized()*speed
	velocity = move * delta
	move_and_slide()
	pass
