# LogController.gd

@tool
extends EditorScript

static var PlayerStatus = preload("res://Scripts/Player/PlayerStatus.gd")
static var PlayerController = preload("res://Scripts/Player/PlayerController.gd")
static var InputController = preload("res://Scripts/Input/InputController.gd")
static var GameController = preload("res://Scripts/System/GameController.gd")
static var InputTypes = preload("res://Scripts/Input/InputTypes.gd")

const prefix: String = "LOG::"

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	pass
	
static func LogMessage(source: Node, message: String):
	print(prefix, source.name, ": ", message)
	
static func LogPlayerState(source: Node):
	print(prefix, source.name, ": PlayerState -> ", PlayerStatus.State.keys()[PlayerController.GetPlayerState()])
	
static func LogInputType(source: Node):
	print(prefix, source.name, ": InputType -> ", InputTypes.Types.keys()[InputController.GetControlType()])

func LogGameState(source: Node):
	print(prefix, source.name, ": GameState -> ", GameController.GameState.keys()[GameController.GetCurrentGameState()])
	pass
