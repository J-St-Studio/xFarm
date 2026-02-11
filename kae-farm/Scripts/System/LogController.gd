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
	
static func LogPlayerState(source: Node, function=null, message: String=""):
	print(
		prefix, 
		source.name,
		"/", function.name, 
		": PlayerState -> ", 
		PlayerStatus.State.keys()[PlayerController.GetPlayerState()],
		" :: (", message, ")"
	)
	
static func LogInputType(source: Node, function=null, message: String=""):
	var FunctionName: String = "/" + function.name
	var SourceName: String = source.name
	
	if (function.name == null): FunctionName = ""
	if (source.name == null): SourceName = ""
	
	print(
		prefix, 
		SourceName,
		FunctionName,
		": InputType -> ", 
		InputTypes.Types.keys()[InputController.GetControlType()],
		" :: (", message, ")"
	)

func LogGameState(source: Node, function=null, message: String=""):
	print(
		prefix, 
		source.name,
		"/", function.name, 
		": GameState -> ", 
		GameController.GameState.keys()[GameController.GetCurrentGameState()],
		" :: (", message, ")"
	)
	pass
