class_name EnemyController extends Controller

var game: GameController
var world: WorldGenerator
var time: TimeController
var event: EventController

var enemy_one: PackedScene = preload("res://Scenes/enemy.tscn")

signal spawn_enemy_wave

func _ready() -> void:
	super._ready()
	Initialize()

func _process(delta: float) -> void:
	if int(time.GetWorldTime()) % 10 == 0: # AND signal connected
		# event.BroadcastEnemySpawnWave()
		# event.enemy_spawn_wave.disconnect(SpawnWave)
		pass
		# event.enemy_spawn_wave.connect(SpawnWave)
		# need a oneshot implementation

func Initialize() -> Controller.State:
	if (!system):
		state = Controller.State.FAIL
		return state
	
	event = system.GetEventController()
	time = system.GetTimeController()
	game = system.GetGameController()
	world = game.GetWorld()
	
	if (!event or !time or !game or !world):
		state = Controller.State.FAIL
		return state
		
	ConnectSignals({
		event.enemy_spawn_wave : SpawnWave
	})
	
	state = Controller.State.ONLINE
	return state

func SpawnWave() -> void:
		print("spawn enemy wave")


func FindSpawnPoints() -> Array:
	var spawnPoints: Array
	# fill spawn points array with Vector2 data
	for key in world.GroundMap:
		print(key)
	return spawnPoints
