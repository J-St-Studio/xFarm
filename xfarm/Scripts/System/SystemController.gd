class_name SystemController extends Node2D

static var Game: GameController = GameController.new()

static func GetGameController() -> GameController:
	return Game
