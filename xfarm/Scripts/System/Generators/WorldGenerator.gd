class_name WorldGenerator extends Controller

var EC = System.GetEventController()
var LC = System.GetLogController()
var generator = TextureGenerator.new()


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

var GrassTexture: Texture2D = generator.GenerateTexture({
	TextureGenerator.red: 0.2,
	TextureGenerator.green: 0.4,
	TextureGenerator.blue: 0.2,
	TextureGenerator.roughness: randf_range(2, 3),
	TextureGenerator.detail_scale: randf_range(10, 20),
	TextureGenerator.octaves: randf_range(8, 9)
})

var GrassTexture_2: Texture2D = generator.GenerateTexture({
	TextureGenerator.red: 0.21,
	TextureGenerator.green: 0.4,
	TextureGenerator.blue: 0.2,
	TextureGenerator.roughness: randf_range(2, 3),
	TextureGenerator.detail_scale: randf_range(10, 20),
	TextureGenerator.octaves: randf_range(8, 9)
})

var VariableTexture: Texture2D = generator.GenerateTexture({
	TextureGenerator.red: randf_range(0, 0.5),
	TextureGenerator.green: randf_range(0, 0.5),
	TextureGenerator.blue: randf_range(0, 0.5),
	TextureGenerator.roughness: randf_range(2, 3),
	TextureGenerator.detail_scale: randf_range(0, 20),
	TextureGenerator.octaves: randf_range(0, 20)
})

func _ready() -> void:
	LC.message(self, "WorldGenerator initialized")

	generatedTextures = GenerateTextures(MapType)

	GenerateGameWorld()

	# add_child(GrassTile)
	# tile_3.position = Vector2(200, 0)



# _process

# buggy, doesn't work as expected
func GenerateTextures(type: int) -> Array:
	var generator = TextureGenerator.new()
	return [1]

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
			GroundMap[spawn_point] = SpawnWildcardTexture(spawn_point)
		pass
	pass
## end

func GenerateWalls() -> void:
	# generate upper wall
	for x in range(MapLeftBound, MapRightBound, TileStep):
		var spawn_point: Vector2 = Vector2(x, MapUpperBound)
		GroundMap[spawn_point] = SpawnDynamicTile(spawn_point)
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

func SpawnTile(tile: Tile, location: Vector2) -> Tile:
	tile.global_position = location
	add_child(tile)
	return tile

func SpawnDynamicTile(location: Vector2) -> DynamicTile:
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

func SpawnGrassTile(location: Vector2) -> Tile:
	var texture: Texture2D = choose([GrassTexture, GrassTexture_2])
	var tile: Tile = Tile.new(
		texture, location, GetRandomRotation()
	)
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

func SpawnWildcardTexture(location: Vector2) -> Tile:
	var tile: Tile = Tile.new(VariableTexture, location, GetRandomRotation())
	add_child(tile)
	return tile

func GetRandomRotation() -> float:
	if (randi_range(0, 1)):
		return PI * 2
	return 0.0

func choose(elements: Array) -> Variant:
	return elements[randi_range(0, elements.size() - 1)]
