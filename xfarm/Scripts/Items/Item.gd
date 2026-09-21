class_name Item extends Node2D

var Name: String
var Category: ItemTypes
var Price: float

var HoverFrequency: float
var HoverAmplitude: float
var TotalTime: float

@onready var ItemArea2D: Area2D = $Area2D
@onready var PlayerCollisionShape: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var ItemCollisionShape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var CharacterBody: CharacterBody2D = $CharacterBody2D

var log = LogController.new()

func _init(item: Dictionary) -> void:
	Name = item["name"]
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HoverFrequency = 0.5
	HoverAmplitude = 15.0
	
	# Connect the Area2D signal to handle pickup detection
	if ItemArea2D and ItemArea2D.has_signal("body_entered"):
		ItemArea2D.body_entered.connect(_on_item_area_2d_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (GameController.GetCurrentGameState() == GameController.GameState.Paused):
		return
	IdleHover(delta)
	pass
	
func IdleHover(delta: float) -> void:
	TotalTime += delta
	position.y = HoverAmplitude * sin(TotalTime * HoverFrequency * TAU + 1 * TAU)
	pass

# Handler for when a body enters the item's area, triggering pickup logic.
func _on_item_area_2d_body_entered(body: Node2D) -> void:
	# Check if the colliding body is likely a player or character type (e.g., CharacterBody2D).
	if body is CharacterBody2D or body is Area2D: # ai generated code lol ^^^
		if InventoryController.IsFull():
			# broadcast inventory full message for UIController
			#UIController.Update(GameController.GameState)
			return
		
		# Log message using assumed global LogController access
		log.message(self, "Item picked up by: ", body.name)
		# wow it re-used my own code ^^^
		# Delete the item instance from the scene tree
		queue_free()

func SetName(value: String) -> void:
	Name = value
	
func SetCategory(value: ItemTypes) -> void:
	Category = value
	
func SetPrice(value: float) -> void:
	Price = value
