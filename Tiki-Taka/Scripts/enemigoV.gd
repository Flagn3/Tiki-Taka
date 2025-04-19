extends Node2D

const VELOCIDAD = 100

#negativo para ir a la izquierda, positivo a la derecha
var direccion = -1

@onready var ray_cast_arriba: RayCast2D = $RayCastArriba
@onready var ray_cast_abajo: RayCast2D = $RayCastAbajo
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	#si detecta un muro cambia de direccion
	if ray_cast_arriba.is_colliding():
		direccion = 1
	if ray_cast_abajo.is_colliding():
		direccion = -1
	
	position.y += (direccion * VELOCIDAD * delta) #multiplicar por delta para adaptarse a cada pc
