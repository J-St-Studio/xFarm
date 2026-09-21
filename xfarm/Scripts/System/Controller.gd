class_name Controller extends Node2D

const ONLINE = "online"
const OFFLINE = "offline"
const FAIL = "fail"

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

var status = ControllerStatus[OFFLINE]

func GetControllerStatus() -> String:
	if status == ControllerState.ONLINE: return ONLINE
	if status == ControllerState.OFFLINE: return OFFLINE
	else: return FAIL
