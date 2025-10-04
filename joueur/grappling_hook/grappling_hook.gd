extends Node3D
@export var ray: RayCast3D 
@onready var joueur: CharacterBody3D = $".."
#@onready var joueur_monde: CharacterBody3D = %Joueur_monde
@export var rope:  Node3D
@export var hook_speed:Curve 
var timer : float =0.0

#@onready var rope_param: Generic6DOFJoint3D = $Hook/rope_param
#@onready var hook_collision: CollisionShape3D = $Hook/hook_Collision
#var rest_length:float = 0.5 # "when grappling hook should stop pulling"
#var rest_length_x:float = rest_length
#var rest_length_y:float = rest_length
#var rest_length_z:float = rest_length
#var stiffness:float = 10.0 # is what
#var dampening:float = 1.0 # + is slower

var launched:bool = false 
var target:Vector3

#@onready var hook: RigidBody3D = $Hook
#@onready var grappling_script: Node3D = $"."
#@onready var rope_param: Generic6DOFJoint3D = %rope_param

var rope_strength:float=0.2


func _physics_process(delta: float) -> void:
	#if is_multiplayer_authority():
		if Input.is_action_just_pressed("Grappin"):
			launch()
			print("launched")
		if Input.is_action_just_released("Grappin"):
			retract()
		if launched == true:
			handle_grapple(delta)
			
		update_rope()
		
func launch()-> void:
	if ray.is_colliding():
		target = ray.get_collision_point()
		launched = true
		#print("launching")
func retract()-> void:
	launched = false
#	hook.visible = false
#	get_tree().get_root().remove_child(hook)
#	grappling_script.add_child(hook)
	rope_strength = 0.2
func handle_grapple(_delta:float)-> void:
	#print(joueur.global_position.distance_to(target))
	#joueur.global_position = target*hook_speed.sample(timer)
	#var speed: float = 0.5
	#var start:Vector3 = joueur.global_position # Example starting point
	#var end:Vector3 = target
	#var direction:Vector3 = (end - start).normalized()
	#joueur.velocity = direction * speed * _delta
	#joueur.global_translate(target) 
	# La seule ligne qui fait quand même bien la job, je ne peux pas encore fixer la distance de corde par contre.
	joueur.global_position = joueur.global_position.move_toward(target,rope_strength)
	#print(target)
	if Input.is_action_pressed("zoom_in") or Input.is_action_just_released("zoom_in") :
		if Global.capture_mouse == true:
			rope_strength += 0.01
	if Input.is_action_pressed("zoom_out")or Input.is_action_just_released("zoom_out") :
		if Global.capture_mouse == true:
			rope_strength -= 0.001
	
func update_rope()-> void:
	if !launched:
		rope.visible = false
		return
	rope.visible = true
	
	var dist:float = joueur.global_position.distance_to(target)
	rope.look_at(target)
	rope.scale = Vector3(1,1,dist)
