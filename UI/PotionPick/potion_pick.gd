extends Node2D
class_name PotionPick

onready var health_option:Button = $TextureRect/VBoxContainer/Health
onready var poison_option:Button = $TextureRect/VBoxContainer/Poison
onready var bomb_option:Button = $TextureRect/VBoxContainer/Bomb

onready var animaplayer:AnimationPlayer = $AnimationPlayer

var pulled:bool = false setget set_pulled

func set_pulled(value):
	pulled = value
	SfxHandler.play_sfx(SfxHandler.rollover1)
	if value:
		animaplayer.play("Open")
		GameManager.menu_tab.tab_button.emit_signal("toggled", value)
		GameManager.spawner_tab.pulled = false
	elif !value:
		animaplayer.play("Close")
		
func _ready() -> void:
	GameManager.potion_pick = self
	transform.origin = Vector2(0, 180)
	
	bomb_option.indicator.visible = false
	poison_option.indicator.visible = false

func _on_Health_pressed() -> void:
	GameManager.menu_tab.wanted_potion_to_make = PotionRequirements.heal_potion_requirements
	
	health_option.indicator.visible = true
	bomb_option.indicator.visible = false
	poison_option.indicator.visible = false
	
	SfxHandler.play_sfx(SfxHandler.rollover2)
	
func _on_Poison_pressed() -> void:
	GameManager.menu_tab.wanted_potion_to_make = PotionRequirements.poison_potion_requirements
	
	poison_option.indicator.visible = true
	bomb_option.indicator.visible = false
	health_option.indicator.visible = false

	SfxHandler.play_sfx(SfxHandler.rollover2)

func _on_Bomb_pressed() -> void:
	GameManager.menu_tab.wanted_potion_to_make = PotionRequirements.bomb_potion_requirements
	
	bomb_option.indicator.visible = true
	health_option.indicator.visible = false
	poison_option.indicator.visible = false

	SfxHandler.play_sfx(SfxHandler.rollover2)
	
func _on_Button_pressed() -> void:
	self.pulled = false
