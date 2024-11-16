extends Node2D
@onready var tocha: AnimatedSprite2D = $"decoração/tocha"
@onready var tocha2: AnimatedSprite2D = $"decoração/tocha2"
@onready var tocha3: AnimatedSprite2D = $"decoração/tocha3"
@onready var tocha4: AnimatedSprite2D = $"decoração/tocha4"
@onready var tocha5: AnimatedSprite2D = $"decoração/tocha5"
@onready var tocha6: AnimatedSprite2D = $"decoração/tocha6"
@onready var fogueiraP: AnimatedSprite2D = $"decoração/fogueiraP"
@onready var fogueiraG: AnimatedSprite2D = $"decoração/fogueiraG"
@onready var animation_player: AnimationPlayer = $floresta/florestamovi/AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tocha.play("default")
	tocha2.play("default")
	tocha3.play("default")
	tocha4.play("default")
	tocha5.play("default")
	tocha6.play("default")
	fogueiraP.play("default")
	fogueiraG.play("default")
	animation_player.play("movi")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
