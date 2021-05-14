extends RigidBody2D

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.

onready var zombie_container


func _ready():
	var zombie_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = zombie_types[randi() % zombie_types.size()]
	

#func initialize(zombie_container):
	#self.zombie = zombie_container
	#_on_Hitbox_body_entered(zombie_container)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func notify_hit():
	print("I'm da zombie")
	#call_deferred("_remove")
	
func _on_Hitbox_body_entered(body):
	if body.has_method("notify_hit"):
		body.notify_hit()	
