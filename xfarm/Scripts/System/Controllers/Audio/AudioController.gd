class_name AudioController extends Controller

var event: EventController

func _ready() -> void:
	super._ready()
	Initialize()
	
func Initialize() -> Controller.State:
	if (!system): 
		state = Controller.State.FAIL
		return state
	event = system.GetEventController()
	if (!event):
		state = Controller.State.FAIL
		return state
		
	state = Controller.State.ONLINE
	return state
