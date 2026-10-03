extends GutTest

class TestGameController:
	extends GutTest
	
	var system: System = null
	var game: GameController = null
	
	func before_all():
		gut.p("Setting up testing environment")
		system = System.new()
		system.name = "System"
		add_child(system)
		
	
	func test_ControllerNotNull():
		game = system.GetGameController()
		assert_not_null(game, "should be valid")
		
	func test_WorldGeneratorNotNull():
		assert_not_null(game.GetWorld(), "should be valid")
		
	func test_StartAtMainMenu():
		assert_eq(game.GetCurrentGameState(), GameState.MainMenu, "should be equal")

	func test_CurrentLevevl():
		assert_eq(game.GetCurrentLevel(), GameState.MainMenu, "should be equal")
	
	func test_SetCurrentLevel():
		game.SetCurrentLevel(-1)
		assert_eq(game.GetCurrentLevel(), -1, "should be equal")
		
	func test_StartGame():
		game.StartGame()
		assert_eq(game.GetCurrentGameState(), GameState.UnPaused, "should be equal")
		
	func test_PauseGame():
		game.PauseGame()
		assert_eq(game.GetCurrentGameState(), GameState.Paused, "should be equal")

	func test_UnPauseGame():
		game.PauseGame()
		assert_eq(game.GetCurrentGameState(), GameState.UnPaused, "should be equal")

		
	
