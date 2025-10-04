extends Control
@onready var save_load: Control = $"."

var save_path:String = "user://variable.save"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_save_pressed() -> void:
	save() # Replace with function body.


func _on_load_pressed() -> void:
	load_data() # Replace with function body.

func save()->void:
	var file:FileAccess = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(Global.high_score)
	#file.store_var(Global.current_level)
	#file.store_var(Global.sound_level)
	
	
	
func load_data()->void:
	if FileAccess.file_exists(save_path):
		var file:FileAccess = FileAccess.open(save_path,FileAccess.READ)
		Global.high_score = file.get_var(Global.high_score)
		Global.current_level = file.get_var()
		#Global.sound_level = file.get_var()
	else:
		print("no data saved")
		Global.score = 0
		Global.energie = 120
