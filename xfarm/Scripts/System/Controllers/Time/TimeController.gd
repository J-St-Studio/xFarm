class_name TimeController extends Controller
var precision = preload("res://Scripts/System/Utilities/precision.gd")

signal one_second_elapsed

var WorldTime: float = 0.0;
var GlobalDelta: float = 0.0;
const WorldTimeReportInterval: int = 1;
var LastLoggedSecond: int = -1; # Tracks the last integer second logged to prevent skipping ticks
const Minute: int = 60.0;
const Hour: int = Minute * 60;
const Day: int = Hour * 24;
static var CurrentWorldTime: String; # Ideally get this represented in UI in a 24HR clock

func _ready() -> void:
	super._ready()
	return

func _process(delta: float) -> void:
	GlobalDelta = delta;
	if System.GetGameController().GamePaused(): 
		return
	AdvanceWorldTime()
	return

func AdvanceWorldTime() -> void:
	var old_world_time = WorldTime;
	WorldTime += 1 * GlobalDelta;
	# Check if we have crossed an integer second boundary since the last log
	var current_second = floor(WorldTime);
	if (current_second > LastLoggedSecond):
		LastLoggedSecond = int(current_second);
		one_second_elapsed.emit()
		print("WorldTime: ", GetWorldTimeAsString(0))

func GetWorldTimeAsString(_precision: int = 0) -> String:
	return precision.of(WorldTime, _precision)

func GetWorldTime() -> float:
	return WorldTime
