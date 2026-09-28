class_name Spawnable extends Sprite2D

var texture_list: Array

func setTextures(textures: Array) -> void:
	for texture in textures:
		texture_list.append(texture)

func getTexture() -> Texture2D:
	return texture_list[randi_range(0, texture_list.size() - 1)]
