extends Node2D
class_name HelpScreen

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var richTextLabel:RichTextLabel = $TextureRect/RichTextLabel

var tease_text:String = "The swirling mixture move around, revealing..."

var pulled:bool = false setget set_pulled

enum states {
	help,
	wanted,
	unwanted,
	successful,
	under_mixed,
	over_mixed
}

func set_pulled(value):
	pulled = value
	if value:
		animationPlayer.play("Open")
		GameManager.menu_tab.pulled = false
		GameManager.spawner_tab.pulled = false
		
	elif !value:
		SfxHandler.play_sfx(SfxHandler.rollover1)
		animationPlayer.play("Close")

func _ready() -> void:
	GameManager.help_screen = self
	transform.origin = Vector2(0, -180)
	
func change_content(state, requirements):
	match state:
		states.help:
			want_help()
		states.unwanted:
			passed_in_unwanted_requirements(requirements.keys())
		states.wanted:
			failed_in_requirements(requirements.keys())
		states.successful:
			successful_potion()
		states.under_mixed:
			under_mixed_potion()
		states.over_mixed:
			over_mixed_potion()
	GameManager.cauldon.empty_cauldron()

func over_mixed_potion():
	var content = "Booooooooooooom !!!\n\n"\
	+ "Too much. The over mixing of the conconction caused the huge explosion in the area."\
	+ "\n This is a alchemic potion we're making, not a milkshake."
	
	richTextLabel.text = content
	
func under_mixed_potion():
	var content = "Sadly, the potion systhesis wasn't able to be formed due to a lack"\
	+ " of mixing. Please mix little more next time."
	
	richTextLabel.text = content
	
func successful_potion():
	var content = " Success!!!\n"\
	+ "\nYou have made a potion. A good one at that. This is just the beginning of your potion crafting life."\
	+ "\n\nHopefully that wasn't too hard in guessing the correct combination of ingredients here. "\
	+ "Hope you had fun!"
	
	richTextLabel.text = tease_text + content
	
func failed_in_requirements(failed_requirements:Array):
	var content = " Failure !!!\n"\
	+ "\nThis is because you have failed in reaching the mininum amount of point needed in one or more stats:\n"
	for failed_requirement in failed_requirements:
		content += get_effect_name(failed_requirement) + "\n"
		
	content += "\n Your potion contains these stats:\n"
	for stat in GameManager.cauldon.stats.keys():
		print(GameManager.cauldon.stats[stat])
		if GameManager.cauldon.stats[stat] > 0:
			print(GameManager.cauldon.stats[stat])
			content += get_effect_name(stat) + "\n"
	
		
	richTextLabel.text = tease_text + content
	
func passed_in_unwanted_requirements(unwanted_requirements:Array):
	var content = "Failure !!!\n"\
	+ "\nThis is because the potion you made has unwanted stats in it that essentially renders it useless:\n"
	for unwanted_requirement in unwanted_requirements:
		content += get_effect_name(unwanted_requirement) + "\n"
		
	content += "\n Your potion contains these stats:\n"
	for stat in GameManager.cauldon.stats.keys():
		if GameManager.cauldon.stats[stat] > 0:
			content += get_effect_name(stat) + "\n"
		
	richTextLabel.text = tease_text + content
	
func want_help():
	var content = "Be an alchemist and create a potion of your choice. "\
	+ "Choose from a set of ingredients and through trial and error, succesfully systhesis it! "\
	+ "After adding all your ingredients to the cauldron, stir until well mixed. Not too much though. "\
	+ "The magical effects of the potion may cause an explsion of epic proportions\n\n"\
	+ "All potions have these following stats:\n"
	for effect_name in GameManager.effect_names:
		content += effect_name + "\n"
		
	richTextLabel.text = content
	

func get_effect_name(effect_name:int):
	var name = GameManager.effect_names.keys()[effect_name]
	return name

func _on_Button_pressed() -> void:
	self.pulled = false
