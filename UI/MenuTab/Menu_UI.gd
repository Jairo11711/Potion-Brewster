extends Node2D
class_name MenuTab

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var tab_button:Button = $TextureRect/Button

const bottle = preload("res://SFX/bottle.wav")
const metal_small2 = preload("res://SFX/metal-small2.wav")
const bite_small = preload("res://SFX/bite-small.wav")

var pulled:bool = true setget set_pulled
var wanted_potion_to_make = PotionRequirements.heal_potion_requirements

func set_pulled(value):
	SfxHandler.play_sfx(SfxHandler.rollover1)
	pulled = value
	if value:
		animationPlayer.play("Open")
	elif !value:
		animationPlayer.play("Close")

func _ready() -> void:
	GameManager.menu_tab = self
	transform.origin = Vector2(-62, 0)

func check_if_potion_passed_requirements(potion_requirements:Array):
	if !GameManager.cauldon.mixed_enough:
		GameManager.help_screen.change_content(GameManager.help_screen.states.under_mixed, ["dummy array"])
		return
	
	var wanted_stats = get_wanted_stats(potion_requirements[1], GameManager.cauldon.stats)
	var passed_wanted_stats = passed_stats(potion_requirements[1], wanted_stats)
	
	var unwanted_stats = get_wanted_stats(potion_requirements[2], GameManager.cauldon.stats)
	var passed_unwanted_stats = passed_stats(potion_requirements[2], unwanted_stats)
	
	if passed_wanted_stats.size() == potion_requirements[1].size():
		if !passed_unwanted_stats.size() == potion_requirements[2].size():
			GameManager.help_screen.change_content(GameManager.help_screen.states.successful, ["dummy array"])
			return
			
		GameManager.help_screen.change_content(GameManager.help_screen.states.unwanted, unwanted_stats)
		return
		
	GameManager.help_screen.change_content(GameManager.help_screen.states.wanted, wanted_stats)


func passed_stats(potion_requirements:Dictionary, potion_made:Dictionary):
	var passed_stat:Array
	for index in potion_made:
		if potion_made[index] >= potion_requirements[index]:
			passed_stat.append(index)
	return passed_stat
	
func get_wanted_stats(potion_requirements:Dictionary, potion_made:Dictionary):
	var wanted_stats_to_compare:Dictionary
	for requirement in potion_requirements:
		if potion_made.has(requirement):
			wanted_stats_to_compare[requirement] = potion_made[requirement]
	return wanted_stats_to_compare

func remove_all_ingredients():
	var all_ingredients = get_tree().get_nodes_in_group("ingredient")
	for ingredient in all_ingredients:
		ingredient.queue_free()

	SfxHandler.play_sfx(bite_small)
	
func _on_Serve_pressed() -> void:
	SfxHandler.play_sfx(bottle)
	remove_all_ingredients()
	
	#Actual behavior
	check_if_potion_passed_requirements(wanted_potion_to_make)
	GameManager.help_screen.pulled = true

func _on_EraseIngredient_pressed() -> void:
	remove_all_ingredients()

func _on_Help_pressed() -> void:
	print(GameManager.cauldon.stats)
	GameManager.help_screen.change_content(GameManager.help_screen.states.help,["dummy array"])
	GameManager.help_screen.pulled = true

func _on_EmptyCauldron_pressed() -> void:
	SfxHandler.play_sfx(metal_small2)
	GameManager.cauldon.empty_cauldron()
	remove_all_ingredients()

func _on_ChangePotion_pressed() -> void:
	GameManager.potion_pick.pulled = true
	self.pulled = false

func _on_Button_toggled(button_pressed: bool) -> void:
	self.pulled = button_pressed
