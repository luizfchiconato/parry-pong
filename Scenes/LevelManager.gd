extends Node2D


const TUTORIAL_MAIOR = preload("res://Scenes/Levels/LevelList/TutorialMaior.tscn")
const TUTORIAL = preload("res://Scenes/Levels/LevelList/Tutorial.tscn")
const APRESENTACAO_BOLICHE = preload("res://Scenes/Levels/LevelList/ApresentacaoBoliche.tscn")
const RODADA_SIMULTANEA = preload("res://Scenes/Levels/LevelList/RodadaSimultanea.tscn")
const TRES_BOLAS = preload("res://Scenes/Levels/LevelList/TresBolas.tscn")
const TRES_BOLAS_PILAR = preload("res://Scenes/Levels/LevelList/TresBolasPilar.tscn")
const TRES_BOLAS_PILARES = preload("res://Scenes/Levels/LevelList/TresBolasPilares.tscn")
const APRESENTACAO_BALAO = preload("res://Scenes/Levels/LevelList/ApresentacaoBalao.tscn")
const APRESENTACAO_CHUMBO = preload("res://Scenes/Levels/LevelList/ApresentacaoChumbo.tscn")
const RODADA_SIMULTANEA_MENOR = preload("res://Scenes/Levels/LevelList/RodadaSimultaneaMenor.tscn")
const BOLICHE_MULTIPLO = preload("res://Scenes/Levels/LevelList/BolicheMultiplo.tscn")
const TIMING = preload("res://Scenes/Levels/LevelList/Timing.tscn")
const CHUMBO_MENOR = preload("res://Scenes/Levels/LevelList/ChumboMenor.tscn")
const BANDEIRA_TINTA = preload("res://Scenes/Levels/LevelList/BandeiraTinta.tscn")
const BOSS = preload("res://Scenes/Levels/LevelList/Boss.tscn")

const GINASIOS: Array = [
	TUTORIAL_MAIOR,
	TUTORIAL,
	APRESENTACAO_BOLICHE,
	RODADA_SIMULTANEA,
	TRES_BOLAS,
	TRES_BOLAS_PILAR,
	APRESENTACAO_BALAO,
	APRESENTACAO_CHUMBO,
	RODADA_SIMULTANEA_MENOR,
	BOLICHE_MULTIPLO,
	TIMING,
	CHUMBO_MENOR,
	BANDEIRA_TINTA,
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
	Global.game_controller.change_2d_scene(GINASIOS[current_level_index])
	
func reload_level():
	Global.game_controller.reload_current_2d_scene()
