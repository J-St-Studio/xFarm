extends GutTest

class TestGameController:
	extends GutTest
	
	var System = load("res://Scripts/System/Controllers/SystemController.gd")
	var GameState = load("res://Scripts/System/Controllers/Game/GameState.gd")
	
	var system = null
	var game = null
	
	func before_all():
		system = System.new()
		system.Initialize()
		game = system.GetGameController()
		game.Initialize()
		
	func test_ControllerNotNull():
		assert_not_null(game, " exists")
		
	func test_WorldGeneratorNotNull():
		assert_not_null(game.GetWorld())
		
	func test_StartAtMainMenu():
		assert_eq(game.GetCurrentGameState(), GameState.MainMenu)
		
	func test_StartGame():
		game.StartGame()
		assert_eq(game.GetCurrentGameState(), GameState.UnPaused)
		
	func test_PauseGame():
		game.PauseGame()
		assert_eq(game.GetCurrentGameState(), GameState.Paused)

	func test_UnPauseGame():
		game.PauseGame()
		assert_eq(game.GetCurrentGameState(), GameState.UnPaused)
	
