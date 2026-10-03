extends GutTest

class TestGameController:
	extends GutTest
	
	var system: Controller = null
	var game: Controller = null
	
	func before_all():
		system = System.new()
		system.Initialize()

		game = system.GetGameController()
		game.Initialize()
		
	func after_all():
		game.shutdown()
		assert_null(game.GetWorld(), "should be null")
		game.free()
		assert_null(game, "should be null")
		game.queue_free()
		await tree_exited
		game = null

		system.shutdown()
		system.free()
		system = null
		
	func test_ControllerNotNull():
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

		
	
