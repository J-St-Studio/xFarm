class_name Tile extends Spawnable

var tile_texture_1: Resource = preload("res://Assets/PixelArt/ground_tile_1.png")
var tile_texture_2: Resource = preload("res://Assets/PixelArt/ground_tile_2.png")

func _ready() -> void:
	setTextures([
		tile_texture_1,
		tile_texture_2
	])
	self.texture = getTexture()
