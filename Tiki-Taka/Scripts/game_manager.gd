extends Node

var puntuacion = 0
var tiempo = 0
var tiempo_para_guardar = 0


@onready var etiqueta_puntuacion: Label = $"../Jugador/Camera2D/Puntuacion"

func _ready() -> void:
	tiempo = 0
	set_process(true)

func _process(delta: float) -> void:
	tiempo += delta
	tiempo_para_guardar += delta
	
	if tiempo_para_guardar >= 15:
		guardar_tiempo()
		tiempo_para_guardar = 0

func guardar_tiempo():
	Progreso.tiempo_jugado += int(tiempo)
	tiempo = 0
	Progreso.guardar()

func incrementar_puntuacion():
	puntuacion += 1

func reiniciar_puntuacion():
	puntuacion = 0
	actualizar_puntuacion()

func actualizar_puntuacion():
	if etiqueta_puntuacion:
		etiqueta_puntuacion.text = "Diamantes: " + str(puntuacion)
