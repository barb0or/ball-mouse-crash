extends Control

@onready var RestartButton: TextureButton = $"../RestartButton"

func _ready():
	RestartButton.connect("pressed", _OnRestart)
	hide()
	RestartButton.hide()

func ShowScreen():
	show()
	RestartButton.show()

func _OnRestart():
	GameSystem.StartGame()
