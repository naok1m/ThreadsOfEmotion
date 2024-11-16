# NPCBase.gd - Classe base para todos os NPCs
extends CharacterBody2D

@export var walk_speed: float = 150.0                   # Velocidade de movimento dos NPCs
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer                      # Timer para controlar a mudança de direção

@export var skin = 1

var direction = 0                                       # Direção atual do NPC (0 = esquerda, 1 = direita)

func _ready() -> void:
	# Configura o temporizador de direção com tempo aleatório inicial
	set_random_timer()
	
	# Escolhe uma direção inicial aleatória
	choose_random_direction()
	if skin > 5:
		skin = 5

func _physics_process(delta: float) -> void:
	# Move o NPC na direção escolhida
	if direction == 0:
		velocity.x = -walk_speed                        # Move para a esquerda                
		animated_sprite.play("esquerda")                # Toca a animação da esquerda
	elif direction == 1:
		velocity.x = walk_speed                         # Move para a direita              
		animated_sprite.play("direita")                 # Toca a animação da direita
	velocity.y += 980 * delta                           # Aplica a gravidade
	move_and_slide()                                    # Aplica o movimento ao NPC

func choose_random_direction() -> void:
	# Sorteia uma direção aleatória (0 para esquerda, 1 para direita)
	direction = randi() % 2                             # Gera 0 ou 1 aleatoriamente

func _on_direction_timer_timeout() -> void:
	# Escolhe uma nova direção e define um novo tempo aleatório para o temporizador
	choose_random_direction()
	set_random_timer()

func set_random_timer() -> void:
	# Define um tempo aleatório entre 3 e 7 segundos para o timer e o inicia
	timer.wait_time = randf_range(3.0, 7.0)
	timer.start()
