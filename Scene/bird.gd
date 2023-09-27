extends CharacterBody2D

class_name Bird

signal game_started;

@export var gravity = 900;
@export var flap_strength = -300;
@export var rotation_speed = 2;

@onready var animated_player = $AnimationPlayer;

var max_speed = 400;
var is_started = false;
var should_process_input = true;

func _ready():
	velocity = Vector2.ZERO;
	animated_player.play("idle");
	
func _physics_process(delta):
	if Input.is_action_just_pressed("flap") && should_process_input:
		if !is_started:
			game_started.emit();
			animated_player.play("wings_flap");
			is_started = true;
		
		flap();

	if !is_started:
		return;

	velocity.y += gravity * delta;
	
	velocity.y = min(velocity.y, max_speed);
	
	move_and_collide(velocity * delta);
	
	rotate_bird();

func flap():
	velocity.y = flap_strength;
	rotation = deg_to_rad(-30);

func rotate_bird():
	# Bird rotate down when falling
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1);
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation += rotation_speed * deg_to_rad(1);

func die():
	should_process_input = false;

func stop():
	animated_player.stop();
	gravity = 0;
	velocity = Vector2.ZERO;
