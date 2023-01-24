extends RigidBody2D
class_name ThrowableObject
#I orignally wanted this to be a component so I can turn any thing into a throable object
#Don't know how to give rigid body behavior to parent so rigid body is now the parent node
#of all ingredient items
signal selected(bool_value)

var cursor_hovering:bool = false
var selected:bool = false setget set_selected
var mouse_speed:Vector2

func _ready() -> void:
	self.connect("mouse_entered", self, "_on_TestIngredient_mouse_entered")
	self.connect("mouse_exited", self, "_on_TestIngredient_mouse_exited")

func set_selected(value):
	selected = value
	emit_signal("selected", value)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_speed = event.relative
	if Input.is_action_just_pressed("left_click"):
		if !cursor_hovering:
			return
		mode = RigidBody2D.MODE_STATIC
		self.selected = true
	if Input.is_action_just_released("left_click"):
		if selected:
			mode = RigidBody2D.MODE_RIGID
			apply_central_impulse(mouse_speed * 50)
		self.selected = false

func change_render_layer(z_layer:int, collision_layer:int):
	z_index = z_layer
	layers = collision_layer

func reset_position():
	global_transform.origin = Vector2(50, 90)

func _physics_process(delta: float) -> void:
	if selected:
		global_transform.origin = get_global_mouse_position()
		global_rotation = move_toward(global_rotation, 0, delta * 5)

func _on_TestIngredient_mouse_entered() -> void:
	cursor_hovering = true

func _on_TestIngredient_mouse_exited() -> void:
	cursor_hovering = false
