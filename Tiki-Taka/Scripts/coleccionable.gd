extends Area2D


@onready var sonido_moneda: AudioStreamPlayer = $SonidoMoneda
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D



func _on_body_entered(body: Node2D) -> void:
	GameManager.incrementar_puntuacion()
	sonido_moneda.play()
	collision_shape_2d.call_deferred("set", "disabled", true)
