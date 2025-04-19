extends Node2D

const velocidad := 60
@export var distancia_max := 150 

@export var direccion := -1
var punto_inicial: Vector2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	punto_inicial = global_position

func _process(delta: float) -> void:
	global_position.x += (direccion * velocidad * delta)
	
	var distancia_actual := global_position.distance_to(punto_inicial)
	
	if distancia_actual >= distancia_max:
		direccion *= -1
		punto_inicial = global_position 
