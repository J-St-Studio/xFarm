extends GutTest

class TestSystemController:
	extends GutTest		

	# SystemController is a singleton (System)
	# var SystemController = load("res://Scripts/System/Controllers/SystemController.gd")
	var system: System = null
	
	func before_all():
		gut.p("Setting up testing environment")
		# In the game, System pre-exists in the scene tree.
		# However, we must create it here in the tests.
		system = System.new()
		add_child(system)
		
	func after_all():
		gut.p("Tearing down testing environment")
		var controllers: Array = system.GetControllers()
		var allocations: Array = system.allocations

		system.shutdown()
		assert_eq(system.state, Controller.State.OFFLINE)
		
		for controller in controllers:
			assert_null(controller, "should be null")
		
		for allocation in allocations:
			assert_null(allocation, "should be null")

		system.free()
		assert_null(system, "should be null")
		system = null

	func test_InitializeSystem():
		assert_not_null(system, "should be valid")
		assert_eq(system.state, Controller.State.ONLINE, "should be equal")
		
	func test_IsOnline():
		assert_true(system.IsOnline() == Controller.State.ONLINE, "should be true")

	func test_GetSystemControllers():
		assert_true(system.GetControllers().size() > 0, "should be true")

	func test_ControllersOnline():
		var controllers: Array[Controller] = system.GetControllers()
		for controller in controllers:
			if (controller):
				assert_eq(controller.GetState(), Controller.State.ONLINE, "should be equal")
	
	func test_HasAllocations():
		for allocation in system.allocations:
			assert_not_null(allocation, "should be valid")

	func test_AllocatedControllers():
		assert_eq(system.GetAllocations().size(), system.GetControllers().size(), "should be equal")
		
	func test_InitializeController():
		var controller: Controller = system.InitializeController(Controller)
		assert_not_null(controller, "should be valid")
		assert_eq(controller.GetState(), Controller.State.ONLINE, "should be equal")
		controller.free()

	# func test_HasLogController():
	# 	var controller: LogController = system.GetLogController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetState(), Controller.State.ONLINE, "should be equal")
	
	# func test_HasEventController():
	# 	var controller: EventController = system.GetEventController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
	
	# func test_HasInputController():
	# 	var controller: InputController = system.GetInputController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
	
	# func test_HasAudioController():
	# 	var controller: AudioController = system.GetAudioController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
	
	# func test_HasUIController():
	# 	var controller: UIController = system.GetUIController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
	
	# func test_HasGameController():
	# 	var controller: GameController = system.GetGameController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
	
	# func test_HasPlayerController():
	# 	var controller: PlayerController = system.GetPlayerController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
		
	# func test_HasTimeController():
	# 	var controller: TimeController = system.GetTimeController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
		
	# func test_HasEnemyController():
	# 	var controller: EnemyController = system.GetEnemyController()
	# 	assert_not_null(controller, "should be valid")
	# 	assert_eq(controller.GetControllerState(), ControllerState.ONLINE, "should be equal")
