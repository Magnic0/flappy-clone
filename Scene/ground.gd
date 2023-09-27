extends Node2D

class_name Ground

signal bird_crashed;

@export var speed = -150;

@onready var sprite1 = $Ground1/Sprite2D;
@onready var sprite2 = $Ground2/Sprite2D;

func _ready():
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width();

func _process(delta):
	sprite1.global_position.x += speed * delta;
	sprite2.global_position.x += speed * delta;

	# If sprite 1 move completely out of screen, it is transported to the left of sprite 2.
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width();
	
	# Same thing for sprite 2, it gets on the left of sprite 1.
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width();
	
func _on_body_entered(body):
	bird_crashed.emit();
	stop();
	(body as Bird).stop();

func stop():
	speed = 0;
