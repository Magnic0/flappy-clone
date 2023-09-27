extends Node2D

class_name Pipes

signal bird_entered;
signal point_scored;

var speed = 0;

func set_speed(new_speed):
	speed = new_speed;

func _process(delta):
	position.x += speed * delta;

func _on_body_entered(body):
	bird_entered.emit();

func _on_scored(body):
	point_scored.emit();

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();
