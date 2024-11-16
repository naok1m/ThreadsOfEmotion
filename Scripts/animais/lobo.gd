extends CharacterBody2D

@export var run_speed: float = 400.0                    # Velocidade de corrida do lobo
@export var gravity: float = 980.0                      # Intensidade da gravidade
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var is_running = false                                  # Controla se o lobo está correndo

func _ready() -> void:
	# Inicia o lobo com a animação parado (moon_w)
	animated_sprite.play("moon_w")

func _physics_process(delta: float) -> void:
	# Aplica a gravidade se o lobo não estiver no chão
	if not is_on_floor():
		velocity.y += gravity * delta  # Aumenta a velocidade vertical para baixo

	if is_running:
		# Configura o movimento para a direita com a velocidade de corrida
		velocity.x = run_speed
	else:
		velocity.x = 0  # Para de se mover horizontalmente quando não está correndo

	# Move o lobo com a velocidade calculada
	move_and_slide()

func start_running() -> void:
	is_running = true
	animated_sprite.play("walk_w")                      # Troca para a animação de corrida
	animated_sprite.flip_h = true                       # Garante que ele está correndo para a direita

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":   
		start_running()
		timer.start()

func _on_timer_timeout() -> void:
	queue_free()
