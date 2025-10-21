extends Area2D

var Velocity: Vector2 = Vector2.ZERO
@onready var ball_texture: Sprite2D = $BallTexture


func _ready():
	if randi()%10:
		modulate = Color(randf_range(0.3, 1.0), randf_range(0.3, 1.0), randf_range(0.3, 1.0))
	scale = randf_range(0.5, 1.5) * Vector2.ONE
	add_to_group("Actor.Ball")

func _process(delta):
	position += Velocity * delta

func _on_mouse_entered():
	GameSystem.SetGameOver()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
