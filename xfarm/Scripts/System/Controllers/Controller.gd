class_name Controller extends Node2D

const ONLINE = "online"
const OFFLINE = "offline"
const FAIL = "fail"

enum ControllerState {
	OFFLINE,
	ONLINE,
	FAIL
}

var EnemyControllerType = EnemyController
var PlayerControllerType = PlayerController

var ControllerStatus: Dictionary = {
	ONLINE: ControllerState.ONLINE,
	OFFLINE: ControllerState.OFFLINE,
	FAIL: ControllerState.FAIL
}

var status = ControllerStatus[OFFLINE]

func _ready() -> void:
	if (System.GetLogController()):
		System.GetLogController().message(self, "online")
	else: # we are the log controller
		print(">>> LogController: online")

func ConnectSignals(signal_map: Dictionary) -> void:
	for sig in signal_map:
		sig.connect(signal_map[sig])
	System.GetLogController().message(self, "signals connected")
	return
		

func GetControllerStatus() -> String:
	if status == ControllerState.ONLINE: return ONLINE
	if status == ControllerState.OFFLINE: return OFFLINE
	else: return FAIL
