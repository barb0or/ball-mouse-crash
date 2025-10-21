extends CanvasLayer

@onready var ScoreLabel: Label = $ScoreLabel
@onready var GameOverScreen = $GameOverScreen

func _ready():
	GameSystem.connect("OnScoreUpdated", _UpdateScore)
	GameSystem.connect("OnGameOver", _ShowGameOver)

func _UpdateScore(new_score):
	ScoreLabel.text = "Score: %s" % new_score

func _ShowGameOver():
	GameOverScreen.ShowScreen()
