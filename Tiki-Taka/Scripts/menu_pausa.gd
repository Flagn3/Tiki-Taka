extends Control

var fullscreen=DisplayServer.window_get_mode()==DisplayServer.WINDOW_MODE_FULLSCREEN

func _ready() -> void:
	visible=false
	if fullscreen:
		$VBoxContainer/resolucion.text= "MODO VENTANA"
	else:
		$VBoxContainer/resolucion.text= "PANTALLA COMPLETA"
	
	var volumen=db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$VBoxContainer/sliderVolumen.value=volumen
	
	$VBoxContainer/reanudar.grab_focus()


func _on_reanudar_pressed() -> void:
	get_tree().paused=false
	visible=false


func _input(event):
	if event.is_action_pressed("Atras"):
		get_tree().paused=false
		visible=false




func _on_volumen_pressed() -> void:
	var sliderVolumen=$VBoxContainer/sliderVolumen
	sliderVolumen.visible = !sliderVolumen.visible

func _on_slider_volumen_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))



func _on_resolucion_pressed() -> void:
	fullscreen=!fullscreen
	
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$VBoxContainer/resolucion.text= "MODO VENTANA"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$VBoxContainer/resolucion.text= "PANTALLA COMPLETA"



func _on_menu_principal_pressed() -> void:
	get_tree().paused=false
	get_tree().change_scene_to_file("res://Escenas/selector_niveles.tscn")
