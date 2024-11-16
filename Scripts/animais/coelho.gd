extends CharacterBody2D
@onready var coelho: CharacterBody2D = $"."

@export var walk_speed: float = 200.0                # Velocidade de caminhada do coelho
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var is_walking = false                               # Controla se o coelho está andando

func _ready() -> void:
	# Inicia o coelho com a animação de parado (idle)
	coelho.visible = false
	animated_sprite.flip_h = false                   # Certifica-se de que o coelho está voltado para a esquerda inicialmente

func _physics_process(delta: float) -> void:
	if is_walking:
		# Configura o movimento para a esquerda com a velocidade de caminhada
		velocity.x = -walk_speed                     # Movimento para a esquerda
		move_and_slide()                             # Move o coelho com a velocidade calculada
func start_walking() -> void:
	is_walking = true
	animated_sprite.play("walk")                     # Troca para a animação de caminhada
	animated_sprite.flip_h = true                    # Certifica-se de que ele está voltado para a esquerda

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":                        # Verifica se o jogador entrou na área
		start_walking()
		coelho.visible = true
		timer.start()

func _on_timer_timeout() -> void:
	queue_free()
