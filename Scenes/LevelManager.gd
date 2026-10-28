extends Node2D

const TUTORIAL_HOCKEY = preload("res://Scenes/Levels/LevelList/TutorialHockey.tscn")

const LEVEL_START = preload("res://Scenes/UI/LevelStart.tscn")

const RITMO = {
	"index": 0,
	"name": "Pong",
	"scene": preload("res://Scenes/Levels/LevelList/Ritmo.tscn"),
	"description": "Tá preso é :'((((",
}
const TUTORIAL_MAIOR = {
	"index": 0,
	"name": "Tutorial",
	"scene": preload("res://Scenes/Levels/LevelList/TutorialMaior.tscn"),
	"description": "Conseguiu se soltar, tampinha? Seu inferno só está começando",
}
const TUTORIAL = {
	"index": 0,
	"name": "Tutorial só que menor",
	"scene": preload("res://Scenes/Levels/LevelList/Tutorial.tscn"),
	"description": "Acho que você está com espaço demais. Vamos ver agora",
}
const APRESENTACAO_BOLICHE = {
	"index": 0,
	"name": "Boliche",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoBoliche.tscn"),
	"description": "Peguem as bolas de boliche porque hoje faremos desse piá de bosta um pino",
}
const SURVIVAL_FACIL = {
	"index": 0,
	"name": "Queimada",
	"scene": preload("res://Scenes/Levels/LevelList/SurvivalFacil.tscn"),
	"description": "roubei sua raquete roubei sua raquete kkkkkk :^)",
}
const RODADA_SIMULTANEA = {
	"index": 0,
	"name": "Rodada simultânea",
	"scene": preload("res://Scenes/Levels/LevelList/RodadaSimultanea.tscn"),
	"description": "Sem respiro dessa vez",
}
const TRES_BOLAS = {
	"index": 0,
	"name": "Tribola",
	"scene": preload("res://Scenes/Levels/LevelList/TresBolas.tscn"),
	"description": "Hora da equipe tribola resolver isso",
}
const TRES_BOLAS_PILAR = {
	"index": 0,
	"name": "Tribola sujo",
	"scene": preload("res://Scenes/Levels/LevelList/TresBolasPilar.tscn"),
	"description": "Quem sujou o estágio? Enfim, a equipe tribola 2 vai realmente resolver",
}
const APRESENTACAO_BALAO = {
	"index": 0,
	"name": "Balão",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoBalao.tscn"),
	"description": "Aproveite esse. Você não tem ideia o tempo que levou pra encher todos esses balões",
}
const RODADA_SIMULTANEA_2 = {
	"index": 0,
	"name": "Rodada Simultânea 2",
	"scene": preload("res://Scenes/Levels/LevelList/RodadaSimultanea2.tscn"),
	"description": "Sem respiro de novo. Boa sorte. Seu merdinha",
}
const APRESENTACAO_CHUMBO = {
	"index": 0,
	"name": "Chumbo",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoChumbo.tscn"),
	"description": "Filho da puta. Acabou a brincadeira",
}
const APRESENTACAO_BASQUETE = {
	"index": 0,
	"name": "Basquete",
	"scene": preload("res://Scenes/Levels/LevelList/ApresentacaoBasquete.tscn"),
	"description": "Sério mesmo que você vai tentar basquete? Com 60 centímetros?",
}
const BOLICHE_MULTIPLO = {
	"index": 0,
	"name": "Boliche mais perigoso",
	"scene": preload("res://Scenes/Levels/LevelList/BolicheMultiplo.tscn"),
	"description": "Quero ver todos os strikes do mundo agora, bando de incompetente",
}
const RODADA_SIMULTANEA_MENOR = {
	"index": 0,
	"name": "Rodada simultânea só que menor",
	"scene": preload("res://Scenes/Levels/LevelList/RodadaSimultaneaMenor.tscn"),
	"description": "Você não tem saída agora",
}
const BOLA_VERMELHA_COMPLEXO = {
	"index": 0,
	"name": "Mais uma com ginásio sujo",
	"scene": preload("res://Scenes/Levels/LevelList/BolaVermelhaComplexo.tscn"),
	"description": "Sujaram o estádio DE NOVO",
}
const BANDEIRA_TINTA = {
	"index": 0,
	"name": "Ginásio em obras",
	"scene": preload("res://Scenes/Levels/LevelList/BandeiraTinta.tscn"),
	"description": "Ok, esse aqui é manutenção prevista. Evite pisar na tinta, por favor",
}
const TIMING = {
	"index": 0,
	"name": "Corredor",
	"scene": preload("res://Scenes/Levels/LevelList/Timing.tscn"),
	"description": "Por que você tá entrando no closet?",
}
const SURVIVAL = {
	"index": 0,
	"name": "Queimada+",
	"scene": preload("res://Scenes/Levels/LevelList/Survival.tscn"),
	"description": "nem fudendo que você perdeu sua raquete de novo",
}
const CHUMBO_MENOR = {
	"index": 0,
	"name": "Chumbo menor",
	"scene": preload("res://Scenes/Levels/LevelList/ChumboMenor.tscn"),
	"description": "Eu vou te matar. Eu vou te matar. Eu vou te matar. Eu v",
}

const RITMO_2 = {
	"index": 0,
	"name": "Amarrado+",
	"scene": preload("res://Scenes/Levels/LevelList/Ritmo2.tscn"),
}
const MARATONA = {
	"index": 0,
	"name": "Maratona",
	"scene": preload("res://Scenes/Levels/LevelList/Maratona.tscn"),
	"description": "TODO MUNDO NO GINÁSIO 20, AGORA. ELE TÁ NA PORTA DA SAÍDA",
}
const MINIBOSS = {
	"index": 0,
	"name": "Monitor Jones",
	"scene": preload("res://Scenes/Levels/LevelList/Miniboss.tscn"),
	"description": "...",
}
const BOSS = {
	"index": 0,
	"name": "Treinador Caldo",
	"scene": preload("res://Scenes/Levels/LevelList/Boss.tscn"),
	"description": "Eu não ironicamente vou te matar",
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
	MINIBOSS,
	APRESENTACAO_CHUMBO,
	APRESENTACAO_BASQUETE,
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
	var level = GINASIOS[current_level_index].duplicate()
	level.index = current_level_index + 1
	print(current_level_index + 1, level.index)
	level_start_scene.set_level(level)
	#Global.game_controller.change_2d_scene(GINASIOS[current_level_index].scene)
	
func reload_level():
	Global.game_controller.reload_current_2d_scene()
