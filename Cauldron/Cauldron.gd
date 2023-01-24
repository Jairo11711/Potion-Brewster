extends StaticBody2D
class_name Cauldron

export(int) var perfect_mix_amount
export(int) var max_mix_amount

const bubble_1 = preload("res://SFX/bubble.wav")
const bubble_2 = preload("res://SFX/bubble2.wav")
const bubble_3 = preload("res://SFX/bubble3.wav")

const slime_01 = preload("res://SFX/slime_01.wav")
const slime_02 = preload("res://SFX/slime_02.wav")
const slime_03 = preload("res://SFX/slime_03.wav")
const slime_04 = preload("res://SFX/slime_04.wav")
const slime_05 = preload("res://SFX/slime_05.wav")

var stirred_amounts:int = 0 setget set_stirred_amounts
var mixed_enough:bool = false

#added effects to the potion
var stats:Dictionary = {
	GameManager.effect_names.heal:0,
	GameManager.effect_names.poison:0,
	GameManager.effect_names.duration:0,
	GameManager.effect_names.explosive_power:0,
	GameManager.effect_names.water:0
}
onready var reset_stat:Dictionary = stats.duplicate()
onready var reset_stirred_amounts = 0
onready var reset_perfect_mix_amount = perfect_mix_amount
onready var reset_max_mixed_amount = max_mix_amount

func empty_cauldron():
	stats = reset_stat
	stirred_amounts = reset_stirred_amounts
	perfect_mix_amount = reset_perfect_mix_amount
	max_mix_amount = reset_max_mixed_amount

func set_stirred_amounts(value):
	var sound_effects:Array = [bubble_1, bubble_2]
	SfxHandler.play_sfx(sound_effects[randi() % sound_effects.size()])
	print(value)
	
	stirred_amounts = value
	
	if value == perfect_mix_amount:
		mixed_enough = true
		SfxHandler.play_sfx(bubble_3)
		print(mixed_enough)
	if value == max_mix_amount:
		SfxHandler.play_sfx(preload("res://SFX/bang_02.wav"))
		GameManager.help_screen.pulled = true
		GameManager.help_screen.change_content(GameManager.help_screen.states.over_mixed, ["dummy array"])

func _ready() -> void:
	GameManager.cauldon = self
	
#called by the stirring rod
func add_stirred_amount(value):
	self.stirred_amounts += value

func add_random_mix_amount_needed():
	perfect_mix_amount += randi()%2
	max_mix_amount += randi()%2

func receive_effect(effect_type:int, effect_strength):
	stats[effect_type] += effect_strength


func _on_Ingredient_Reader_body_entered(body: Node) -> void:
	if body.has_method("exist"):
		var sound_effects:Array = [slime_01, slime_02, slime_04, slime_05]
		SfxHandler.play_sfx(sound_effects[randi() % sound_effects.size()])
		
		
		add_random_mix_amount_needed()
		for index in body.effect_type.size():
			receive_effect(body.effect_type[index], body.effect_strength[index])
		body.queue_free()
		
		
