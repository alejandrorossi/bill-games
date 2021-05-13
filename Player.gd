extends Area2D

signal hit

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

onready var player_animation = $AnimationPlayer
onready var body = $body

func _ready(): #called when node enters in scene
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta): # called at each frame
	var velocity = Vector2(0,0)  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	#jugador se mueve por la pantalla	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# flip jugador arrriba/abajo, derecha / izquierda
	if velocity.x != 0:
	
		if velocity.x > 0:
			body.flip_h = false
		elif velocity.x < 0:
			body.flip_h = true
		_play_animation("walk")
			
	elif velocity.y != 0:
		
		if velocity.y > 0:
			body.flip_h = velocity.y > 0
			_play_animation("down")
			
		elif velocity.y < 0:
			body.flip_h = velocity.y < 0
			_play_animation("up")
	else:
		player_animation.stop()

func _play_animation(animation:String):
	if player_animation.has_animation(animation):
		player_animation.play(animation)

func _on_Player_body_entered(_body):
#	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true) #espera a desactivar hasta que sea seguro

#reinicia
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	
