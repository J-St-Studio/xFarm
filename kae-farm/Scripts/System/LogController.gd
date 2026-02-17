# LogController.gd

@tool
class_name LogController extends EditorScript

static var PlayerStatus = preload("res://Scripts/Player/PlayerStatus.gd")
static var PlayerController = preload("res://Scripts/Player/PlayerController.gd")
static var InputController = preload("res://Scripts/Input/InputController.gd")
static var GameController = preload("res://Scripts/System/GameController.gd")

const prefix: String = "LOG::"

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	pass
	
static func LogMessage(source: Node, message: String):
	print(prefix, source.name, ": ", message)
	
static func LogPlayerState(source: Node, message: String=""):
	var SourceName: String
	var FunctionName: Variant = "NULL"
	
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
	var FunctionName: Variant = "NULL"
	
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
	var FunctionName: Variant = "NULL"

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
