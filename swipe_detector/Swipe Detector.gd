extends Node2D
#Is used as to detect het left and right movement when item is selected
#to use it initialize the selected variable to tell when the even position to know
#when the swipe started  and swipe detected signal will shoot a Vector2 normalized data on timerout
#for you to use if the diretion was left or right, according to use
#manipulate the wait time on the timer node for how long 

signal swipe_detected(direction)
signal swipe_canceled(start_position)

export (float, 1.0, 1.5) var max_diagonal_slope = 1.3

onready var timer:Timer = $Timer
var swipe_start_position:Vector2 = Vector2()
var selected:bool

func _input(event: InputEvent) -> void:
	if !event is InputEventMouseMotion:
		return
	if selected:
		start_detection(event.position)
	elif !timer.is_stopped():
		end_detection(event.position)
	

func start_detection(position:Vector2):
	swipe_start_position = position
	timer.start()
	
func end_detection(position:Vector2):
	timer.stop()
	var direction = (position - swipe_start_position).normalized()
	if abs(direction.x) + abs(direction.y) >= max_diagonal_slope:
		return
	
	if abs(direction.x) > abs(direction.y):
		emit_signal("swipe_detected", Vector2(-sign(direction.x), 0.0))
	else:
		emit_signal("swipe_detected", Vector2(0.0, -sign(direction.y)))
	
func _on_Timer_timeout() -> void:
	emit_signal("swipe_canceled", swipe_start_position)
