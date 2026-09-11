#class_name PrecisionObjectData extends EditorScript
#
#var value: float = 0.0;
#
#func _ready(data: float) -> void:
	#value = data
#
#func to(decimal: int) -> String:
	#return str(value).pad_decimals(decimal)
