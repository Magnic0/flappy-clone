extends Node

@onready var bird = $"../Bird" as Bird;
@onready var ground = $"../Ground" as Ground;
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner;
@onready var flashbang = $"../Flashbang" as Flashbang;
@onready var ui = $"../UI" as UI;

var points = 0;

func _ready():
	if bird.is_started:
		pipe_spawner._start_spawning();
	
	bird.game_started.connect(on_game_started);
	pipe_spawner.scored.connect(on_scored);
	ground.bird_crashed.connect(end_game);
	pipe_spawner.bird_crashed.connect(end_game);

func on_game_started():
	pipe_spawner._start_spawning();

func on_scored():
	points += 1;
	ui.update_points(points);

func end_game():
	if flashbang != null:
		flashbang.play();
	
	ground.stop();
	bird.die();
	pipe_spawner.stop();
	ui.on_game_over();
