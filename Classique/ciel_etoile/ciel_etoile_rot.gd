extends Node3D
@onready var rand_speed:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rand_speed = randf_range(0.00001,0.00003)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.rotate_y(-rand_speed)
	self.position = $"../Joueur_ship".position
	
