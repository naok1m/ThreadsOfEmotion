# Script na Camera2D
extends Camera2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_zoom_in():
	animation_player.play("ZoomIn")

func start_zoom_out():
	animation_player.play("ZoomOut")
