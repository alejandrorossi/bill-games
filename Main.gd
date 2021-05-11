extends Node

export (PackedScene) var Zombie


func _ready():
	randomize()
	new_game()

func _on_Player_hit():
	print("catraplunchis")

func _on_ZombieTimer_timeout():
	# Choose a random location on Path2D.
	$ZombiePath/ZombieSpawnLocation.offset = randi()
	# Create a Zombie instance and add it to the scene.
	var zombie = Zombie.instance()
	add_child(zombie)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $ZombiePath/ZombieSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	zombie.position = $ZombiePath/ZombieSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	zombie.rotation = direction
	# Set the velocity (speed & direction).
	zombie.linear_velocity = Vector2(rand_range(zombie.min_speed, zombie.max_speed), 0)
	zombie.linear_velocity = zombie.linear_velocity.rotated(direction)


func _on_StartTimer_timeout():
	$ZombieTimer.start()

func new_game():
#    score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
