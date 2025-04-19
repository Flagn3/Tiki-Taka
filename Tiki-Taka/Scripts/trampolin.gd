extends Area2D

@export var impulso: Vector2 = Vector2(0, -500)
@onready var animacion: AnimatedSprite2D = $AnimatedSprite2D
@onready var sonido: AudioStreamPlayer = $sonido


func _ready() -> void:
	animacion.play("idle")



func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name!= "Jugador":
		return
	
	if "velocity" in body:
		animacion.play("activado")
		sonido.play()

		body.velocity = impulso
		body.can_dash = true
		
		await  animacion.animation_finished
		animacion.play("idle")
		
