class_name CameraController extends Controller

var camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Initialize()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Initialize() -> int:
	camera = Camera2D.new()
	camera.enabled = true
	camera.ignore_rotation = true
	camera.position_smoothing_enabled = true
	state = Controller.State.ONLINE
	return state
