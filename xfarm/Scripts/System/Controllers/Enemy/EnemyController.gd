class_name EnemyController extends Controller

var game = System.GetGameController()
var world = game.GetWorld()
var time = System.GetTimeController()
var event = System.GetEventController()

var enemy_one: PackedScene = preload("res://Scenes/enemy.tscn")


signal spawn_enemy_wave

func _ready() -> void:
	super._ready()
	ConnectSignals({
		event.enemy_spawn_wave : SpawnWave
	})
	pass

func _process(delta: float) -> void:
	if int(time.GetWorldTime()) % 10 == 0: # AND signal connected
		event.BroadcastEnemySpawnWave()
		event.enemy_spawn_wave.disconnect(SpawnWave)
	else:
		event.enemy_spawn_wave.connect(SpawnWave)
		# need a oneshot implementation
func SpawnWave() -> void:
		print("spawn enemy wave")


func FindSpawnPoints() -> Array:
	var spawnPoints: Array
	# fill spawn points array with Vector2 data
	for key in world.GroundMap:
		print(key)
	return spawnPoints
