extends CharacterBody3D

@export var speed = 200
var health = 10
var player
var damage = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target = player.global_transform.origin
	look_at(target, Vector3.UP)
	var move = (target - global_transform.origin).normalized()*speed
	velocity = move * delta
	move_and_slide()
	_attack()
	pass
 


func _attack():
	if position.distance_to(player.position) <= 1.5:
		player._damage(damage)
	pass

func _on_body_entered(_body):
	if _body.has_method("_damage"):
		_body._damage(damage)
		queue_free()
	pass

func _damage():
	health -= damage
	if health <= 0:
		queue_free()
	
