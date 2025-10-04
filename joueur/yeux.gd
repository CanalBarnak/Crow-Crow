extends Node3D
@onready var open_blink: Timer = $open_blink
@onready var wait_blink: Timer = $wait_blink



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_wait_blink_timeout() -> void:
	self.visible = false
	

func _on_open_blink_timeout() -> void:
	self.visible = true
