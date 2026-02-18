extends Area2D


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
	LogController.LogMessage(self, "Overlapping with: " + body.name)
	pass
