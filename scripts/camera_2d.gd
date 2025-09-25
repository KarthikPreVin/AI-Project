extends Camera2D

var dragging = false
#var max_zoom = 2.0
#var min_zoom = 0.5
#var zoom_speed = 1.047294123

var zoom_array =  [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0]
var scale_array = [4.0, 3.50, 2.0, 1.80, 1.33, 1.2, 1.0]
var index  = 6
#var zoom_speed = 0.5
#var max_scale = 4.0
#var min_scale = 1.0
#var scale_speed = 1

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		dragging = event.is_pressed()
	if event is InputEventMouseMotion and dragging:
		position = position-event.relative
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			index+=1
			#zoom += Vector2(zoom_speed, zoom_speed)
			#scale -= Vector2(scale_speed, scale_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			index-=1
			#zoom -= Vector2(zoom_speed, zoom_speed)
			#scale += Vector2(scale_speed, scale_speed)
			
		index = clamp(index,0,6)
		#zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
		#scale = scale.clamp(Vector2(min_scale, min_scale), Vector2(max_scale, max_scale))
		zoom = Vector2(zoom_array[index],zoom_array[index])
		scale = Vector2(scale_array[index],scale_array[index])
		print("zoom: ", zoom, " scale: ", scale)
