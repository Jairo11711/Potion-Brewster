extends ThrowableObject
class_name StirringRod

onready var swipeDetector:Node2D = $"Swipe Detector"

var in_viable_area:bool = false setget set_in_viable_area
var left_motion:bool = false
var right_motion:bool = false

func _ready() -> void:
	GameManager.stirring_rod = self

func set_in_viable_area(value):
	in_viable_area = value
	swipeDetector.selected = value

func check_for_full_stir_motion():
	if left_motion and right_motion:
		left_motion = false
		right_motion = false
		GameManager.cauldon.add_stirred_amount(1)
	

func _on_Swipe_Detector_swipe_detected(direction) -> void:
	if direction == Vector2(1, 0):
		left_motion = true
		check_for_full_stir_motion()
	elif direction == Vector2(-1, 0):
		right_motion = true
		check_for_full_stir_motion()


func _on_Area2D_area_entered(area: Area2D) -> void:
	swipeDetector.selected = true


func _on_Area2D_area_exited(area: Area2D) -> void:
	swipeDetector.selected = false
