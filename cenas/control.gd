extends Control


@onready var agua_sprite: AnimatedSprite2D = $"../aguaSprite"


@onready var agua_2: Button = $agua2

func ready():
	pass
	



func _on_agua_2_pressed() -> void:
	agua_sprite.visible = true
	agua_sprite.play("aguaSprite")
	


#
#func _on_madeira_pressed() -> void:
	#madeiraSprite.visible = true
	#madeira.play("madeira")
	
	


#
#func _on_fogo_pressed() -> void:
	#fogo_sprite.visible = true
	#fogo_sprite.play(fogoSprite)


#func _on_vento_pressed() -> void:
	#vento_sprite.visible = true 
	#vento_sprite.play("ventoSprite")
