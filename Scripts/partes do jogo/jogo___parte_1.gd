extends Node2D
@onready var anima: AnimationPlayer = $cenario/Node2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anima.play("movi")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://cenas/jogo___parte_2.tscn") 
