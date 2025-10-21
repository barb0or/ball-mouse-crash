extends Node

var Score: int = 0
var IsGameOver: bool = false
var Difficulty: float = 1.0

var ScoreTimer: Timer

signal OnScoreUpdated(new_score)
signal OnGameOver

func _ready():
	ScoreTimer = Timer.new()
	ScoreTimer.wait_time = 1.0
	ScoreTimer.connect("timeout", _IncrementScore)
	add_child(ScoreTimer)
	
	StartGame()

func _process(delta: float):
	if IsGameOver:
		return
	
	Difficulty += delta * 0.02

func StartGame():
	Score = 0
	Difficulty = 1.0
	IsGameOver = false
	ScoreTimer.start()
	#get_tree().call_group("Actor.Ball", "queue_free")
	get_tree().reload_current_scene.call_deferred()

func SetGameOver():
	if IsGameOver:
		return
	
	IsGameOver = true
	ScoreTimer.stop()
	emit_signal("OnGameOver")

func _IncrementScore():
	Score += 1
	emit_signal("OnScoreUpdated", Score)
