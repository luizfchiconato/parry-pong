extends Node

#This class preloads all of our sound effects so that they can be played at a momets notice
#region New Code Region

# const DASH = preload("res://Art/Audio/Effects/Dash.ogg")
const DASH = preload("res://Art/Audio/Effects/lunn3/dash.ogg")

# const PLAYER_ATTACK_SWING = preload("res://Art/Audio/Effects/AttackSwing.ogg")
const PLAYER_ATTACK_SWING = preload("res://Art/Audio/Effects/lunn3/swing.ogg")
const PLAYER_HURT = preload("res://Art/Audio/Effects/lunn3/playerhit.ogg")

# const COIN_PICK = preload("res://Art/Audio/Effects/coin_pick.ogg")
const COIN_PICK = preload("res://Art/Audio/Effects/lunn3/pickupvida.ogg")

#const SMALL_EXPLOSION = preload("res://Art/Audio/Effects/SmallExplosion.ogg")
const ENEMY_SPUN = preload("res://Art/Audio/Effects/lunn3/dashparedemorte.ogg")

const WALL_SMASH_1 = preload("res://Art/Audio/Effects/lunn3/dashparedemorte.ogg")
const WALL_SMASH_2 = preload("res://Art/Audio/Effects/lunn3/dashparedemorte.ogg")


# const PLAYER_ATTACK_HIT = preload("res://Art/Audio/Effects/PongHit.ogg")
const PLAYER_ATTACK_HIT = preload("res://Art/Audio/Effects/lunn3/raqueteimpacto.ogg")
const PLAYER_ATTACK_HIT_BALLOON = preload("res://Art/Audio/Effects/lunn3/raquetebalão.ogg")
const PLAYER_ATTACK_HIT_BOWLING = preload("res://Art/Audio/Effects/lunn3/bolicheraquet.ogg")
const PLAYER_ATTACK_HIT_BASKET = preload("res://Art/Audio/Effects/lunn3/raquetebasquet.ogg")

# const BOWLING_FALL = preload("res://Art/Audio/Effects/BowlingFall.ogg")
const BALLOON_HIT = preload("res://Art/Audio/Effects/lunn3/raquetebalão.ogg")

const BOWLING_EXPLODE = null
const BALLOON_SPLASH = preload("res://Art/Audio/Effects/lunn3/balãosplash.ogg")
const BASKET_BOUNCE = preload("res://Art/Audio/Effects/lunn3/bouncebasquete.ogg")
const BASKET_EXPLODE = null

const ENEMY_HIT = preload("res://Art/Audio/Effects/lunn/enemy_hit.ogg")
# const ENEMY_ATTACK = preload("res://Art/Audio/Effects/VolleyHit.ogg")

#const ENEMY_HIT_DEFAULT = preload("res://Art/Audio/Effects/VolleyHit.ogg")
const ENEMY_HIT_DEFAULT = [
	preload("res://Art/Audio/Effects/lunn3/enemyhit.ogg"),
	preload("res://Art/Audio/Effects/lunn3/enemyhit2.ogg"),
]
const ENEMY_HIT_BOWLING = preload("res://Art/Audio/Effects/lunn3/bolichesplash.ogg")

const BOSS_SWOOSH = preload("res://Art/Audio/Effects/lunn3/soprocaldo.ogg")
const BOSS_SPIT = preload("res://Art/Audio/Effects/lunn3/plopbolacaldo.ogg")
const BOSS_STOMP = preload("res://Art/Audio/Effects/lunn3/AOEcaldo.ogg")
const BOSS_EXPLODE = preload("res://Art/Audio/Effects/lunn3/explosãocaldo.ogg")
const BOSS_TALK = null

const SELECT_UI = preload("res://Art/Audio/Effects/lunn3/UIselect.ogg")
const CLICK_UI = preload("res://Art/Audio/Effects/lunn3/UIclick.ogg")

const WALL_BOUNCE = [
	preload("res://Art/Audio/Effects/lunn3/bounceback 1.ogg"),
	preload("res://Art/Audio/Effects/lunn3/bounceback 2.ogg"),
	preload("res://Art/Audio/Effects/lunn3/bounceback 3.ogg"),
	preload("res://Art/Audio/Effects/lunn3/bounceback 4.ogg")
]

const PLAYER_ATTACK_HIT_GIANT_BALL = preload("res://Art/Audio/Effects/lunn3/hitbolonacaldo.ogg")

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
func play_sound(audiostream, offset : float, volume : float = -10, pitch: float = randf_range(0.9, 1.1)) -> AudioStreamPlayer:
	volume = 0
	
	var stream
	if (audiostream is AudioStreamOggVorbis):
		stream = audiostream
	if (audiostream is Array):
		var rng = RandomNumberGenerator.new()
		stream = audiostream[rng.randf_range(0, audiostream.size() - 1)]
	
	if(audioStreams.size() == 0):
		initiate_audio_stream()
	
	#Play the second audioplayer if the first is already busy
	var player : AudioStreamPlayer = null
	for audioStream in audioStreams:
		if(audioStream.playing == false):
			player = audioStream
	if (player == null):
		player = audioStreams[0]

	player.stream = stream
	player.pitch_scale = pitch
	player.volume_db = volume
	player.play(offset)
	return player

#Instantiate two audiostreams into the scene, this only happens if none already exists
func initiate_audio_stream():
	for i in range(NUM_AUDIO_STREAMS):
		audio_player = AudioStreamPlayer.new()
		audioStreams.push_back(audio_player)
		add_child(audio_player)
