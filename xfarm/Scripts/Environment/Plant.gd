class_name Plant extends Spawnable

var plant_texture_1: Resource = preload("res://Assets/PixelArt/plant_1.png")

func _ready() -> void:
	setTextures([plant_texture_1])
	self.texture = getTexture()
