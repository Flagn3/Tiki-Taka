extends Control

var fullscreen=DisplayServer.window_get_mode()==DisplayServer.WINDOW_MODE_FULLSCREEN

func _ready() -> void:
	if fullscreen:
		$VBoxContainer/resolucion.text= "MODO VENTANA"
	else:
		$VBoxContainer/resolucion.text= "PANTALLA COMPLETA"
	
	var volumen=db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$VBoxContainer/reguladorVolumen.value=volumen
	
	$VBoxContainer/volumen.grab_focus()

func _input(event):
	if event.is_action_pressed("Atras"):
		get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")


func _on_volumen_pressed() -> void:
	var sliderVolumen=$VBoxContainer/reguladorVolumen
	sliderVolumen.visible = !sliderVolumen.visible


func _on_regulador_volumen_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))



func _on_resolucion_pressed() -> void:
	fullscreen=!fullscreen
	
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$VBoxContainer/resolucion.text= "MODO VENTANA"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$VBoxContainer/resolucion.text= "PANTALLA COMPLETA"




func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")
