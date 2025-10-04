extends Camera3D
# Replugger marker dans le dossier joueur pour mettre a jour la dépendance.
const MARKER:PackedScene = preload("res://joueur/marker.tscn")
@onready var camera_position: Node3D = $"../../.."


func _input(event:InputEvent)-> void:
	if event.is_action_pressed("clic_droit"):
		shoot_ray()

func shoot_ray()-> void:
	# raycast mouse
	# Lui donner une collision layer.
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	var ray_length:int = 60
	var from:Vector3  = self.project_ray_origin(mouse_pos)
	var to:Vector3 = from + self.project_ray_normal(mouse_pos) * ray_length
	var space:PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var ray_query:PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result:Dictionary = space.intersect_ray(ray_query)

	if !raycast_result.is_empty():
		var instance:Node = MARKER.instantiate()
		instance.position = raycast_result["position"]
		#get_tree().get_root().add_child(instance)
		# place le child sous la node world pour que ça wipe after battle,peut garder le code du haut pour persistence des création
		# peut être mettre un toggle ou un eraser
		$"/root/Monde".add_child(instance)
