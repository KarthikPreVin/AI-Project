extends Camera2D

var dragging = false
var max_zoom = 2.0
var min_zoom = 0.5
var zoom_speed = 0.05
var max_scale = 4.0
var min_scale = 1.0
var scale_speed = 0.1
@onready var ui: Control = $UI
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		dragging = event.is_pressed()
	if event is InputEventMouseMotion and dragging:
		position = position-event.relative
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed)
			scale -= Vector2(scale_speed, scale_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed)
			scale += Vector2(scale_speed, scale_speed)
			
		zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
		scale = scale.clamp(Vector2(min_scale, min_scale), Vector2(max_scale, max_scale))
		print("zoom: ", zoom, " scale: ", scale)
