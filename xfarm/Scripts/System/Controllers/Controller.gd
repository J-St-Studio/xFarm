class_name Controller extends Node2D

const ONLINE = 1
const OFFLINE = 0
const FAIL = -1

enum ControllerState {
	OFFLINE,
	ONLINE,
	FAIL
}

var ControllerStatus: Dictionary = {
	ONLINE: ControllerState.ONLINE,
	OFFLINE: ControllerState.OFFLINE,
	FAIL: ControllerState.FAIL
}

var state: int = ControllerStatus[OFFLINE]
var signals: Array

func _ready() -> void:
	if (System.GetLogController()):
		System.GetLogController().message(self, "online")
	else: # we are the log controller
		print(">>> LogController: online")

func ConnectSignals(signal_map: Dictionary) -> void:
	for sig in signal_map:
		sig.connect(signal_map[sig])
		signals.append(signal_map[sig])
	System.GetLogController().message(self, "signals connected")
	return

func GetControllerState() -> int:
	return state
	
func _exit_tree() -> void:
	free()
