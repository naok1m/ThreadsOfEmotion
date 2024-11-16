extends Node2D

@onready var anima: AnimatedSprite2D = $Anim
@onready var anim2: AnimatedSprite2D = $Anim2
@onready var camera: Camera2D = $Camera2D
@onready var jogar: Button = $VBoxContainer/jogar
@onready var opcoes: Button = $"VBoxContainer/opções"
@onready var creditos: Button = $VBoxContainer/creditos
@onready var sair: Button = $VBoxContainer/sair

# Lista de botões para navegação
var botoes = []
var current_button_index = 0  # Índice do botão atualmente selecionado

func _ready() -> void:
	# Armazena os botões na ordem de navegação (de cima para baixo)
	botoes = [jogar, opcoes, creditos, sair]
	highlight_button()  # Destaque inicial no primeiro botão

# Atualiza o destaque do botão atual
func highlight_button() -> void:
	for i in range(botoes.size()):
		botoes[i].focus_mode = Button.FOCUS_NONE  # Remove o foco de todos os botões
	botoes[current_button_index].focus_mode = Button.FOCUS_ALL  # Define o foco no botão atual
	botoes[current_button_index].grab_focus()  # Aplica o foco visual no botão atual

# Navegação usando as setas direcionais
func _input(event: InputEvent) -> void:
	# Navegação para baixo
	if event.is_action_pressed("ui_down"):
		current_button_index = (current_button_index + 1) % botoes.size()
		highlight_button()

	# Navegação para cima
	elif event.is_action_pressed("ui_up"):
		current_button_index = (current_button_index - 1 + botoes.size()) % botoes.size()
		highlight_button()

	# Navegação para a direita (ciclo pelo próximo botão)
	elif event.is_action_pressed("ui_right"):
		current_button_index = (current_button_index + 1) % botoes.size()
		highlight_button()

	# Navegação para a esquerda (ciclo pelo botão anterior)
	elif event.is_action_pressed("ui_left"):
		current_button_index = (current_button_index - 1 + botoes.size()) % botoes.size()
		highlight_button()

	# Seleciona o botão atual ao pressionar Enter
	elif event.is_action_pressed("ui_accept"):
		botoes[current_button_index].emit_signal("pressed")  # Simula o clique do botão atual

# botão de jogar
func _on_jogar_pressed() -> void:
	anim()
	# Código para o botão jogar

# botão opções
func _on_opções_pressed() -> void:
	anim()
	# Código para o botão opções

# botão créditos
func _on_creditos_pressed() -> void:
	anim()
	# Código para o botão créditos

# botão sair
func _on_sair_pressed() -> void:
	get_tree().quit()

# Animação de transição
func anim():
	for botao in botoes:
		botao.visible = false
	anima.play("default")

func _on_anim_animation_finished() -> void:
	anim2.play("default")

func _on_anim_2_animation_finished() -> void:
	camera.start_zoom_out()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if current_button_index == 0:  # Jogo
		get_tree().change_scene_to_file("res://cenas/jogo___parte_1.tscn")
