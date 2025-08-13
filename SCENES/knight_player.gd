extends CharacterBody2D

@export var move_speed: float = 200
var character_direction : Vector2 = Vector2.ZERO
var last_direction : String = "down"
func _physics_process(delta):
	character_direction = Vector2.ZERO
	# Get Input directions
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	# normalise Diagonal movement
	
	# Update velocity
	if(character_direction != Vector2.ZERO): 
		
		if((character_direction.x > 0 and character_direction.y > 0) or (character_direction.x > 0 and character_direction.y < 0)):
			$sprite.play("walk_right")
			last_direction = "right"
		elif((character_direction.x < 0 and character_direction.y > 0) or (character_direction.x < 0 and character_direction.y < 0)):
			$sprite.play("walk_left")
			last_direction = "left"
		elif (character_direction.y > 0): 
			$sprite.play("walk_down") 
			last_direction = "down"
		elif(character_direction.y < 0): 
			$sprite.play("walk_up")
			last_direction = "up"
		elif(character_direction.x < 0): 
			$sprite.play("walk_left")
			last_direction = "left"
		elif(character_direction.x > 0 ):
			$sprite.play("walk_right")
			last_direction = "right"
			
		character_direction.normalized()
		velocity = character_direction * move_speed 
	
	else:
		velocity = velocity.move_toward(Vector2.ZERO, move_speed * delta)
		$sprite.play("idle_"+last_direction)
	
	# slide along wall if present
	move_and_slide()
	
