extends Node3D

@onready var pistol = $pistol
@onready var cub = $cub
@onready var shotgun = $shotgun

@onready var barrelp = $pistol/barrelp
@onready var barrels = $shotgun/barrels

var is_cub: bool
var is_pistol: bool
var is_shotgun: bool

var pbullet = preload("res://scene/bullet.tscn")
var sbullet = preload("res://scene/sbullet.tscn")

func _process(_delta):
	_guns_show()
	_spistol()
	_sshotgun()
	pass

func _guns_show():
	if Input.is_action_just_pressed("ui_one"):
		pistol.visible = not pistol.visible
		cub.visible = false
		shotgun.visible = false
		
		if pistol.visible == true:
			is_pistol = true
			shotgun.visible = false
			is_shotgun = false
			cub.visible = false
		else:
			is_pistol = false
		
	if Input.is_action_just_pressed("ui_two"):
		pistol.visible = false
		cub.visible = false
		shotgun.visible = not shotgun.visible
		
		if shotgun.visible == true:
			is_pistol = false
			pistol.visible = false
			is_shotgun = true
			cub.visible = false
		else:
			is_shotgun = false
		
	if Input.is_action_just_pressed("ui_three"):
		pistol.visible = false
		cub.visible = not cub.visible
		shotgun.visible = false
		
		if cub.visible == true:
			is_pistol = false
			shotgun.visible = false
			is_shotgun = false
			pistol.visible = false
		else:
			is_cub = false
		
	pass
	
func _spistol():
	if is_pistol == true:
		if Input.is_action_just_pressed("ui_shoot"):
			var a = pbullet.instantiate()
			a.global_transform = barrelp.global_transform
			get_node("/root/main").add_child(a)
			
func _sshotgun():
	if is_shotgun == true:
		if Input.is_action_just_pressed("ui_shoot"):
			var b = sbullet.instantiate()
			b.global_transform = barrels.global_transform
			get_node("/root/main").add_child(b)
			
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	_guns_show()
	
	pass
