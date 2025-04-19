extends Control

var seleccion_actual = 0
var slots = 3

func _ready() -> void:
	input_update()


func _input(event):
	if event.is_action_pressed("ui_down"):
		seleccion_actual = (seleccion_actual + 1) % slots
		input_update()
	elif event.is_action_pressed("ui_up"):
		seleccion_actual = (seleccion_actual - 1 + slots) % slots
		input_update()
	elif event.is_action_pressed("Confirmar"):
		jugar(seleccion_actual)
	elif event.is_action_pressed("Borrar"):
		borrar(seleccion_actual)
	elif event.is_action_pressed("Atras"):
		get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")


func input_update():
	for i in range(slots):
		var slot = $Archivos.get_child(i)
		var style = StyleBoxFlat.new()
		
		if i == seleccion_actual:
			style.bg_color = Color("#FFD700") 
		else:
			style.bg_color = Color("#333333") 
		
		slot.add_theme_stylebox_override("panel", style)
		
		var nombre_archivo = "slot_%d" % (i + 1)
		var ruta = "user://saves/%s.cfg" % nombre_archivo
		var label_info = slot.get_child(0).get_node("Info")

		if FileAccess.file_exists(ruta):
			var config = ConfigFile.new()
			var err = config.load(ruta)
			if err == OK:
				var diamantes = config.get_value("progreso", "diamantes", 0)
				var tiempo = config.get_value("progreso", "tiempo_jugado", 0)
				
				var horas = tiempo/3600
				var minutos = (tiempo % 3600) / 60
				
				label_info.text = "\n💎 x %d\n⏱️ %dh %02dm" % [diamantes, horas, minutos]
			else:
				label_info.text = "Error al cargar"
		else:
			label_info.text = "Ranura vacía"


func jugar(slot_id: int) -> void:
	var nombre_archivo = "slot_%d" % (slot_id+1)
	Progreso.archivo_actual = nombre_archivo
	
	var ruta = "user://saves/%s.cfg" % nombre_archivo
	if not FileAccess.file_exists(ruta):
		Progreso.diamantes_por_nivel = {}
		Progreso.nivel_desbloqueado = 1
		Progreso.diamantes = 0
		Progreso.guardar()
		print("Archivo nuevo creado:", ruta)
	else:
		Progreso.cargar()
		print("Archivo cargado:", ruta, " Nivel:", Progreso.nivel_desbloqueado)
	
	get_tree().change_scene_to_file("res://Escenas/selector_niveles.tscn")

func borrar(slot_id: int) -> void:
	var nombre_archivo = "slot_%d" % (slot_id + 1)
	var ruta = "user://saves/%s.cfg" % nombre_archivo
	if FileAccess.file_exists(ruta):
		DirAccess.remove_absolute(ruta)
		print("Archivo borrado:", ruta)
	else:
		print("El archivo no existe. Nada que borrar.")
