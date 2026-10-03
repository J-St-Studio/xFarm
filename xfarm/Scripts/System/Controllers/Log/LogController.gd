# LogController.gd
# Used to log relevant info
class_name LogController extends Controller

const prefix: String = ">>> "
const NoFunctionName: String = "/NULL"

func _ready() -> void:
	super._ready()
	Initialize()

func Initialize() -> Controller.State:
	state = Controller.State.ONLINE
	return state

func message(source: Object, message: Variant, ...args) -> void:
	var tail_data: String = " ";
	for arg in args:
		tail_data += str(arg) + " "
	if (source and source.name != null):
		print(prefix, source.name, ": ", message, tail_data)
	else:
		print(prefix, "UNKNOWN_SOURCE", ": ", message, tail_data)
	pass
