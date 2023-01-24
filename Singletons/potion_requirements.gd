extends Node
#array index 0 is wanted stats, 1 is mininum stat, 2 is unwanted stats

var heal_potion_requirements:Array = [
	{GameManager.effect_names.heal:6},
	{GameManager.effect_names.heal:6, GameManager.effect_names.duration:2, GameManager.effect_names.water:3},
	{GameManager.effect_names.poison:1}
					]

var poison_potion_requirements:Array = [
	{GameManager.effect_names.poison:8},
	{GameManager.effect_names.poison:8, GameManager.effect_names.duration:4, GameManager.effect_names.water:4},
	{GameManager.effect_names.heal:1, GameManager.effect_names.explosive_power:2}
					]


var bomb_potion_requirements:Array = [
	{GameManager.effect_names.explosive_power:6},
	{GameManager.effect_names.explosive_power:6, GameManager.effect_names.duration:1,},
	{GameManager.effect_names.duration:4, GameManager.effect_names.heal:2, GameManager.effect_names.water:5}
]


