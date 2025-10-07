extends RigidBody3D

var inside_beam:bool = false
var doing:bool= false
@export var type: String= "poisson"
var number_match:int = 0
@onready var inside_matching = false
var matched = false
var three_checking:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if number_match == 2 : #and inside_matching == true
		$Cube.get_active_material(0).emission_enabled = true
	elif self.number_match < 2:
		$Cube.get_active_material(0).emission_enabled = false
	if number_match == 2 and type == type and Global.beam_on == false:
		#Global.match_three_count += 1
		#if Global.match_three_count == 3:
			#Global.match_three_count -= 3
		queue_free()

	if inside_beam == true:
		reparent($"/root/Monde/Joueur_ship")
		self.translate(Vector3(0,0.1,0))
		print(self.get_path())
		doing = true
		return
	if Global.beam_on == false and doing == true:
		#self.translate(Vector3(0,0,0))
		inside_beam= false
		doing = false
		reparent($"../../..")
		print(self.get_path())
		return

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("swivel_l") and doing == true:
		#print("presed")
		self.rotate_y(0.01)
	if Input.is_action_pressed("swivel_r")and doing == true:
		self.rotate_y(-0.01)
func _on_area_3d_area_entered(_area: Area3D) -> void:
	inside_beam= true
	reparent($"/root/Monde/Joueur_ship")

func _on_area_3d_area_exited(_area: Area3D) -> void:
	inside_beam= false


func _on_area_3d_2_area_entered(_area: Area3D) -> void:
	#number_match += 1
	#inside_matching = true
	
	three_checking = $Area3D2.get_overlapping_areas()
	print("checking for 3 : ",three_checking)
	number_match = three_checking.size()
	print("matching ", number_match)

func _on_area_3d_2_area_exited(_area: Area3D) -> void:
	#number_match -= 1
	#inside_matching = false
	#Global.match_three_count -= 1
	three_checking = $Area3D2.get_overlapping_areas()
	number_match = three_checking.size()
	print("not matching anymore", number_match)

func verify_match()-> void:
	pass
