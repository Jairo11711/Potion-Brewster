extends Node2D

onready var animationPlayer:AnimationPlayer = $AnimationPlayer

const boom_rat = preload("res://Ingredients/ingredient_tscn/BoomRat.tscn")
const heart_plum = preload("res://Ingredients/ingredient_tscn/HearthBerry.tscn")
const mold_caps = preload("res://Ingredients/ingredient_tscn/MoldCaps.tscn")
const mud_umbrella = preload("res://Ingredients/ingredient_tscn/MudUmbrella.tscn")
const sweet_berry = preload("res://Ingredients/ingredient_tscn/TestIngredient.tscn")
const witch_nose = preload("res://Ingredients/ingredient_tscn/WitchNose.tscn")

const click1 = preload("res://SFX/click1.wav")
const click2 = preload("res://SFX/click2.wav")
const click3 = preload("res://SFX/click3.wav")
const click4 = preload("res://SFX/click4.wav")
const click5 = preload("res://SFX/click5.wav")

var pulled:bool = false setget set_pulled

func _ready() -> void:
	GameManager.spawner_tab = self
	transform.origin = Vector2(279, 0)

func set_pulled(value):
	pulled = value
	SfxHandler.play_sfx(SfxHandler.rollover1)
	if value:
		animationPlayer.play("Open")
		
	elif !value:
		animationPlayer.play("Close")

func spawn_ingredient(ingredient:PackedScene):
	var item = ingredient.instance()
	item.global_position = Vector2(rand_range(20, 90), rand_range(15, 30))
	get_tree().current_scene.add_child(item)
	
	var sound_effects:Array = [click1, click2, click3, click4, click5]
	SfxHandler.play_sfx(sound_effects[randi() % sound_effects.size()])
	
func _on_BoomRat_pressed() -> void:
	spawn_ingredient(boom_rat)


func _on_WitchNose_pressed() -> void:
	spawn_ingredient(witch_nose)


func _on_HeartPlum_pressed() -> void:
	spawn_ingredient(heart_plum)


func _on_UmbreallaShroom_pressed() -> void:
	spawn_ingredient(mud_umbrella)


func _on_MoldCap_pressed() -> void:
	spawn_ingredient(mold_caps)


func _on_SweetBerry_pressed() -> void:
	spawn_ingredient(sweet_berry)


func _on_Button_toggled(button_pressed: bool) -> void:
	self.pulled = button_pressed
