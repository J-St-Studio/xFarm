class_name PlantItem extends Consumable


var HealingValue: float
var HungerValue: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	HealingValue = 1 * Potency
	HungerValue = HealingValue
	#LogController.LogMessage(self, "Plant Item Ready")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	pass

func GetHungerValue() -> float:
	return HungerValue

func GetHealingValue() -> float:
	return HealingValue

func SetHungerValue(value: float) -> void:
	HungerValue = value
	
func SetHealingValue(value: float) -> void:
	HealingValue = value
