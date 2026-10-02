extends GutTest

class TestWorldGenerator:
	extends GutTest
	
	var System = load("res://Scripts/System/Controllers/SystemController.gd")
	var system = null
	var game = null
	var world = null
	
	func before_all():
		system = System.new()
		system.Initialize()
		game = system.GetGameController()
		game.Initialize()
		world = game.GetWorld()
		
	func test_WorldExists():
		assert_not_null(world)
