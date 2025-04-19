extends CharacterBody2D


const SPEED = 100
const JUMP_VELOCITY = -300
const DASH_SPEED = 300 
const DASH_TIME = 0.2 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sonido_salto: AudioStreamPlayer = $SonidoSalto
@onready var sonido_dash: AudioStreamPlayer = $SonidoDash
@onready var dash_timer: Timer = $DashTimer

var is_dashing = false
var can_dash = true
var dash_direction = Vector2.ZERO
var mirada = Vector2.RIGHT
var muerto: bool = false


func _physics_process(delta: float) -> void:
	if muerto:
		return
	# Restablecer el dash cuando el personaje toque el suelo
	if is_on_floor():
		can_dash = true 
	# Gravedad
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

	# Saltar
	if Input.is_action_just_pressed("Saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sonido_salto.play()

# Iniciar dash
	if Input.is_action_just_pressed("Dash") and can_dash and not is_dashing:
		start_dash()

	# Lógica de dash
	if is_dashing:
		velocity = dash_direction * DASH_SPEED
	else:
	#Moverse en el eje X
		var direction := Input.get_axis("mover_izquierda", "mover_derecha")
	#Voltear la animacion hacia el lado que se está andando
		if direction > 0:
			animated_sprite.flip_h = false
			mirada= Vector2.RIGHT
		elif direction < 0:
			animated_sprite.flip_h = true
			mirada= Vector2.LEFT

		if is_on_floor():
			if direction == 0:
				animated_sprite.play("Idle")
			else:
				animated_sprite.play("Run")
		else:
			if velocity.y < 0:
				animated_sprite.play("Saltar")
			elif velocity.y > 0:
				animated_sprite.play("Caer")
	
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	move_and_slide()
	
#Función que regula el dash
func start_dash():
	is_dashing = true
	can_dash = false
	dash_timer.start(DASH_TIME)
	sonido_dash.play()

	# Detectamos la dirección del dash
	var input_direction = Vector2(
		Input.get_axis("mover_izquierda", "mover_derecha"),
		Input.get_axis("mover_arriba", "mover_abajo")
	)

	# Si no hay dirección, se usa la dirección en la que mira el personaje
	if input_direction == Vector2.ZERO:
		input_direction = mirada

	dash_direction = input_direction.normalized()

	# Desactivamos la gravedad durante el dash
	velocity = dash_direction * DASH_SPEED

func _on_dash_timer_timeout() -> void:
	is_dashing = false #para detener el dash al acabar el timer
