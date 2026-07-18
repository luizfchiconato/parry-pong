extends Node

#This class preloads all of our sound effects so that they can be played at a momets notice
#region New Code Region

const DASH = preload("res://Art/Audio/Effects/Dash.ogg")

const PLAYER_ATTACK_SWING = preload("res://Art/Audio/Effects/AttackSwing.ogg")
const PLAYER_HURT = preload("res://Art/Audio/Effects/PlayerHurt.ogg")

const COIN_PICK = preload("res://Art/Audio/Effects/coin_pick.ogg")

const SMALL_EXPLOSION = preload("res://Art/Audio/Effects/SmallExplosion.ogg")
const ENEMY_SPUN = preload("res://Art/Audio/Effects/EnemySpun.ogg")
const WALL_SMASH_1 = preload("res://Art/Audio/Effects/Smash1.ogg")
const WALL_SMASH_2 = preload("res://Art/Audio/Effects/Smash2.ogg")

const PLAYER_ATTACK_HIT = preload("res://Art/Audio/Effects/PongHit.ogg")
const PLAYER_ATTACK_HIT_BALLOON = null
const PLAYER_ATTACK_HIT_BOWLING = null # verificar se vai continuar sendo pitch grave
const PLAYER_ATTACK_HIT_BASKET = null # talvez mesmo de quicar, mas mais forte

const BOWLING_FALL = preload("res://Art/Audio/Effects/BowlingFall.ogg")
const BALLOON_HIT = preload("res://Art/Audio/Effects/BalloonHit.ogg")

const BALL_EXPLODE = null
const BOWLING_EXPLODE = null
const BALLOON_SPLASH = preload("res://Art/Audio/Effects/BallonSplash.ogg")
const BASKET_BOUNCE = null
const BASKET_EXPLODE = null

const ENEMY_HIT = preload("res://Art/Audio/Effects/VolleyHit.ogg")
# const ENEMY_ATTACK = preload("res://Art/Audio/Effects/VolleyHit.ogg")

const ENEMY_HIT_DEFAULT = preload("res://Art/Audio/Effects/VolleyHit.ogg")
const ENEMY_HIT_BOWLING = preload("res://Art/Audio/Effects/EnemyHitBowling.ogg")

const BOSS_SWOOSH = null
const BOSS_SPIT = null
const BOSS_STOMP = null
const BOSS_EXPLODE = null
const BOSS_TALK = null

const SELECT_UI = null
const CLICK_UI = null

# const QUEST_SOUND = preload("res://Art/Audio/Effects/QuestSound.ogg")

#endregion
var audio_player : AudioStreamPlayer 
var audio_player2 : AudioStreamPlayer 
var audio_player3 : AudioStreamPlayer 
var audio_player4 : AudioStreamPlayer 
var audio_player5 : AudioStreamPlayer 

var audioStreams = []
var NUM_AUDIO_STREAMS = 5

#Play a sound, call this function from anywhere
#offset lets you start the sound with an offset, like starting the sound at 0.1s into the clip
#Arguments(audio_clip, offset, volume)
#Example when calling this function:
#AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.25, 1)
func play_sound(audiostream : AudioStreamOggVorbis, offset : float, volume : float, pitch: float = randf_range(0.9, 1.1)):
	if(audioStreams.size() == 0):
		initiate_audio_stream()
	
	#Play the second audioplayer if the first is already busy
	var player = null
	for audioStream in audioStreams:
		if(audioStream.playing == false):
			player = audioStream
	if (player == null):
		player = audioStreams[0]

	player.stream = audiostream
	player.pitch_scale = pitch
	player.volume_db = volume
	player.play(offset)

#Instantiate two audiostreams into the scene, this only happens if none already exists
func initiate_audio_stream():
	for i in range(NUM_AUDIO_STREAMS):
		audio_player = AudioStreamPlayer.new()
		audioStreams.push_back(audio_player)
		add_child(audio_player)
