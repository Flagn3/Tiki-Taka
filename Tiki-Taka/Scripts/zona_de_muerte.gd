extends Area2D

@onready var timer: Timer = $Timer
@onready var sonido_muerte: AudioStreamPlayer = $SonidoMuerte


#Cuando se atraviese el area inicia el timer
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name != "Jugador":
		return
	
	print("Game over")
	body.get_node("CollisionShape2D").queue_free()
	body.muerto = true
	sonido_muerte.play()
	
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
