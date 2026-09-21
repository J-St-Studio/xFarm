class_name AudioController extends Controller

func _ready() -> void:
	SystemController.GetLogController().message(self, "online")
	pass
	
