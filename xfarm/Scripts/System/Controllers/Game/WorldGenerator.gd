class_name WorldGenerator extends Controller

var EC = System.GetEventController()
var LC = System.GetLogController()

const MapMultiplier: int = 1;
const MapSize: int = 5000;

# map bounds
const MapLeftBound: int = -MapSize * (MapMultiplier);
const MapRightBound: int = MapSize * (MapMultiplier);
const MapUpperBound: int = MapSize * (MapMultiplier);
const MapLowerBound: int = -MapSize * (MapMultiplier);

const PlantDensityDivider: int = 4; 

var PlantMap: Dictionary
var GroundMap: Dictionary

var assigning_game_controller: bool = true

func _ready() -> void:
	LC.message(self, "WorldGenerator initialized")
	ConnectSignals({
		EC.world_generate_world: GenerateGameWorldResponse,
	})
	EC.BroadcastWorldGenerateWorld()
	# EC.world_generate_world.disconnect(GenerateGameWorldResponse)

# _process

func GenerateGameWorldResponse() -> void:
	LC.message(self, "generating game world")
	GenerateTileMap()
	GeneratePlants(MapSize / PlantDensityDivider)
	# gen plants ( quantity, startpos, endpos)
	# GenerateBuildings()
	# GenerateEnemySpawnPoints()
	# GenerateItems()
	# GenerateMisc ...
	return

func GeneratePlants(quantity: int) -> void:
	for i in range(0, quantity):
		var location: Vector2 = getRandomLocation()	
		if (!PlantMap.find_key(location)):
			PlantMap[location] = SpawnPlant(location)
		else:
			i = i - 1 # just try again
		pass
	pass
pass

func getRandomLocation() -> Vector2:
	return Vector2 (
		randi_range(MapLeftBound, MapRightBound), 
		randi_range(MapUpperBound, MapLowerBound)
	)

func GenerateTileMap() -> void:
	for x in range(MapLeftBound, MapRightBound, 64):
		for y in range(MapUpperBound, MapLowerBound, -64):
			var spawn_point: Vector2 = Vector2(x, y)
			GroundMap[spawn_point] = SpawnTile(spawn_point)
		pass
	pass
## end

func SpawnTile(location: Vector2) -> Tile:
	var tile: Tile = Tile.new()
	tile.global_position = location
	if (randi_range(0, 1)): tile.global_rotation = PI * 2
	add_child(tile)
	return tile

func SpawnEntity(entity: Entity, parameters: EntityParams) -> Node2D:
	var new_entity = entity.instantiate()
	return new_entity

func SpawnPlant(location: Vector2) -> Node2D:
	var plant: Plant = Plant.new()
	plant.global_position = location
	add_child(plant)
	return plant

	
