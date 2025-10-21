extends Node

var BallScene = preload("res://actors/ball_actor.tscn")
var SpawnTimer: Timer

var margin = 100.0

func _ready():
	SpawnTimer = Timer.new()
	SpawnTimer.connect("timeout", _SpawnBall)
	add_child(SpawnTimer)
	_UpdateTimer()
	SpawnTimer.start()

func _process(delta):
	if GameSystem.IsGameOver:
		SpawnTimer.stop()
		return
	
	_UpdateTimer()

func _UpdateTimer():
	var rate = 2.0 * GameSystem.Difficulty
	if SpawnTimer.wait_time != 1.0 / rate:
		SpawnTimer.wait_time = 1.0 / rate

func _SpawnBall():
	var ball = BallScene.instantiate()
	var screen_size = get_tree().root.get_visible_rect().size
	
	var spawn_pos:Vector2
	var target_pos = screen_size * 0.5
	
	match randi() % 4:
		0: spawn_pos = Vector2(randf_range(0, screen_size.x), -margin)
		1: spawn_pos = Vector2(randf_range(0, screen_size.x), screen_size.y + margin)
		2: spawn_pos = Vector2(-margin, randf_range(0, screen_size.y))
		_: spawn_pos = Vector2(screen_size.x + margin, randf_range(0, screen_size.y))
	
	target_pos.x += randf_range(-screen_size.x * 0.2, screen_size.x * 0.2)
	target_pos.y += randf_range(-screen_size.y * 0.2, screen_size.y * 0.2)
	
	var direction = (target_pos - spawn_pos).normalized()
	var speed = (screen_size.length() / 10.0) * GameSystem.Difficulty
	
	ball.position = spawn_pos
	ball.Velocity = direction * speed
	
	
	add_child(ball)
