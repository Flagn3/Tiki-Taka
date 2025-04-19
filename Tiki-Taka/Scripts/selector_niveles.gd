extends Control


var nivel_desbloqueado

func _ready():
	Progreso.cargar()
	nivel_desbloqueado = Progreso.nivel_desbloqueado
	
	$GridContainer/VBoxContainer/Button.grab_focus()
	var grid = $GridContainer
	var containers = grid.get_children()
	var diamantes_por_nivel=Progreso.diamantes_por_nivel
	
	for i in range(containers.size()):
		var container = containers[i]
		var boton = container.get_node("Button")
		var nivel_num = i + 1
		var label_diamantes = container.get_node("DiamantesLabel")
		
		boton.text = "Nivel %d" % nivel_num
		
		
		var cantidad = diamantes_por_nivel.get(nivel_num, 0)
		var texto_diamantes = ""
		
		for j in range(3):
			if j<cantidad:
				texto_diamantes += "💎"
			else:
				texto_diamantes += "⚪"
		
		label_diamantes.text = "|"+texto_diamantes+"|"
		
		
		if nivel_num <= nivel_desbloqueado:
			boton.disabled = false
			boton.connect("pressed", Callable(self, "_on_nivel_presionado").bind(nivel_num))
		else:
			boton.disabled = true
			boton.text += "🔒"

func _input(event):
	if event.is_action_pressed("Atras"):
		get_tree().change_scene_to_file("res://Escenas/selector_archivo.tscn")

func _on_nivel_presionado(nivel: int) -> void:
	var ruta_nivel = "res://Escenas/nivel%d.tscn" % nivel
	get_tree().change_scene_to_file(ruta_nivel)
