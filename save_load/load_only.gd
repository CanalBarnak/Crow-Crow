extends Button
var save_path:String = "user://variable.save"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	load_data() # Replace with function body.

func load_data()->void:
	if FileAccess.file_exists(save_path):
		var file:FileAccess = FileAccess.open(save_path,FileAccess.READ)
		Global.score = file.get_var(Global.score)
		Global.energie = file.get_var(Global.energie)
		get_tree().change_scene_to_file("res://pierre_brune.tscn")
	else:
		print("no data saved")
		Global.score = 0
		Global.energie = 120
