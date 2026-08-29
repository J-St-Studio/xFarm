class_name Item extends Node2D

var Name: String
var Category: ItemTypes
var Price: float
var Position: Vector2

var HoverFrequency: float
var HoverAmplitude: float
var TotalTime: float

@onready var ItemArea2D: Area2D = $Area2D
@onready var PlayerCollisionShape: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var ItemCollisionShape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var CharacterBody: CharacterBody2D = $CharacterBody2D

func _init(item: Dictionary) -> void:
	Name = item["Name"]
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HoverFrequency = 0.5
	HoverAmplitude = 15.0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (GameController.GetCurrentGameState() == GameController.GameState.Paused): return
	IdleHover(delta)
	pass
	
func IdleHover(delta: float) -> void:
	TotalTime += delta
	position.y = HoverAmplitude * sin(TotalTime * HoverFrequency * TAU + 1 * TAU)
	pass

func SetName(value: String) -> void:
	Name = value
	
func SetCategory(value: ItemTypes) -> void:
	Category = value
	
func SetPrice(value: float) -> void:
	Price = value
