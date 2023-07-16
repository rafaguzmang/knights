extends CharacterBody3D

#hero properties
var hero 

#enemy properties collider
var collider
var enemyAnim 
var attack = false

var speed = 300

#state of the eyes Enemy
var warning = false
var alert = false


#albedo color Enemy
var enemy_mat
var eye_color_00
var eye_alert
var eye_warning


#physics process  Enemy
var vel_act = Vector3()
#var vel_desp = 200
var gravedad = -9.81

func _ready():
	collider = get_node("Armature/Skeleton3D/BoneAttachment3D/RayCast3D")
	hero = get_parent().get_node("hero")
	enemyAnim  = get_node("AnimationPlayer")
	enemyAnim.play("T-Pose-loop")
	enemy_mat = get_node("Armature/Skeleton3D/Mesh").mesh.surface_get_material(1)
	eye_color_00 = enemy_mat.get_albedo()
	#print(hero.name)
	


func _physics_process(delta):	
	
	var a = get_node("Armature/Skeleton3D/BoneAttachment3D/RayCast3D").get_collider()
	
	
	if(collider.is_colliding() and a.name == hero.name):
		#print(a.name)		
		alert = true
		#enemyAnim.play("T-Pose-loop")
	else:
		set_velocity(Vector3(0,vel_act.y,0)*delta)
		set_up_direction(Vector3(0,1,0))
		move_and_slide()
		
	if(alert):
		look_at(hero.global_transform.origin, Vector3(0,1,0))		
		enemy_mat.set_albedo(Color(255,0,0))		
		vel_act.y += gravedad 
		var direccion = (hero.transform.origin - transform.origin).normalized()
		
		
		if(attack):
			enemyAnim  = get_node("AnimationPlayer")
			enemyAnim.play("Mutant Swiping (1)-loop")
			
		else:
			enemyAnim  = get_node("AnimationPlayer")
			enemyAnim.play("Mutant Walking-loop")
			set_velocity(Vector3(direccion.x*speed,vel_act.y,direccion.z*speed)*delta)
			set_up_direction(Vector3(0,1,0))
			move_and_slide()
		
		
		
func _on_Area_body_entered(body):
	
	if(body.name == hero.name):
		#print("Entered " + body.name and alert == false)
		enemyAnim  = get_node("AnimationPlayer")
		enemyAnim.play("Standing Idle Looking Ver 2-loop")
		enemy_mat.set_albedo(Color(255,255,0))
	


func _on_Area_body_exited(body):
	if(body.name == hero.name):
		get_node("Timer").start()
		#print("Exited")


func _on_Timer_timeout():
	enemy_mat.set_albedo(eye_color_00)
	alert = false
	enemyAnim  = get_node("AnimationPlayer")
	enemyAnim.play("T-Pose-loop")


func _on_AreaNear_body_entered(body):
	if(body.name == hero.name):
		alert = true
		look_at(hero.global_transform.origin, Vector3(0,1,0))
		enemyAnim  = get_node("AnimationPlayer")
		enemyAnim.play("Mutant Walking-loop")
		enemy_mat.set_albedo(Color(255,0,0))


func _on_AreaAttack_body_entered(body):
	if(body.name == hero.name):
		attack = true

func _on_AreaAttack_body_exited(body):
	if(body.name == hero.name):
		attack = false
