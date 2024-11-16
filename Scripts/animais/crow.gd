extends CharacterBody2D

@export var fly_speed: float = 300               # Velocidade de fuga para o corvo
@export var vertical_speed: float = 100          # Aumente para subir mais rapidamente
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var disappear_timer: Timer = $Timer
@onready var animated2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var crow: CharacterBody2D = $"."

var is_flying = false                            # Controla se o corvo está voando

func _ready():
	# Inicia a animação de "bicando"
	animated.play("bicar")
	# Inicia o segundo sprite como invisível
	animated2.visible = false
	

func _physics_process(delta):
	if is_flying:
		# Movimento de fuga para a esquerda com subida mais rápida
		velocity.x = -fly_speed
		velocity.y = -vertical_speed               # Subida constante e mais rápida

		# Espelha o sprite horizontalmente para que pareça estar voando para frente
		animated.flip_h = true

		# Move o corvo com a combinação dos movimentos
		move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":                    # Verifica se é o jogador
		is_flying = true                         # Ativa o modo de voo
		
		# Torna o primeiro sprite invisível e ativa o segundo com a animação "prefly"
		animated.visible = false
		animated2.visible = true
		animated2.flip_h = true
		animated2.play("prefly")                 # Muda para a animação de pré-voo
		
		# Inicia o timer para desaparecer
		disappear_timer.start()                  

func _on_disappear_timeout() -> void:
	# Remove o corvo da cena após o timer expirar
	queue_free()

func _on_animated_sprite_2d_2_animation_finished() -> void:
	# Torna o segundo sprite invisível e o primeiro visível novamente após "prefly"
	animated2.visible = false
	animated.visible = true
	# Inicia a animação de voo ("fly") no primeiro sprite
	animated.play("fly")
