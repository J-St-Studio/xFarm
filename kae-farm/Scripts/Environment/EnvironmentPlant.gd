class_name EnvironmentPlant extends EnvironmentObject

enum PlantStates {
	Healthy,
	Diseased,
	Dry,
	Dead,
}
var GrowTime: float
var CurrentHealth: float
var MaxHealth: float
var PlantState: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Name = "Unamed Plant"
	GrowTime = 100.0
	CurrentHealth = 100.0
	MaxHealth = 100.0
	PlantState = PlantStates.Healthy
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
