extends EditorScript

static func at(val: float, decimal: int) -> String:
	return str(val).pad_decimals(2)

#func of(val: float) -> Variant:
	#var data = PrecisionObjectData.new()
	#data.value = val;
	#return data
	#
