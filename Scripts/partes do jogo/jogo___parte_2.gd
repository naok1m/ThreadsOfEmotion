extends Node2D
@onready var tecla: AnimatedSprite2D = $casa/AnimatedSprite2D
@onready var anima: AnimationPlayer = $"cenario/mato baixo/AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anima.play("movi")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.casa == 2:
		tecla.visible = false


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Global.casa == 0:
		tecla.visible = true
		Global.casa = 1


func _on_prox_cena_body_entered(body: Node2D) -> void:
	#prox cena
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://cenas/vilarejo.tscn")


func _on_casa_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and Global.casa == 1:
		tecla.visible = false
		Global.casa = 0
