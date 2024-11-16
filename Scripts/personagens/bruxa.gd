extends CharacterBody2D
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated2: AnimatedSprite2D = $AnimatedSprite2D2
var player_in_area = false
@onready var tecla: AnimatedSprite2D = $"area fala"/AnimatedSprite2D
@onready var bruxa: CharacterBody2D = $"."
@onready var timerbruxa: Timer = $Timerbruxa
var repete = 0

func _ready() -> void:
	animated.play("default")
	animated2.play("default")

func _process(delta: float) -> void:
	if Global.casa == 3:
		bruxa.visible = true

	if Global.falas == 6 and Input.is_action_just_pressed("interagir") and repete == 0:
		repete = 1
		DialogManager.start_dialog(global_position, linesb)
		timerbruxa.start()
	if Global.falas == 8 and Input.is_action_just_pressed("interagir") and repete == 0:
		repete = 1
		DialogManager.start_dialog(global_position, linesb2)
		timerbruxa.start()
	if Global.falas == 9 and Input.is_action_just_pressed("interagir") and repete == 0:
		repete = 1
		DialogManager.start_dialog(global_position, linesb3)
		timerbruxa.start()
	if Global.falas == 11 and Input.is_action_just_pressed("interagir") and repete == 0:
		repete = 1
		DialogManager.start_dialog(global_position, linesb4)
		timerbruxa.start()
		tecla.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Global.falas == 4:
		Global.falas = 5
		print("entrou na area")
		tecla.visible = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and Global.falas == 5:
		Global.falas = 4
		tecla.visible = false

const linesb: Array[String] = [
	"Olá, pequeno aventureiro! Eu sou a Bruxa dos Elementos. Meu nome é Luna. Eu protejo a floresta e todos os seus segredos. Mas preciso de ajuda!"
]
const linesb2: Array[String] = [
	"Preciso que use os poderes que darei a você para enfrentar minha irmã gêmea do mal!!"
]
const linesb3: Array [String] = [
	"Mas lembre-se, os poderes são para o bem! A água pode acalmar, o fogo pode aquecer, a terra pode proteger, e o vento pode levar paz. Use-os com sabedoria!"
]
const linesb4: Array[String] = [
		"Obrigada! Com sua ajuda, a floresta vai ficar segura. Agora, vá até o vilarejo!"
]





func _on_timerbruxa_timeout() -> void:
	Global.falas += 1
	DialogManager.close_dialog()
	print("a")
	repete = 0
