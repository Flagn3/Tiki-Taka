extends Control

func _ready() -> void:
	$VBoxContainer/jugar.grab_focus()
	
	var config = ConfigFile.new()
	var ruta = "user://saves/save1.cfg"

	if not FileAccess.file_exists(ruta):
		DirAccess.make_dir_absolute("user://saves")
		config.set_value("global", "niveles_desbloqueados", 1)
		config.save(ruta)
	



func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/selector_archivo.tscn")


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu_opciones.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
