extends Node2D

var juego_pausado

func _ready():
	GameManager.reiniciar_puntuacion()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		pausar()

func pausar():
	juego_pausado=!get_tree().paused
	get_tree().paused=juego_pausado
	$MenuPausa.visible=juego_pausado
	#$Jugador/Camera2D/MenuPausa.visible=juego_pausado
	#$Jugador/Camera2D/MenuPausa.get_node("VBoxContainer/reanudar").grab_focus()
	$MenuPausa.get_node("VBoxContainer/reanudar").grab_focus()
