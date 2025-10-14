extends CharacterBody3D
@onready var pivot_camera: Node3D = $Pivot_camera
@onready var lapin_mecanique: Node3D = $"lapin_mecanique"
@onready var gimbal_camera: Node3D = $Pivot_camera/Gimbal_camera

@onready var spring_cam_arm: SpringArm3D = $Pivot_camera/Gimbal_camera/SpringCam_Arm
@onready var camera_3d: Camera3D = $Pivot_camera/Gimbal_camera/SpringCam_Arm/Camera3D

@onready var sensi:float = 0.3
#double jump
#var double_jumped:bool = false
#var double_jumped_unclocked:bool = true

const SPEED:float = 5.0
@export var JUMP_VELOCITY:float = 4.5

var move_speed:float = 0.6
var move_target:Vector3

var dismountable:int = 0
var on_foot:bool = false


func _enter_tree()-> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_beam"):
		if Global.beam_on == true :
			Global.beam_on = false
			$beam/beam_collision.disabled = true
			
			print("beam_off")
			return
		if Global.beam_on == false :
			Global.beam_on = true
			$beam/beam_collision.disabled = false
			print("beam_on")
			return
	toggle_mouse()
	#print (dismountable)
	#if dismountable >= 1:
		#if Input.is_action_just_pressed("dismount"):
			#print("dismounting")
			#on_foot = true
			#dismountable = false
	#if dismountable <= 0:
			#dismountable = false
	if on_foot == true :
		ProjectSettings.set_setting("physics/3d/default_gravity_vector", Vector3(0,-1,0))
	if  on_foot == false :
		ProjectSettings.set_setting("physics/3d/default_gravity_vector", Vector3(0,0,0))
func _ready()->void:
#	self.position = Global.saved_location
	print(self.get_path())
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.capture_mouse = true
	move_target = position
	
func toggle_mouse ()->void:
	if Input.is_action_just_pressed("Interupteur_sourie") and Global.capture_mouse == true :
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Global.capture_mouse = false
	elif Input.is_action_just_pressed("Interupteur_sourie") and Global.capture_mouse == false :
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Global.capture_mouse = true
		#pivot_camera.position = Vector3(0,0,0)

func _input(event:InputEvent)-> void:
	if event is InputEventMouseMotion and Global.capture_mouse == true :
		rotate_y(deg_to_rad(-event.relative.x * sensi))
		lapin_mecanique.rotate_y(deg_to_rad(event.relative.x * sensi))
		gimbal_camera.rotate_x(deg_to_rad(-event.relative.y * sensi))	

func _physics_process(_delta: float) -> void:

	# Add the gravity.
	# pour le multi marche même sans 
	#if is_multiplayer_authority():
		#if not is_on_floor():
			#velocity += get_gravity() * delta
		#double jump
		#else :
			#double_jumped = false

		
		# Handle jump.
		if Input.is_action_just_pressed("saut") and Global.capture_mouse == true:
			velocity.y = JUMP_VELOCITY
			return
				
		elif Input.is_action_just_released("saut") and velocity.y > 0.0 and Global.capture_mouse == true:
			velocity.y = 0.0
			return
		if Input.is_action_just_pressed("sautinv") and Global.capture_mouse == true:
			velocity.y = -JUMP_VELOCITY
			return	
		elif Input.is_action_just_released("sautinv") and velocity.y < 0.0 and Global.capture_mouse == true:
			velocity.y = 0.0
			return
		if Input.is_action_pressed("camera_gauche"):
			pivot_camera.rotate_y(deg_to_rad(1.5))
			self.global_transform.basis = pivot_camera.global_transform.basis
		else:
			pivot_camera.rotation = Vector3.ZERO
			
		if Input.is_action_pressed("camera_droite"):
			pivot_camera.rotate_y(deg_to_rad(-1.5))
			self.global_transform.basis = pivot_camera.global_transform.basis
		else:
			pivot_camera.rotation = Vector3.ZERO
			
		if Input.is_action_pressed("camera_haut"): #and gimbal_camera.rotation.x >= -1
			gimbal_camera.rotate_x(deg_to_rad(-1.8))
			print("camera haut ",gimbal_camera.rotation.x)
			#self.rotation.y= gimbal_camera.rotation.y
		else:
			pivot_camera.rotation = Vector3.ZERO
			
		if Input.is_action_pressed("camera_bas") : #and gimbal_camera.rotation.x <= 1
			gimbal_camera.rotate_x(deg_to_rad(1.8))
			print("camera bas ",gimbal_camera.rotation.x)
			#self.rotation.y = gimbal_camera.rotation.y
		else:
			pivot_camera.rotation = Vector3.ZERO
		if Input.is_action_pressed("zoom_in") or Input.is_action_just_released("zoom_in") :
			if Global.capture_mouse == false:
				spring_cam_arm.spring_length -= 0.2
		if Input.is_action_pressed("zoom_out")or Input.is_action_just_released("zoom_out") :
			if Global.capture_mouse == false:
				spring_cam_arm.spring_length += 0.2
		if Input.is_action_pressed("zoom_reset"):
			spring_cam_arm.spring_length = 2
		if Input.is_action_pressed("location_reset"):
			pivot_camera.position = Vector3(0,0,0)
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir :Vector2= Input.get_vector("gauche", "droite", "haut", "bas")
		var direction :Vector3= (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction and Global.capture_mouse == false :
			
			pivot_camera.global_position.x += direction.x /4
			pivot_camera.global_position.z += direction.z /4
			
		if direction and Global.capture_mouse == true :
			
			lapin_mecanique.look_at(position + direction)
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			#peyut-être le placer ailleur qui fait en sorte qu'être stuck ne bouge pas la value.
			@warning_ignore("narrowing_conversion")
			#Global.danger_level += velocity.length()
			#print(Global.danger_level)
			if Input.is_action_pressed("dash") : #and is_on_floor() 
				# peut être activé mid-air et la modification est instantanée?
				velocity.x = velocity.x * 5
				velocity.z = velocity.z * 5
				@warning_ignore("narrowing_conversion")
				#Global.danger_level += velocity.length()
				#print(Global.danger_level)
			
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			#velocity.y = move_toward(velocity.y, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			#if Global.danger_level >= 1:
				#Global.danger_level -=1
				#print(Global.danger_level)
		move_and_slide()


func _on_area_3d_body_entered(_body: Node3D) -> void:
	#dismountable += 1
	#print("dismountable")
	pass

func _on_area_3d_body_exited(_body: Node3D) -> void:
	#dismountable -= 1
	pass
