extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var martelando: AnimatedSprite2D = $AnimatedSprite2D
@onready var raiva: AnimatedSprite2D = $AnimatedSprite2D2
@onready var npc: AnimatedSprite2D = $AnimatedSprite2D3
@onready var fala: Timer = $fala
@onready var tecla: AnimatedSprite2D = $tecla
var repete = 0

# Inicializa o timer para que alterne automaticamente a visibilidade
func _ready() -> void:
	# Configura o timer para repetir a cada 3 segundos
	timer.wait_time = 2.0
	timer.one_shot = false
	timer.start()
	raiva.play("default")
	martelando.play("martelando")




const lines: Array [String] = [
	"não vou entregar o machado até que me pague!!" 
]
const lines2: Array [String] = [
	"me entregue por favor, vou usar para pegar madeira e vender, com o dinheiro eu irei lhe pagar." 
]
const lines3: Array [String] = [
	"não aceito, pague logo, ou não terá o machado."
]

func _on_timer_timeout() -> void:
	# Alterna a visibilidade de raiva
	raiva.visible = not raiva.visible


func _on_fala_timeout() -> void:
	Global.ferreiro += 1
	DialogManager.close_dialog()
	repete = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if Global.ferreiro == 0:
		Global.ferreiro = 1
		tecla.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if Global.ferreiro == 1:
		Global.ferreiro = 0
		tecla.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interagir"):
		if Global.ferreiro == 1 and repete == 0:
			DialogManager.start_dialog(global_position, lines)
			repete = 1
			fala.start()
		if Global.ferreiro == 2 and repete == 0:
			DialogManager.start_dialog(global_position, lines2)
			repete = 1
			fala.start()
		if Global.ferreiro == 3 and repete == 0:
			repete = 1
			DialogManager.start_dialog(global_position, lines3)
			fala.start()
