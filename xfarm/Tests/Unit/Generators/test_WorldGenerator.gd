extends GutTest

class TestWorldGenerator:
	extends GutTest
	
	var system: System = null
	var game: GameController = null
	var world: WorldGenerator = null
	
	func before_all():
		gut.p("Setting up testing environment")
		system = System.new()
		system.name = "System"
		add_child(system)
		game = system.GetGameController()
		
		
	func test_WorldGeneratorExists():
		world = game.GetWorld()
		assert_not_null(world)
		
	func test_HasTextureGenerator():
		assert_not_null(world.generator)
