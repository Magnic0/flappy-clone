extends Node2D

class_name Flashbang

@onready var animation_player = $AnimationPlayer

func play():
	animation_player.play("flashbang");

func _on_animation_player_animation_finished(anim_name):
	queue_free();
