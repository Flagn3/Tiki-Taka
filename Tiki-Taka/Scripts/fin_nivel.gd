extends Area2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animation.play()

func _on_body_entered(body: Node2D) -> void:
	
	var nombre_escena = get_tree().current_scene.name
	var nivel_actual = int(nombre_escena.replace("nivel", ""))
	
	var recogidos = clamp(GameManager.puntuacion, 0, 3)
	var previos = Progreso.diamantes_por_nivel.get(nivel_actual, 0)
	
	if recogidos > previos:
		var nuevos = recogidos - previos
		Progreso.diamantes += nuevos
		Progreso.diamantes_por_nivel[nivel_actual] = recogidos
	
	Progreso.nivel_desbloqueado = max(Progreso.nivel_desbloqueado, nivel_actual + 1)
	Progreso.guardar()
	
	var resumen = get_node("../Resumen_nivel")
	resumen.nivel_actual = nivel_actual
	resumen.mostrar(recogidos)
