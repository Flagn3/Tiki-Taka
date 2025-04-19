extends Control

@onready var diamante1 = $Panel/VBoxContainer/HBoxContainer/Control1/Diamante1
@onready var diamante2 = $Panel/VBoxContainer/HBoxContainer/Control2/Diamante2
@onready var diamante3 = $Panel/VBoxContainer/HBoxContainer/Control3/Diamante3

@export var nivel_actual: int = 1
const TOTAL_NIVELES = 6

func _ready() -> void:
	visible=false
	$Panel/VBoxContainer/Siguiente_nivel.grab_focus()

func mostrar(diamantes_recogidos: int):
	get_tree().paused = true
	visible = true
	$Panel/VBoxContainer/Siguiente_nivel.grab_focus()
	
	
	var sprites = [diamante1, diamante2, diamante3]
	for sprite in sprites:
		sprite.modulate = Color(1,1,1,0.2)
	
	mostrar_diamantes(diamantes_recogidos)



func mostrar_diamantes(recogidos: int) -> void:
	var sprites = [diamante1, diamante2, diamante3]
	
	for i in range(sprites.size()):
		if i < recogidos:
			await get_tree().create_timer(0.5).timeout
			sprites[i].modulate = Color(1,1,1,1)
			
			sprites[i].scale = Vector2(0.5, 0.5)
			var tween = create_tween()
			tween.tween_property(sprites[i], "scale", Vector2(1, 1), 0.3)
			
			$SonidoDiamante.play()



func _on_siguiente_nivel_pressed() -> void:
	
	if nivel_actual < TOTAL_NIVELES:
		var siguiente_nivel = nivel_actual + 1
		var ruta_siguiente = "res://Escenas/nivel%d.tscn" % siguiente_nivel
		get_tree().paused=false
		get_tree().change_scene_to_file(ruta_siguiente)
	else:
		get_tree().paused=false
		get_tree().change_scene_to_file("res://Escenas/selector_niveles.tscn")




func _on_reintentar_pressed() -> void:
	var ruta_actual = "res://Escenas/nivel%d.tscn" % nivel_actual
	get_tree().paused=false
	get_tree().change_scene_to_file(ruta_actual)




func _on_salir_pressed() -> void:
	get_tree().paused=false
	get_tree().change_scene_to_file("res://Escenas/selector_niveles.tscn")
