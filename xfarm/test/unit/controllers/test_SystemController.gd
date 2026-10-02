extends GutTest

class TestSystemController:
	extends GutTest		
	
	var System = load("res://Scripts/System/Controllers/SystemController.gd")
	var system = null
	
	func before_all():
		# this never gets called in game code, it gets called for us
		# by adding the script to a node in the scene tree
		system = System.new()
		system.Initialize()
		
	func after_all():
		system.free()
		
	func test_InitializeSystem():
		assert_eq(system.state, 1, " are equal")
		
	func test_IsOnline():
		assert_true(system.IsOnline(), " should be true")
		
	func test_InitializeController():
		var controller: Controller = system.InitializeController(Controller)
		assert_not_null(controller, " is not null")
		controller.free()
	
	func test_InitControllerState():
		var controller: Controller = system.InitializeController(Controller)
		assert_eq(controller.GetControllerState(), 1, " are equal")
		controller.free()
	
	func test_HasLogController():
		var controller: LogController = system.GetLogController()
		assert_not_null(system.GetLogController(), " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
	
	#event = InitializeController(EventController)
	func test_HasEventController():
		var controller: EventController = system.GetEventController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
	
	#input = InitializeController(InputController)
	func test_HasInputController():
		var controller: InputController = system.GetInputController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
	
	#audio = InitializeController(AudioController)
	func test_HasAudioController():
		var controller: AudioController = system.GetAudioController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
	
	#UI = InitializeController(UIController)
	func test_HasUIController():
		var controller: UIController = system.GetUIController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
	
	#game = InitializeController(GameController)
	func test_HasGameController():
		var controller: GameController = system.GetGameController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
	
	#player = InitializeController(PlayerController)
	func test_HasPlayerController():
		var controller: PlayerController = system.GetPlayerController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
		
	#time = InitializeController(TimeController)
	func test_HasTimeController():
		var controller: TimeController = system.GetTimeController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
		
	#enemy = InitializeController(EnemyController)
	func test_HasEnemyController():
		var controller: EnemyController = system.GetEnemyController()
		assert_not_null(controller, " exists")
		assert_eq(controller.GetControllerState(), 1, " are equal")
