class_name EnemyController extends Controller

var game: GameController
var world: WorldGenerator
var time: TimeController
var event: EventController
var logger: LogController

var enemies: Array[Enemy]

signal spawn_enemy_wave

func _ready() -> void:
	super._ready()
	Initialize()

func _process(delta: float) -> void:
	if event.enemy_spawn_wave.is_connected(SpawnWave): # AND signal connected
		event.BroadcastEnemySpawnWave()
		# event.enemy_spawn_wave.disconnect(SpawnWave)
		# event.enemy_spawn_wave.connect(SpawnWave)
		# need a oneshot implementation

func Initialize() -> Controller.State:
	if (!system):
		state = Controller.State.FAIL
		return state
	
	logger = system.GetLogController()
	event = system.GetEventController()
	time = system.GetTimeController()
	game = system.GetGameController()
	world = game.GetWorld()
	
	if (!event or !time or !game or !world):
		state = Controller.State.FAIL
		return state
		
	ConnectSignals({
		# event.enemy_spawn_wave : SpawnWave
	})
	
	state = Controller.State.ONLINE
	return state

func SpawnWave(count: int) -> void:
	logger.message(self, "spawning enemy wave")
	event.enemy_spawn_wave.disconnect(SpawnWave)
	for i in range(0, count):
		enemies.append(Enemy.new())
	for enemy in enemies:
		enemy.position = Vector2(100, 100)
		add_child(enemy)
		

func FindSpawnPoints() -> Array:
	var spawnPoints: Array
	# fill spawn points array with Vector2 data
	for key in world.GroundMap:
		print(key)
	return spawnPoints
	
func SpreadAwareness(giver: Enemy, reciever: Enemy) -> void:
	reciever.AcceptAwareness(giver.GiveAwareness())
