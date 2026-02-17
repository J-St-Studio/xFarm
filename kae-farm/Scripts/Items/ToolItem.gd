class_name Tool extends Item

var Durability: float
var Strength: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SetDurability(value: float) -> void:
	Durability = value
	
func SetStrength(value: float) -> void:
	Strength = value
