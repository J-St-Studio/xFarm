class_name Tile extends Sprite2D

var texture_list: Array

func _init(	
			texture_: Texture2D = null, 
			position: Vector2 = Vector2(0, 0),
			rotation: float = 0
												) -> void:
	self.texture = texture_;
	self.position = position;

func _ready() -> void:
	if (self.texture == null):
		self.texture = assignTexture()

func setTextures(textures: Array) -> void:
	texture_list = textures
		
func setTexture(texture_: Texture2D) -> void:
	self.texture = texture_

func assignTexture() -> Texture2D:
	return texture_list[randi_range(0, texture_list.size() - 1)]

func getTexture() -> Texture2D:
	return self.texture
