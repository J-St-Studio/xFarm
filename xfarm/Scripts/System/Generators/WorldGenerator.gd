class_name WorldGenerator extends Controller

var game: GameController
var event: EventController
var logger: LogController
var generator: TextureGenerator

const MapMultiplier: int = 1;
const WorldTileSize: int = 64
const TileStep: int = 64
const PlantDensityDivider: int = 4;
var generateWorld: bool = true

# map bounds
const MapSize: int = 1000;
const MapLeftBound: int = - MapSize * (MapMultiplier);
const MapRightBound: int = MapSize * (MapMultiplier);
const MapUpperBound: int = MapSize * (MapMultiplier);
const MapLowerBound: int = - MapSize * (MapMultiplier);

const BaseTileZIndex = -9999
const BorderTileZIndex = -9998

var PlantMap: Dictionary
var GroundMap: Dictionary
var BuildingMap: Dictionary

# eventually will be assigned by the
# UI controller from the main menu ?
const MapType: int = MapTypes.Dirt
var GrassTexture: Texture2D
var GrassTexture_2: Texture2D
var VariableTexture: Texture2D

func _ready() -> void:
	super._ready()
	Initialize()
	
func _process(delta: float) -> void:
	if (generateWorld and game and game.CurrentGameState == GameState.UnPaused):
		GenerateGameWorld()
		generateWorld = false
	
func Initialize() -> Controller.State:
	name = "WorldGenerator"
	if (!system):
		state = Controller.State.FAIL
		return state
	event = system.GetEventController()
	if (!event):
		state = Controller.State.FAIL
		return state
	logger = system.GetLogController()
	if (!logger):
		state = Controller.State.FAIL
		return state
	generator = TextureGenerator.new(20)
	allocations.append(generator)
	if (!generator):
		state = Controller.State.FAIL
		return state
	game = get_parent()
	if (!game):
		state = Controller.State.FAIL
		return state

	ConnectSignals({
		event.ui_pause_menu_quit_button_pressed: TeardownAll
	})
	
	state = Controller.State.ONLINE
	return state

func GenerateCachedMapTextures() -> void:
	GrassTexture = generator.GenerateTexture({
		TextureGenerator.size: WorldTileSize,
		TextureGenerator.red: 0.2,
		TextureGenerator.green: 0.4,
		TextureGenerator.blue: 0.2,
		TextureGenerator.roughness: randf_range(2, 3),
		TextureGenerator.detail_scale: randf_range(10, 20),
		TextureGenerator.octaves: randf_range(8, 9)
	})

	GrassTexture_2 = generator.GenerateTexture({
		TextureGenerator.size: WorldTileSize,
		TextureGenerator.red: 0.21,
		TextureGenerator.green: 0.4,
		TextureGenerator.blue: 0.2,
		TextureGenerator.roughness: randf_range(2, 3),
		TextureGenerator.detail_scale: randf_range(5, 20),
		TextureGenerator.octaves: randf_range(8, 9)
	})

	VariableTexture = generator.GenerateTexture({
		TextureGenerator.size: WorldTileSize,
		TextureGenerator.red: randf_range(0, 1),
		TextureGenerator.green: randf_range(0, 1),
		TextureGenerator.blue: randf_range(0, 1),
		TextureGenerator.roughness: randf_range(2, 3),
		TextureGenerator.detail_scale: randf_range(0, 20),
		TextureGenerator.octaves: randf_range(0, 20)
	})

func GenerateGameWorld() -> void:
	logger.message(self, "generating game world")
	GenerateCachedMapTextures()

	GenerateBorderTileMap()
	GenerateBaseTileMap()

	GeneratePlants()
	GenerateBuildings()
	# GeneratePaths()
	# GenerateEnemySpawnPoints()
	# GenerateItems()
	# GenerateOtherStuff ...
	return

func GeneratePlants() -> void:
	logger.message(self, "spawning plants")
	# generate plants using the GroundMap to determine where to place them, and the PlantMap to ensure no duplicates are placed
	for location in GroundMap.keys():
		# 10% chance to spawn a plant on a tile
		if location.x > MapLeftBound: return
		if location.x > MapRightBound: return
		if location.y > MapUpperBound: return
		if location.y < MapLowerBound: return

		if (randi_range(0, 100) < 5):
			if (!PlantMap.find_key(location)):
				PlantMap[location] = SpawnPlant(location)

func GetRandomLocation() -> Vector2:
	return Vector2(
		randi_range(MapLeftBound, MapRightBound),
		randi_range(MapUpperBound, MapLowerBound)
	)

func GenerateBaseTileMap() -> void:
	for x in range(MapLeftBound, MapRightBound, TileStep):
		for y in range(MapUpperBound, MapLowerBound, -TileStep):
			var spawn_point: Vector2 = Vector2(x, y)
			var tile: Tile = SpawnTile(choose([GrassTexture, GrassTexture_2]), spawn_point, GetRandomRotation())
			GroundMap[spawn_point] = tile
		pass
	pass

func GenerateBorderTileMap() -> void:
	var border_texture: Texture2D = generator.GenerateBrickTexture()
	for x in range(MapLeftBound * 2, MapRightBound * 2, TileStep):
		for y in range(MapUpperBound * 2, MapLowerBound * 2, -TileStep):
			var spawn_point: Vector2 = Vector2(x, y)
			var tile: Tile = SpawnTile(border_texture, spawn_point)
			GroundMap[spawn_point] = tile
		pass
	pass

func GenerateBuildings() -> void:
	var path_texture: Texture2D = generator.GenerateBrickTexture()

	var tile: Tile = Tile.new(path_texture)
	var tile_2: Tile = Tile.new(path_texture)
	var tile_3: Tile = Tile.new(path_texture)
	var tile_4: Tile = Tile.new(path_texture)

	tile.global_position = Vector2(100, 100)
	tile_2.global_position = Vector2(100, 164)
	tile_3.global_position = Vector2(164, 164)
	tile_4.global_position = Vector2(164, 100)

	add_child(tile)
	add_child(tile_2)
	add_child(tile_3)
	add_child(tile_4)

	BuildingMap[tile.global_position] = tile;
	BuildingMap[tile_2.global_position] = tile_2;
	BuildingMap[tile_3.global_position] = tile_3;
	BuildingMap[tile_4.global_position] = tile_4;
	return

func SpawnTile(texture: Texture2D, location: Vector2 = Vector2(0, 0), rotation: float = 0.0) -> Tile:
	var tile: Tile = Tile.new(texture, location, rotation)
	add_child(tile)
	return tile

func PlaceTile(tile: Tile, location: Vector2, rotation: float = 0.0):
	tile.position = location
	tile.rotation = rotation

func SpawnEntity(entity: Entity, parameters: EntityParams) -> Node2D:
	var new_entity = entity.instantiate()
	return new_entity

func SpawnPlant(location: Vector2) -> Node2D:
	var plant: Plant = Plant.new()
	plant.global_position = location
	add_child(plant)
	return plant

func GetRandomRotation() -> float:
	if (randi_range(0, 1)):
		return PI * 2
	return 0.0

func choose(elements: Array) -> Variant:
	return elements[randi_range(0, elements.size() - 1)]
	
func TeardownAll() -> void:
	logger.message(self, "tearing down game world")
	for tile in GroundMap:
		if (GroundMap[tile]):
			GroundMap[tile].queue_free()
	for plant in PlantMap:
		if (PlantMap[plant]):
			PlantMap[plant].queue_free()
	for building in BuildingMap:
		if (BuildingMap[building]):
			BuildingMap[building].queue_free()
	generateWorld = true
	pass
