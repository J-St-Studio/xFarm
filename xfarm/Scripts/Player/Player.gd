# PlayerStatus.gd

class_name Player extends Entity

var logger: LogController
var game: GameController
var generator: TextureGenerator

var playerTexture: Texture2D
var characterBody: CharacterBody2D
var playerSprite: Tile
var collisionShape: CollisionShape2D
var camera: Camera2D

static var state: State

func _ready() -> void:
	super._ready()
	Initialize()
	logger.message(self, "I am alive!")
	logger.message(self, "Game state: ", game.GetCurrentGameState())
	logger.message(self, "location: ", position)
	pass
	
func _process(delta: float) -> void:
	pass

func Initialize() -> Player.State:
	logger = system.GetLogController()
	game = system.GetGameController()
	generator = TextureGenerator.new(10)

	playerTexture = generator.GenerateTexture({
		TextureGenerator.size: 64,
		TextureGenerator.red: 1,
		TextureGenerator.green: 0,
		TextureGenerator.blue: 0,

	})
	playerSprite = Tile.new()
	playerSprite.setTexture(playerTexture)
	characterBody = CharacterBody2D.new()
	collisionShape = CollisionShape2D.new()
	camera = Camera2D.new()
	
	state = IsOnline()
	if (state == Player.State.ERROR):
		logger.message(self, "CRITICAL ERROR, ABORTING")
		return state
	
	# good to build the player
	add_child(characterBody)
	
	characterBody.add_child(playerSprite)
	camera.ignore_rotation = true
	camera.enabled = true
	camera.position_smoothing_enabled = true
	characterBody.add_child(camera)
	characterBody.add_child(collisionShape)

	return state

func IsOnline() -> State:
	if (
		!logger or 
		!game or 
		!generator or 
		!playerTexture or
		!playerSprite or 
		!characterBody or
		!collisionShape or
		!camera
	):
		return Player.State.ERROR
	return Player.State.IDLE

func GetState() -> State:
	return state
