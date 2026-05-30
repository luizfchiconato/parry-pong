extends Node2D

const TUTORIAL_HOCKEY = preload("res://Scenes/Levels/LevelList/TutorialHockey.tscn")

const TUTORIAL_MAIOR = {
	"name": "Tutorial",
	"scene": preload("res://Scenes/Levels/LevelList/TutorialMaior.tscn"),
}
const TUTORIAL = {
	"name": "Tutorial só que menor",
	"scene": preload("res://Scenes/Levels/LevelList/Tutorial.tscn"),
}
const APRESENTACAO_BOLICHE = {
	"name": "Boliche",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoBoliche.tscn"),
}
const RODADA_SIMULTANEA = {
	"name": "Rodada simultânea",
	"scene": preload("res://Scenes/Levels/LevelList/RodadaSimultanea.tscn"),
}
const TRES_BOLAS = {
	"name": "Tribola",
	"scene": preload("res://Scenes/Levels/LevelList/TresBolas.tscn"),
}
const TRES_BOLAS_PILAR = {
	"name": "Tribola sujo",
	"scene": preload("res://Scenes/Levels/LevelList/TresBolasPilar.tscn"),
}
const APRESENTACAO_BALAO = {
	"name": "Balão",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoBalao.tscn"),
}
const RODADA_SIMULTANEA_2 = {
	"name": "Rodada Simultânea 2",
	"scene": preload("res://Scenes/Levels/LevelList/RodadaSimultanea2.tscn"),
}
const APRESENTACAO_CHUMBO = {
	"name": "Chumbo",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoChumbo.tscn"),
}
const APRESENTACAO_BASQUETE = {
	"name": "Basquete",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoBasquete.tscn"),
}
const BOLICHE_MULTIPLO = {
	"name": "Boliche mais perigoso",
	"scene": preload("res://Scenes/Levels/LevelList/BolicheMultiplo.tscn"),
}
const RODADA_SIMULTANEA_MENOR = {
	"name": "Rodada simultânea só que menor",
	"scene": preload("res://Scenes/Levels/LevelList/RodadaSimultaneaMenor.tscn"),
}
const BOLA_VERMELHA_COMPLEXO = {
	"name": "Bola vermelha e tudo",
	"scene": preload("res://Scenes/Levels/LevelList/BolaVermelhaComplexo.tscn"),
}
const BANDEIRA_TINTA = {
	"name": "Ginásio em obras",
	"scene": preload("res://Scenes/Levels/LevelList/BandeiraTinta.tscn"),
}
const TIMING = {
	"name": "Corredor",
	"scene": preload("res://Scenes/Levels/LevelList/Timing.tscn"),
}
const SURVIVAL_FACIL = {
	"name": "Survival",
	"scene": preload("res://Scenes/Levels/LevelList/SurvivalFacil.tscn"),
}
const SURVIVAL = {
	"name": "Survival+",
	"scene": preload("res://Scenes/Levels/LevelList/Survival.tscn"),
}
const CHUMBO_MENOR = {
	"name": "Chumbo menor",
	"scene": preload("res://Scenes/Levels/LevelList/ChumboMenor.tscn"),
}
const RITMO = {
	"name": "Ritmo",
	"scene": preload("res://Scenes/Levels/LevelList/Ritmo.tscn"),
}
const MARATONA = {
	"name": "Maratona",
	"scene": preload("res://Scenes/Levels/LevelList/Maratona.tscn"),
}
const BOSS = {
	"name": "Treinador Caldo",
	"scene": preload("res://Scenes/Levels/LevelList/Boss.tscn")
}

const GINASIOS: Array = [
	#TUTORIAL_HOCKEY,
	TUTORIAL_MAIOR,
	TUTORIAL,
	APRESENTACAO_BOLICHE,
	RODADA_SIMULTANEA,
	SURVIVAL_FACIL,
	TRES_BOLAS,
	TRES_BOLAS_PILAR,
	APRESENTACAO_BALAO,
	RODADA_SIMULTANEA_2,
	APRESENTACAO_BASQUETE,
	APRESENTACAO_CHUMBO,
	BOLICHE_MULTIPLO,
	RODADA_SIMULTANEA_MENOR,
	BOLA_VERMELHA_COMPLEXO,
	CHUMBO_MENOR,
	SURVIVAL,
	BANDEIRA_TINTA,
	TIMING,
	# RITMO,
	MARATONA,
	BOSS
]

var current_level_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_first_level():
	current_level_index = 0
	load_level()

func load_level_by_index(index : int):
	current_level_index = index
	load_level()

func load_next_level():
	if current_level_index < GINASIOS.size():
		current_level_index = current_level_index + 1
	load_level()
	
func load_level():
	Global.game_controller.change_2d_scene(GINASIOS[current_level_index].scene)
	
func reload_level():
	Global.game_controller.reload_current_2d_scene()
