extends Node2D

const TUTORIAL_HOCKEY = preload("res://Scenes/Levels/LevelList/TutorialHockey.tscn")

const LEVEL_START = preload("res://Scenes/UI/LevelStart.tscn")

const RITMO = {
	"name": "Pong",
	"scene": preload("res://Scenes/Levels/LevelList/Ritmo.tscn"),
	"description": "Tá preso é :'((((",
}
const TUTORIAL_MAIOR = {
	"name": "Tutorial",
	"scene": preload("res://Scenes/Levels/LevelList/TutorialMaior.tscn"),
	"description": "Conseguiu se soltar, tampinha? Seu inferno só está começando",
}
const TUTORIAL = {
	"name": "Tutorial só que menor",
	"scene": preload("res://Scenes/Levels/LevelList/Tutorial.tscn"),
	"description": "Acho que você está com espaço demais. Vamos ver agora",
}
const APRESENTACAO_BOLICHE = {
	"name": "Boliche",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoBoliche.tscn"),
	"description": "Peguem as bolas de boliche porque hoje faremos desse piá de bosta um pino",
}
const SURVIVAL_FACIL = {
	"name": "Queimada",
	"scene": preload("res://Scenes/Levels/LevelList/SurvivalFacil.tscn"),
	"description": "roubei sua raquete roubei sua raquete kkkkkk :^)",
}
const RODADA_SIMULTANEA = {
	"name": "Rodada simultânea",
	"scene": preload("res://Scenes/Levels/LevelList/RodadaSimultanea.tscn"),
	"description": "Sem respiro dessa vez",
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

const SURVIVAL = {
	"name": "Queimada+",
	"scene": preload("res://Scenes/Levels/LevelList/Survival.tscn"),
}
const CHUMBO_MENOR = {
	"name": "Chumbo menor",
	"scene": preload("res://Scenes/Levels/LevelList/ChumboMenor.tscn"),
}

const RITMO_2 = {
	"name": "Amarrado+",
	"scene": preload("res://Scenes/Levels/LevelList/Ritmo2.tscn"),
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
	RITMO,
	TUTORIAL_MAIOR,
	TUTORIAL,
	APRESENTACAO_BOLICHE,
	SURVIVAL_FACIL,
	RODADA_SIMULTANEA,
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
	BANDEIRA_TINTA,
	TIMING,
	SURVIVAL,
	#RITMO_2,
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
	Global.game_controller.deload_current_2d_scene()
	var level_start_scene = Global.game_controller.change_gui_scene(LEVEL_START)
	level_start_scene.set_level(GINASIOS[current_level_index])
	#Global.game_controller.change_2d_scene(GINASIOS[current_level_index].scene)
	
func reload_level():
	Global.game_controller.reload_current_2d_scene()
