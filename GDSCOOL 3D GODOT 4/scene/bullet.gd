extends Area3D

var speed = -30.0
@export var damage = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += global_transform.basis.z*speed*delta
	
	pass


func _on_body_entered(_body):
	if _body.has_method("_damage"):
		_body._damage(damage)
		queue_free()
	pass # Replace with function body.
