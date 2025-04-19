extends Node

var diamantes_por_nivel: Dictionary = {}
var tiempo_jugado: int = 0  # segundos
var nivel_desbloqueado: int = 1
var diamantes: int = 0
var archivo_actual: String = ""

func guardar() -> void:
	if archivo_actual == "":
		print("No hay archivo seleccionado para guardar.")
		return
	
	var config = ConfigFile.new()
	config.set_value("progreso", "nivel_desbloqueado", nivel_desbloqueado)
	config.set_value("progreso", "diamantes", diamantes)
	config.set_value("progreso", "tiempo_jugado", tiempo_jugado)
	config.set_value("progreso", "diamantes_por_nivel", diamantes_por_nivel)
	
	var ruta = "user://saves/%s.cfg" % archivo_actual
	var error = config.save(ruta)
	
	if error != OK:
		print("Error guardando el archivo: ", error)


func cargar() -> void:
	if archivo_actual == "":
		print("No hay archivo seleccionado para cargar.")
		return
	
	var ruta = "user://saves/%s.cfg" % archivo_actual
	var config = ConfigFile.new()
	var error = config.load(ruta)
	
	if error != OK:
		print("Archivo no encontrado. Se creará uno nuevo.")
		return
	
	nivel_desbloqueado = config.get_value("progreso", "nivel_desbloqueado", 1)
	diamantes = config.get_value("progreso", "diamantes", 0)
	tiempo_jugado = config.get_value("progreso", "tiempo_jugado", 0)
	diamantes_por_nivel = config.get_value("progreso", "diamantes_por_nivel", {})


func borrar_archivo() -> void:
	if archivo_actual == "":
		return
	
	var ruta = "user://saves/%s.cfg" % archivo_actual
	DirAccess.remove_absolute(ruta)
