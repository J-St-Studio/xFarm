class_name Enemy extends Entity

var awareness: float
var goals: Dictionary

var receptionZone: Area2D

var awarenessThresholds: Array[int]

func _init() -> void:
	receptionZone = Area2D.new()
	receptionZone.size = 100
	awarenessThresholds = [
		1, 2, 3, 4, 5
	]
	return

func _ready() -> void:
	add_child(receptionZone)
	return
	
func _process(delta: float) -> void:
	return

func _exit_tree() -> void:
	return

func ParseGoals() -> void:
	return

# The more aware an enemy becomes of your activities,
# the more likely their goals will shift towards hunting and
# attacking you as opposed to tending to their lives.

func AcceptAwareness(awareness_: float) -> void:
	awareness = awareness_

func GiveAwareness() -> float:
	return awareness
