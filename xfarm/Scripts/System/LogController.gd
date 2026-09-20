# LogController.gd
# Used to log relevant info, currently tightly coupled

class_name LogController extends Node2D

static var Player = preload("res://Scripts/Player/Player.gd")
static var PlayerController = preload("res://Scripts/Player/PlayerController.gd")

const prefix: String = "LOG::"
const NoFunctionName: String = "/NULL"

func _ready() -> void:
	pass
# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	pass

func message(source: Object, message: String, ...args) -> void:
	var tail_data: String = " ";
	for arg in args:
		tail_data += str(arg) + " "
	print(prefix, source.name, ": ", message, tail_data)
	pass

static func LogPlayerState(source: Node, message: String=""):
	var SourceName: String
	var FunctionName: Variant = NoFunctionName
	
	if (source == null):
		SourceName = ""
	else:
		SourceName = source.name
		
	if (get_stack().size() > 2):
		FunctionName = "/" + get_stack()[1].function
	print(
		prefix, 
		SourceName,
		FunctionName, 
		": PlayerState -> ", 
		Player.State.keys()[PlayerController.GetPlayerState()],
		" :: (", message, ")"
	)
	
static func LogInputType(source: Node, message: String=""):
	var SourceName: String
	var FunctionName: Variant = NoFunctionName
	
	if (source == null): 
		SourceName = ""
	else:
		SourceName = source.name
		
	if (get_stack().size() > 2):
		FunctionName = "/" + get_stack()[1].function

	print(
		prefix, 
		SourceName,
		FunctionName,
		": InputType -> ", 
		InputTypes.Types.keys()[InputController.GetControlType()],
		" :: (", message, ")"
	)

func LogGameState(source: Node, message: String=""):
	var SourceName: String
	var FunctionName: Variant = NoFunctionName

	if (source == null): 
		SourceName = ""
	else:
		SourceName = source.name

	if (get_stack().size() > 2):
		FunctionName = "/" + get_stack()[1].function
	
	print(
		prefix,
		SourceName,
		FunctionName, 
		": GameState -> ", 
		GameController.GameState.keys()[GameController.GetCurrentGameState()],
		" :: (", message, ")"
	)
	pass
