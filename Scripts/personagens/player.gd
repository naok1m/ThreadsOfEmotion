extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var aparecerbrux: Timer = $aparecerbrux
@onready var timer: Timer = $Timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0  # Define a gravidade manualmente
var fala_ativa = false
var repete = 0 

func _ready() -> void:
	# Começa com a animação de idle para ambos os sprites
	animated_sprite_2d.play("P_idle")
	animated_sprite_2d_2.play("P_idle")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interagir"):
		if Global.casa == 1 and repete == 0:
			repete = 1
			DialogManager.start_dialog(global_position, lines)
			Global.casa = 2
			fala_ativa = true
			aparecerbrux.start()
			print("fala")
		if Global.casa == 2 and Global.falas == 1:
			fala_ativa = true
		if Global.falas == 5 and repete == 0:
			repete = 1
			DialogManager.start_dialog(global_position, lines2)
			timer.start()
			fala_ativa = true
		if Global.falas == 7 and repete == 0:
			repete = 1
			DialogManager.start_dialog(global_position, lines3)
			timer.start()
		if Global.falas == 10 and repete == 0:
			repete = 1
			DialogManager.start_dialog(global_position, lines4)
			timer.start()
	if Global.falas == 12:
		fala_ativa = false
	print(Global.falas)
const lines: Array[String] = [
	"Olá? tem alguem que mora nessa casa?"
]
const lines2: Array[String] = [
	"Oi! Quem é você?"
]
const lines3: Array[String] = [
	"Ajuda? Como posso ajudar?"
]
const lines4: Array[String] = [
	"Entendi, vou fazer o meu melhor!"
]

func _on_timer_timeout() -> void:
	Global.falas = 4
	fala_ativa = false 
	Global.casa = 3
	DialogManager.close_dialog()
	repete = 0

func _on_looptimer_timeout() -> void:
	Global.falas += 1
	DialogManager.close_dialog()
	repete = 0













#movimentação
func _physics_process(delta: float) -> void:
	# Adiciona a gravidade ao personagem se ele não estiver no chão
	if not is_on_floor():
		velocity.y += GRAVITY * delta  # Usa apenas o valor escalar da gravidade

	# Lógica para pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not fala_ativa:
		velocity.y = JUMP_VELOCITY

	# Captura a direção do movimento horizontal (esquerda ou direita)
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0 and not fala_ativa:
		# Aplica a velocidade horizontal
		velocity.x = direction * SPEED
		
		# Alterna para a animação de andar e ajusta a direção do sprite
		animated_sprite_2d.play("p_walk")
		animated_sprite_2d_2.play("p_walk")
		
		# Inverte a escala no eixo X para olhar na direção correta
		animated_sprite_2d.flip_h = direction < 0
		animated_sprite_2d_2.flip_h = direction < 0
	else:
		# Zera a velocidade horizontal para evitar deslizamento
		velocity.x = 0
		if is_on_floor():
			# Se estiver parado no chão, usa a animação de idle
			animated_sprite_2d.play("P_idle")
			animated_sprite_2d_2.play("P_idle")

	# Verifica se está pulando ou caindo para escolher a animação
	if velocity.y < 0:
		# Animação de pulo (subindo)
		animated_sprite_2d.play("p_jump")
		animated_sprite_2d_2.play("p_jump")
	elif velocity.y > 0 and not is_on_floor():
		# Animação de queda (descendo)
		animated_sprite_2d.play("p_fall")
		animated_sprite_2d_2.play("p_fall")

	# Move o personagem com a velocidade calculada
	move_and_slide()
