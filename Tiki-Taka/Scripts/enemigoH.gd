extends Node2D

const VELOCIDAD = 100

#negativo para ir a la izquierda, positivo a la derecha
var direccion = -1

@onready var ray_cast_izquierda: RayCast2D = $RayCastIzquierda
@onready var ray_cast_derecha: RayCast2D = $RayCastDerecha
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	#si detecta un muro cambia de direccion
	if ray_cast_izquierda.is_colliding():
		direccion = 1
		animated_sprite.flip_h = true
	if ray_cast_derecha.is_colliding():
		direccion = -1
		animated_sprite.flip_h = false
	
	position.x += (direccion * VELOCIDAD * delta) #multiplicar por delta para adaptarse a cada pc
	
