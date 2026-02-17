class_name Item extends Node2D

var Name: String
var Category: ItemTypes
var Price: float

@onready var ItemArea2D: Area2D = $Area2D
@onready var PlayerCollisionShape: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var ItemCollisionShape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var CharacterBody: CharacterBody2D = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LogController.LogMessage(self, "Item Ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	IdleHover(delta)

	IsOverlapped()
	pass
	
func IdleHover(delta: float) -> void:
	pass

func SetName(value: String) -> void:
	Name = value
	
func SetCategory(value: ItemTypes) -> void:
	Category = value
	
func SetPrice(value: float) -> void:
	Price = value
	
func IsOverlapped() -> void:
	if (ItemArea2D.overlaps_area(CharacterBody)):
		print("Collision with Player!")
		pass
	pass
