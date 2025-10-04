extends SpotLight3D
@onready var lampe: Node3D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.hour < 6 or Global.hour > 18:
		lampe.visible = true
		#print(Global.hour, "A")
	else:
		lampe.visible = false
		#print(Global.hour, "C")
