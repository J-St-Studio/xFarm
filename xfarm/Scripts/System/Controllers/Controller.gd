class_name Controller extends Node2D

var system: System = System.Get()

enum State {
	OFFLINE = 0,
	ONLINE = 1,
	FAIL = -1
}

var state: State = Controller.State.OFFLINE
var signals: Array
var allocations: Array[Variant]

func _ready() -> void:
	if (!System.Get()):
		# we are system
		print("SYSTEM COMING ONLINE")
	elif (System.Get().GetLogController()):
		System.Get().GetLogController().message(self, "online")
	else: # we are the log controller
		print(">>> LogController: online")

	state = Controller.State.ONLINE

func Initialize() -> Controller.State:
	return state

func ConnectSignals(signal_map: Dictionary) -> void:
	for sig in signal_map:
		sig.connect(signal_map[sig])
		signals.append([sig, signal_map[sig]])

	# should be safe to use at this point
	System.Get().GetLogController().message(self, "signals connected")
	return

func GetState() -> Controller.State:
	return state

func SetState(state_: Controller.State) -> void:
	state = state_

func GetAllocations() -> Array[Variant]:
	return allocations

func shutdown() -> Controller.State:
	print(self, " shut down by ", self.get_parent())
	if (allocations.size() <= 0):
		state = Controller.State.OFFLINE
		return state
	for allocation in allocations:
		if (allocation):
			allocation.queue_free()
	

	# chance for a controller to be in fail state
	# before this function is ran. (child shutdown)
	if (state != Controller.State.FAIL):
		state = Controller.State.OFFLINE
	return state

func _exit_tree() -> void:
	shutdown() # might need to not do this?
