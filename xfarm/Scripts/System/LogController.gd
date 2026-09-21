# LogController.gd
# Used to log relevant info, currently tightly coupled

class_name LogController extends Controller

const prefix: String = ">>> "
const NoFunctionName: String = "/NULL"

func _ready() -> void:
	message(self, "online")
	pass
# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	pass

func message(source: Object, message: String, ...args) -> void:
	var tail_data: String = " ";
	for arg in args:
		tail_data += str(arg) + " "
	if (source and source.name != null):
		print(prefix, source.name, ": ", message, tail_data)
	else:
		print(prefix, "UNKNOWN_SOURCE", ": ", message, tail_data)
	pass
