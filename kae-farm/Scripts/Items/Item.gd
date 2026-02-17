class_name Item extends Node2D

enum ItemTypes {
	Plants,
	Tools,
	Consumables,
	Generic,
}

var Name: String
var Category: ItemTypes
var Price: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
