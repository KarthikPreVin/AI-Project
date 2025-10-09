extends Camera2D

var dragging = false

var zoom_array =  [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0]
var scale_array = [4.0, 3.50, 2.0, 1.80, 1.33, 1.2, 1.0]
var index  = 6

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		dragging = event.is_pressed()
	if event is InputEventMouseMotion and dragging:
		position = position-event.relative
		if position.x < 0:
			position.x = 0
		if position.x>2500:
			position.x = 2500
		if position.y < 0:
			position.y = 0
		if position.y>2500:
			position.y = 2500
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			index+=1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			index-=1
		index = clamp(index,0,6)
		zoom = Vector2(zoom_array[index],zoom_array[index])
		scale = Vector2(scale_array[index],scale_array[index])
