extends Node3D

@onready var pistol = $pistol
@onready var cub = $cub
@onready var shotgun = $shotgun

func _guns_show():
	if Input.is_action_just_pressed("ui_one"):
		pistol.visible = not pistol.visible
		cub.visible = false
		shotgun.visible = false
		
	if Input.is_action_just_pressed("ui_two"):
		pistol.visible = false
		cub.visible = false
		shotgun.visible = not shotgun.visible
		
	if Input.is_action_just_pressed("ui_three"):
		pistol.visible = false
		cub.visible = not cub.visible
		shotgun.visible = false
		
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_guns_show()
	
	pass
