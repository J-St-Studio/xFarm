class_name WorldGenerator extends Controller

var EC = System.GetEventController()
var LC = System.GetLogController()

const MapMultiplier: int = 1;
const MapSize: int = 1000;

# map bounds
const MapLeftBound: int = -MapSize * (MapMultiplier);
const MapRightBound: int = MapSize * (MapMultiplier);
const MapUpperBound: int = MapSize * (MapMultiplier);
const MapLowerBound: int = -MapSize * (MapMultiplier);
const TileStep: int = 64

const PlantDensityDivider: int = 4; 

var PlantMap: Dictionary
var GroundMap: Dictionary

var WorldGrid: Array

# eventually will be assigned by the
# UI controller from the main menu
const MapType: int = MapTypes.Dirt

var generatedTextures: Array

func _ready() -> void:
	LC.message(self, "WorldGenerator initialized")
	generatedTextures = GenerateTextures(MapType)
	GenerateGameWorld()

# _process

# buggy, doesn't work as expected
func GenerateTextures(type: int) -> Array:
	var generator = TextureGenerator.new()
	return [
		generator.GenerateGroundTexture(
			randi_range(0, 255), 
			randi_range(0, 255), 
			randi_range(0, 255), 
			randi_range(0, 255)
		),
		generator.GenerateGroundTexture(
			randi_range(0, 255),
			randi_range(0, 255), 
			randi_range(0, 255), 
			randi_range(0, 255)
		),
		generator.GenerateGroundTexture(
			randi_range(0, 255), 
			randi_range(0, 255), 
			randi_range(0, 255), 
			randi_range(0, 255)
		),
	]

func GenerateGameWorld() -> void:
	GenerateGameWorldResponse()

func GenerateGameWorldResponse() -> void:
	LC.message(self, "generating game world")
	GenerateBaseTileMap()
	GeneratePlants()
	# GenerateWalls()
	GeneratePaths()
	# GenerateBuildings()
	# GenerateEnemySpawnPoints()
	# GenerateItems()
	# GenerateMisc ...
	return

func GeneratePlants() -> void:
	print("spawning plants")
	# generate plants using the GroundMap to determine where to place them, and the PlantMap to ensure no duplicates are placed
	for location in GroundMap.keys():
		# 10% chance to spawn a plant on a tile
		if (randi_range(0, 100) < 5):
			if (!PlantMap.find_key(location)):
				PlantMap[location] = SpawnPlant(location)

func getRandomLocation() -> Vector2:
	return Vector2 (
		randi_range(MapLeftBound, MapRightBound), 
		randi_range(MapUpperBound, MapLowerBound)
	)

func GenerateBaseTileMap() -> void:
	# somehow decide what type of tile map we're generating
	# ie: forest, desert, plains, etc
	for x in range(MapLeftBound, MapRightBound, TileStep):
		for y in range(MapUpperBound, MapLowerBound, -TileStep):
			var spawn_point: Vector2 = Vector2(x, y)
			GroundMap[spawn_point] = SpawnDirtTile(spawn_point)
		pass
	pass
## end

func GenerateWalls() -> void:
	# generate upper wall
	for x in range(MapLeftBound, MapRightBound, TileStep):
		var spawn_point: Vector2 = Vector2(x, MapUpperBound)
		GroundMap[spawn_point] = SpawnTile(spawn_point)
	return

func GeneratePaths() -> void:
	var generator: TextureGenerator = TextureGenerator.new()
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
	return

func SpawnTile(location: Vector2) -> Tile:
	print("texture list: ", generatedTextures)
	var tile: DynamicTile = DynamicTile.new(generatedTextures)
	tile.global_position = location
	if (randi_range(0, 1)): tile.global_rotation = PI * 2
	add_child(tile)
	return tile

func SpawnSnowTile(location: Vector2) -> SnowTile:
	var snow_tile: SnowTile = SnowTile.new()
	snow_tile.global_position = location
	if (randi_range(0, 1)): snow_tile.global_rotation = PI * 2
	add_child(snow_tile)
	return snow_tile

func SpawnDirtTile(location: Vector2) -> DirtTile:
	var dirt_tile: DirtTile = DirtTile.new()
	dirt_tile.global_position = location
	if (randi_range(0, 1)): dirt_tile.global_rotation = PI * 2
	add_child(dirt_tile)
	return dirt_tile

func SpawnEntity(entity: Entity, parameters: EntityParams) -> Node2D:
	var new_entity = entity.instantiate()
	return new_entity

func SpawnPlant(location: Vector2) -> Node2D:
	var plant: Plant = Plant.new()
	plant.global_position = location
	add_child(plant)
	return plant

	
