extends Node3D
@onready var rand_speed:float
@export var intensite_star:Curve 
@onready var constellation: MeshInstance3D = $Constellation
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.rotation.z = randf_range(0,1)
	rand_speed = randf_range(0.0005,0.0015)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.rotation_degrees.z -= 0.01
	#constellation.mesh.surface_get_material(0).emission_energy_multiplier = intensite_star.sample(Global.day_percent_return)
