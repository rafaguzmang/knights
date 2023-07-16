extends CharacterBody3D

var vel_act = Vector3()
var vel_desp = 10
var gravedad = -9.81


func _ready():
	pass


func _physics_process(delta):
	vel_act.y += gravedad * delta
	
	procesar_teclas(delta)
	set_velocity(vel_act)
	set_up_direction(Vector3(0,1,0))
	move_and_slide()
	var b = get_node("RayCast3D")
	#if(b.is_colliding()):
		#print(b.get_collider().name)


func procesar_teclas(delta):
	
	if( Input.is_action_pressed("ui_right")):
		rotation_degrees.y -= 5
	if( Input.is_action_pressed("ui_left")):
		rotation_degrees.y += 5
	if( Input.is_action_pressed("ui_up")):
		vel_act += (-vel_desp * delta) * global_transform.basis.z.normalized()
		get_node("AnimationPlayer").play("Standing Sprint Forward-loop")
	if( Input.is_action_pressed("ui_down")):
		vel_act += (vel_desp * delta) * global_transform.basis.z.normalized()
		get_node("AnimationPlayer").play("Standing Sprint Forward-loop")
		
	
		
	if(Input.is_action_just_released("ui_up") || Input.is_action_just_released("ui_down")):
		vel_act.z = 0
		vel_act.x = 0		
	if(Input.is_action_just_released("ui_right") || Input.is_action_just_released("ui_left")):
		vel_act.x = 0
		vel_act.x = 0
	
	if(vel_act.z ==0):
		vel_act.x = 0
		vel_act.y = 0
		get_node("AnimationPlayer").play("Standing Idle (1)-loop")
	
		
	
