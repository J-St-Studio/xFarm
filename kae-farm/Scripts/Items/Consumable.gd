#
# Consumable
# Consumable effect?
# Extend off consumable? ie: Health potion?
# a plant IS a consumable..
# Over-engineering?

# only used for category sake?

# some generic value? Potency?
class_name Consumable extends Item

var Potency: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	pass
