class_name Controller extends Node2D

var system: System = System.Get()

enum State {
	OFFLINE = 0,
	ONLINE = 1,
	FAIL = -1
}

var state: Controller.State
var signals: Array
var allocations: Array[Variant]

func _ready() -> void:
	if (!system):
		# we are system
		print("SYSTEM COMING ONLINE")
	elif (system.GetLogController()):
		system.GetLogController().message(self, "online")
	else: # we are the log controller
		print(">>> LogController: online")
	
func Initialize() -> Controller.State:
	state = Controller.State.ONLINE
	return state

func ConnectSignals(signal_map: Dictionary) -> void:
	for sig in signal_map:
		sig.connect(signal_map[sig])
		signals.append(signal_map[sig])

	# should be safe to use at this point
	system.GetLogController().message(self, "signals connected")
	return

func GetState() -> Controller.State:
	return state

func SetState(state_: Controller.State) -> void:
	state = state_

func GetAllocations() -> Array[Variant]:
	return allocations

func shutdown() -> Controller.State:
	for allocation in allocations:
		if (allocation):
			allocation.free()
		else:
			state = Controller.State.FAIL
	state = Controller.State.OFFLINE
	return state

func _exit_tree() -> void:
	shutdown() # might need to not do this?
