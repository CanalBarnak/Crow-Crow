extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.rotation = Vector3(deg_to_rad(0),deg_to_rad(randf_range(0,360)),deg_to_rad(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotate_y(0.04)
