extends Node2D

const TUTORIAL = preload("res://Scenes/Levels/LevelList/Tutorial.tscn")
const APRESENTACAO_BOLICHE = preload("res://Scenes/Levels/LevelList/ApresentacaoBoliche.tscn")
const TRES_BOLAS = preload("res://Scenes/Levels/LevelList/TresBolas.tscn")
const TRES_BOLAS_PILAR = preload("res://Scenes/Levels/LevelList/TresBolasPilar.tscn")
const RODADA_SIMULTANEA_MENOR = preload("res://Scenes/Levels/LevelList/RodadaSimultaneaMenor.tscn")
const CHUMBO_MENOR = preload("res://Scenes/Levels/LevelList/ChumboMenor.tscn")
const BANDEIRA_TINTA = preload("res://Scenes/Levels/LevelList/BandeiraTinta.tscn")

const GINASIOS: Array = [
	TUTORIAL,
	APRESENTACAO_BOLICHE,
	TRES_BOLAS,
	TRES_BOLAS_PILAR,
	RODADA_SIMULTANEA_MENOR,
	CHUMBO_MENOR,
	BANDEIRA_TINTA,
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
