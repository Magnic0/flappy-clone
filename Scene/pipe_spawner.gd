extends Node2D


class_name PipeSpawner

signal bird_crashed;
signal scored;

var pipe_pair_scene = preload("res://Scene/pipes.tscn");

@export var pipe_speed = -150;

@onready var spawn_timer = $SpawnTimer

func _start_spawning():
	spawn_timer.timeout.connect(spawn_pipes);
	spawn_timer.start();

func spawn_pipes():
	var pipe = pipe_pair_scene.instantiate() as Pipes;
	add_child(pipe);
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect();
	pipe.position.x = viewport_rect.end.x;
	
	pipe.position.y = randf_range(80, -80);
	
	pipe.bird_entered.connect(on_body_entered);
	pipe.point_scored.connect(on_scored);
	pipe.set_speed(pipe_speed);
	
func on_body_entered():
	bird_crashed.emit();
	stop();
	
func stop():
	spawn_timer.stop();
	for pipe in get_children().filter(func (child): return child is Pipes):
		(pipe as Pipes).speed = 0;
	
func on_scored():
	scored.emit();
