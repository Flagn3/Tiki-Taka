extends Node2D

@onready var sprite: Node2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var sonido: AudioStreamPlayer = $AudioStreamPlayer

@export var respawn = 1

func _ready() -> void:
	sprite.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if not sprite.visible:
		return
	
	if "can_dash" in body:
		body.can_dash = true
		sonido.play()
		desaparecer()

func desaparecer():
	sprite.visible = false
	$CollisionShape2D.disabled = true
	timer.start(respawn)



func _on_timer_timeout() -> void:
	sprite.visible = true
	$CollisionShape2D.disabled = false
