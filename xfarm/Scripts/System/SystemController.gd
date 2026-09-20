class_name SystemController extends Node2D

static var System: SystemController = SystemController.new()

static var Game: GameController
static var Log: LogController
static var InputC: InputController
static var PlayerC: PlayerController


static var Controllers: Array

func _ready() -> void:
	InitializeSystemController()
	InitializeGameController()

func InitializeControllers() -> bool:
	return false

func InitializeSystemController() -> void:
	Game = GameController.new()
	Log = LogController.new()
	InputC = InputController.new()
	PlayerC = PlayerController.new()
	Log.message(self, "SystemController ready")

func InitializeGameController() -> void:
	Controllers.append(Game)
	add_child(Game)

static func GetGameController() -> GameController:
	return Game

static func GetLogController() -> LogController:
	return Log

static func GetInputController() -> InputController:
	return InputC

static func GetPlayerController() -> PlayerController:
	return PlayerC
	
static func GetControllers() -> Array:
	return Controllers
