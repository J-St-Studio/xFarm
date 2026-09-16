# LogController.gd

class_name LogController extends EditorScript

static var PlayerStatus = preload("res://Scripts/Player/PlayerStatus.gd")
static var PlayerController = preload("res://Scripts/Player/PlayerController.gd")
static var InputController = preload("res://Scripts/Input/InputController.gd")
static var GameController = preload("res://Scripts/System/GameController.gd")

const prefix: String = "LOG::"
const NoFunctionName: String = "/NULL"

func _ready() -> void:
	pass
# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	pass

func message(source: Object, message: String, ...args) -> void:
	LogMessage(source, message, args)
	pass

static func LogMessage(source: Object, message: String, ...args):
	# build a string of the args?
	var tail_data: String = " ";
	for arg in args:
		tail_data += str(arg) + " "
	print(prefix, source.name, ": ", message, tail_data)
	
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
		PlayerStatus.State.keys()[PlayerController.GetPlayerState()],
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
