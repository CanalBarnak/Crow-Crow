extends SpinBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	@warning_ignore("narrowing_conversion")
	Global.offset_time = self.value
	if Global.capture_mouse  == false : 
		visible = true
	else:
		visible = false


func _on_value_changed(_value: float) -> void:
	@warning_ignore("narrowing_conversion")
	Global.offset_time = self.value
	print(Global.offset_time)
