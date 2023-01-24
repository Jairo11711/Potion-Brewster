extends ThrowableObject
class_name Ingredient

#you must pair up the effect_type and effect_strength by index
export(String) var item_name
export(Array, GameManager.effect_names) var effect_type
export(Array, int) var effect_strength

onready var area2D:Area2D = $Area2D

func _ready() -> void:
	add_to_group("ingredient")
	area2D.connect("mouse_entered", self, "_on_TestIngredient_mouse_entered")
	area2D.connect("mouse_exited", self, "_on_TestIngredient_mouse_exited")

func exist():
	pass
