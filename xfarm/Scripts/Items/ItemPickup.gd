class_name ItemPickup extends Area2D

@onready var sprite_2d: Sprite2D = $"../Sprite2D"

var log: LogController = preload("res://Scripts/System/LogController.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make sure these are enabled (usually are by default)
	monitoring = true
	monitorable = true   # usually not needed for detection, but good to have
	# Connect in code (recommended over editor for reusable scenes)
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	log.message(self.get_parent(), get_parent().name + " picked up by: " + body.get_parent().name)
	get_parent().queue_free()
	pass
